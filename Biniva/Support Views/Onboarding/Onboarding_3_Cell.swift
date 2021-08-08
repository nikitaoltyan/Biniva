//
//  Onboarding_3_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_3_Cell: UICollectionViewCell {
    
    let slideNumber: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 14)
        label.text = "3/6"
        return label
    }()
    
    let progressView: ProgressView = {
        let height: CGFloat = 320
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: height, height: height))
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
        label.text = NSLocalizedString("onboarding_3_title", comment: "title of third onboarding cell")
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
        label.text = NSLocalizedString("onboarding_3_green_title", comment: "the green part of that title")
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
        label.text = NSLocalizedString("onboarding_3_subtitle", comment: "the brief description of the feature")
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
        progressView.update(addWeight: 995)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func buttonTap() {
        button.tap(completion: { (_) in
            self.delegate?.next(slide: 3)
        })
    }
}




extension Onboarding_3_Cell {
    func setSubviews() {
        self.addSubview(slideNumber)
        self.addSubview(progressView)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    func activateLayouts() {
        let sliderTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 20
            case 736: return 30
            default: return 50
            }
        }()
        
        let progressTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 35
            case 736: return 40
            default: return 130
            }
        }()
        
        let titleTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 0
            case 736: return 10
            default: return 27
            }
        }()
        
        let subtitleTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 15
            case 736: return 20
            default: return 30
            }
        }()
        
        let buttonBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -24
            case 736: return -35
            default: return -58
            }
        }()
        
        NSLayoutConstraint.activate([
            slideNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: sliderTopConstant),
            slideNumber.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: progressTopConstant),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            
            titleBlack.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: titleTopConstant),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 15),
            titleGreen.leftAnchor.constraint(equalTo: titleBlack.leftAnchor),
            titleGreen.rightAnchor.constraint(equalTo: titleBlack.rightAnchor),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: subtitleTopConstant),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonBottomConstant),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
        ])
    }
}
