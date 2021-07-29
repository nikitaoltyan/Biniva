//
//  Onboarding_4_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_4_Cell: UICollectionViewCell {
    
    let notifications = Notifications()
    
    let notificationExample: NotificationExampleView = {
        let view = NotificationExampleView()
            .with(autolayout: false)
        return view
    }()
    
    let titleBlack: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 26
            case 736: return 26
            default: return 28
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("onboarding_4_title", comment: "title of fourth onboarding cell")
        return label
    }()
    
    let titleGreen: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 26
            case 736: return 26
            default: return 28
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("onboarding_4_green_title", comment: "the green part of that title")
        return label
    }()
    
    let subtitleGray: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 14
            default: return 16
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: textSize)
        label.text = NSLocalizedString("onboarding_4_subtitle", comment: "the brief description of the feature")
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("onboarding_next", comment: "the Continue label")
        return view
    }()
    
    let skipLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(alignment: .center)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 16)
        label.text = NSLocalizedString("onboarding_skip", comment: "skip button")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var delegate: OnbordingDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseIn, animations: {
            self.notificationExample.transform = CGAffineTransform.init(translationX: 0, y: -20)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.notificationExample.transform = CGAffineTransform.init(translationX: 0, y: 2)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.07, delay: 0, options: .curveLinear, animations: {
                    self.notificationExample.transform = CGAffineTransform.init(translationX: 0, y: -2)
                }, completion: { (_) in
                    self.animate()
                })
            })
        })
    }
    
    @objc
    func buttonTap() {
        print("Ask about notifications")
        button.tap(completion: { (_) in } )
        notifications.requestAuthorization(completion: { (_) in
            print("before deleagate")
            DispatchQueue.main.async {
                self.delegate?.next(slide: 4)
            }
        })
    }
    
    @objc
    func skipTap() {
        self.delegate?.next(slide: 4)
    }
}




extension Onboarding_4_Cell {
    func setSubviews() {
        self.addSubview(notificationExample)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        self.addSubview(skipLabel)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
        skipLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipTap)))
    }
    
    func activateLayouts() {
        let notificationTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 100
            case 736: return 130
            default: return 200
            }
        }()
        
        let skipBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -16
            case 736: return -23
            default: return -50
            }
        }()
        
        let buttonBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -12
            default: return -17
            }
        }()
        
        let titlesBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -20
            case 736: return -25
            default: return -38
            }
        }()
        
        NSLayoutConstraint.activate([
            notificationExample.topAnchor.constraint(equalTo: self.topAnchor, constant: notificationTopConstant),
            notificationExample.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            notificationExample.widthAnchor.constraint(equalToConstant: notificationExample.frame.width),
            notificationExample.heightAnchor.constraint(equalToConstant: notificationExample.frame.height),
            
            skipLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: skipBottomConstant),
            skipLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            button.bottomAnchor.constraint(equalTo: skipLabel.topAnchor, constant: buttonBottomConstant),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            
            subtitleGray.bottomAnchor.constraint(equalTo: button.topAnchor, constant: titlesBottomConstant),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            titleGreen.bottomAnchor.constraint(equalTo: subtitleGray.topAnchor, constant: titlesBottomConstant),
            titleGreen.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleGreen.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            titleBlack.bottomAnchor.constraint(equalTo: titleGreen.topAnchor, constant: titlesBottomConstant),
            titleBlack.leftAnchor.constraint(equalTo: titleGreen.leftAnchor),
            titleBlack.rightAnchor.constraint(equalTo: titleGreen.rightAnchor),
        ])
    }
}

