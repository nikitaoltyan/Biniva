//
//  Onboarding_5_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit
import CoreLocation

class Onboarding_5_Cell: UICollectionViewCell {
    
    let location = Location()
    
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
        label.text = "Разрешить использование Геопозиции?"
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
        label.text = "Она нужна для простоты использования карты Biniva"
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
        label.text = "Никакой слежки, только удобство"
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = "Разрешить"
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
        label.text = "Пропустить"
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
                self.delegate?.finish()
            })
        })
    }
    
    @objc
    func skipTap() {
        delegate?.finish()
    }
}




extension Onboarding_5_Cell {
    func setSubviews() {
        self.addSubview(icon)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        self.addSubview(skipLabel)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
        skipLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipTap)))
    }
    
    func activateLayouts() {
        let iconTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 70
            case 736: return 120
            default: return 170
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
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: iconTopConstant),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: icon.frame.width),
            icon.heightAnchor.constraint(equalToConstant: icon.frame.height),
            
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
