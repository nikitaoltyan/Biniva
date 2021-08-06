//
//  Onboarding_1_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 02.07.2021.
//

import UIKit

class Onboarding_1_Cell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let height: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return MainConstants.screenHeight/2+110
            case 736: return MainConstants.screenHeight/2+110
            default: return MainConstants.screenHeight/2+60
            }
        }()
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: height))
            .with(autolayout: false)
        image.image = UIImage(named: NSLocalizedString("onboarding_1_image_name", comment: "Name of localized image"))
        return image
    }()
    
    let gradientView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 100))
            .with(autolayout: false)
        return view
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientView.frame
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor,
                           Colors.background.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
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
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("onboarding_1_title", comment: "title of first onboarding cell")
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
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("onboarding_1_green_title", comment: "the green part of that title")
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
        label.text = NSLocalizedString("onboarding_1_subtitle", comment: "subtitle")
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("onboarding_next", comment: "the Continue label")
        return view
    }()
    
    let descGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = NSLocalizedString("onboarding_1_description", comment: "description before conditions")
        return label
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 12)
        label.isUserInteractionEnabled = true
        label.text = NSLocalizedString("onboarding_1_conditions", comment: "selectable Conditions label")
        return label
    }()
    
    var delegate: OnbordingDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func buttonTap() {
        button.tap(completion: { (_) in
            self.delegate?.next(slide: 1)
        })
    }
    
    @objc
    func conditions() {
        if let url = URL(string: NSLocalizedString("paywall_privacy_policy_url", comment: "privacy policy link")) {
            UIApplication.shared.open(url)
        }
    }
}







extension Onboarding_1_Cell {
    func setSubviews() {
        self.addSubview(imageView)
        self.addSubview(gradientView)
        gradientView.layer.addSublayer(gradient)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        self.addSubview(descGray)
        self.addSubview(conditionsLabel)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
        conditionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(conditions)))
    }
    
    func activateLayouts() {
        let imageTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -70
            case 736: return -60
            default: return 0
            }
        }()
        
        let buttonTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 20
            case 736: return 26
            default: return 40
            }
        }()
        
        let descTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 16
            case 736: return 20
            default: return 25
            }
        }()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: imageTopConstant),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.width),
            
            gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradientView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gradientView.widthAnchor.constraint(equalToConstant: gradientView.frame.width),
            gradientView.heightAnchor.constraint(equalToConstant: gradientView.frame.height),
            
            titleBlack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleBlack.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -5),
            
            titleGreen.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 0),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: 17),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: subtitleGray.bottomAnchor, constant: buttonTopConstant),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            
            descGray.topAnchor.constraint(equalTo: button.bottomAnchor, constant: descTopConstant),
            descGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            descGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            conditionsLabel.topAnchor.constraint(equalTo: descGray.bottomAnchor, constant: 3),
            conditionsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
