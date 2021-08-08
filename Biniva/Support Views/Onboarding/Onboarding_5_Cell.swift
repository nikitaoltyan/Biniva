//
//  Onboarding_5_Cell.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.07.2021.
//

import UIKit
import CoreLocation

class Onboarding_5_Cell: UICollectionViewCell {
    
    let location = Location()
    
    let slideNumber: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 14)
        label.text = "5/6"
        return label
    }()
    
    let icon: UIImageView = {
        let width: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 160
            default: return 200
            }
        }()
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(autolayout: false)
        image.image = UIImage(named: "onboarding_icon")
        return image
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
        label.text = NSLocalizedString("onboarding_5_title", comment: "title of the fifth onboarding cell")
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
        label.text = NSLocalizedString("onboarding_5_green_title", comment: "the green part of that title")
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
        label.text = NSLocalizedString("onboarding_5_subtitle", comment: "the brief description of the feature")
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("onboarding_next", comment: "the Continue label")
        return view
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
            self.icon.transform = CGAffineTransform.init(translationX: 0, y: -25)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.icon.transform = CGAffineTransform.init(translationX: 0, y: 3)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.07, delay: 0, options: .curveLinear, animations: {
                    self.icon.transform = CGAffineTransform.init(translationX: 0, y: -3)
                }, completion: { (_) in
                    self.animate()
                })
            })
        })
    }
    
    @objc
    func buttonTap() {
        button.tap(completion: { (_) in
            self.location.requestUserLocation(completion: { (_) in
                DispatchQueue.main.async { // Compiling in the main Thread
                    self.delegate?.next(slide: 5)
                }
            })
        })
    }
}




extension Onboarding_5_Cell {
    private
    func setSubviews() {
        self.addSubview(slideNumber)
        self.addSubview(icon)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    private
    func activateLayouts() {
        let sliderTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 20
            case 736: return 30
            default: return 50
            }
        }()
        
        let iconTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 70
            case 736: return 120
            default: return 170
            }
        }()
        
        let buttonBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -24
            case 736: return -35
            default: return -58
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
            slideNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: sliderTopConstant),
            slideNumber.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: iconTopConstant),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: icon.frame.width),
            icon.heightAnchor.constraint(equalToConstant: icon.frame.height),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonBottomConstant),
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
