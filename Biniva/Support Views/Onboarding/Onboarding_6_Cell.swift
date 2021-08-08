//
//  Onboarding_6_Cell.swift
//  Biniva
//
//  Created by Nick Oltyan on 08.08.2021.
//

import UIKit

class Onboarding_6_Cell: UICollectionViewCell {
    
    let slideNumber: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 14)
        label.text = "6/6"
        return label
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
        label.text = NSLocalizedString("onboarding_6_title", comment: "Title for that cell")
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
        label.text = NSLocalizedString("onboarding_6_green_title", comment: "Green title for that cell")
        return label
    }()

    let metricPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-40, height: 170))
            .with(autolayout: false)
            .with(cornerRadius: 16)
        view.layer.borderColor = Colors.topGradient.cgColor
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    lazy var metricGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.metricPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let metricTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("onboarding_6_metric_title", comment: "name of metric system")
        return label
    }()
    
    let metricImage: UIImageView = {
        let size: CGFloat = MainConstants.screenWidth/2-50
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: NSLocalizedString("onboarding_6_metric", comment: "name of metric image"))
        return image
    }()
    
    let imperialPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-40, height: 170))
            .with(autolayout: false)
            .with(cornerRadius: 16)
        view.layer.borderColor = Colors.topGradient.cgColor
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    lazy var imperialGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.metricPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let imperialTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("onboarding_6_imperial_title", comment: "name of imperial system")
        return label
    }()
    
    let imperialImage: UIImageView = {
        let size: CGFloat = MainConstants.screenWidth/2-50
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: NSLocalizedString("onboarding_6_imperial", comment: "name of imperial image"))
        return image
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("onboarding_next", comment: "the Continue label")
        view.alpha = 0.2
        return view
    }()
    
    enum metricType {
        case metric
        case imperial
    }
    
    var isButtonActive: Bool = false
    var choosedType: metricType?
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
    func metricAction() {
        guard metricPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        choosedType = .metric
        UIView.animate(withDuration: 0.1, animations: {
            self.metricPlateView.layer.borderWidth = 3
            self.imperialPlateView.layer.borderWidth = 0
            if !(self.isButtonActive) {
                self.button.alpha = 1
            }
        }, completion: { _ in
            self.isButtonActive = true
        })
    }
    
    @objc
    func imperialAction() {
        guard imperialPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        choosedType = .imperial
        UIView.animate(withDuration: 0.1, animations: {
            self.imperialPlateView.layer.borderWidth = 3
            self.metricPlateView.layer.borderWidth = 0
            if !(self.isButtonActive) {
                self.button.alpha = 1
            }
        }, completion: { _ in
            self.isButtonActive = true
        })
    }
    
    @objc
    func buttonAction() {
        guard (isButtonActive) else { return }
        print("Finish")
        switch choosedType {
            case .metric: Defaults.setWeightSystem(typeOfSystem: 0)
            default: Defaults.setWeightSystem(typeOfSystem: 1) // Imperial
        }
        delegate?.finish()
    }
}







extension Onboarding_6_Cell {
    private
    func setSubviews() {
        self.addSubview(slideNumber)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        
        self.addSubview(metricPlateView)
        self.addSubview(metricTitle)
        self.addSubview(imperialPlateView)
        self.addSubview(imperialTitle)
        
        metricPlateView.layer.addSublayer(metricGradient)
        metricPlateView.addSubview(metricImage)
        imperialPlateView.layer.addSublayer(imperialGradient)
        imperialPlateView.addSubview(imperialImage)
        
        self.addSubview(button)
        
        metricPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(metricAction)))
        imperialPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imperialAction)))
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonAction)))
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
        
        let titleTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 90
            case 736: return 100
            default: return 160
            }
        }()
        
        let plateTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 80
            case 736: return 90
            default: return 100
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
            
            titleBlack.topAnchor.constraint(equalTo: self.topAnchor, constant: titleTopConstant),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 30),
            titleGreen.leftAnchor.constraint(equalTo: titleBlack.leftAnchor),
            titleGreen.rightAnchor.constraint(equalTo: titleBlack.rightAnchor),
            
            metricPlateView.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: plateTopConstant),
            metricPlateView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            metricPlateView.widthAnchor.constraint(equalToConstant: metricPlateView.frame.width),
            metricPlateView.heightAnchor.constraint(equalToConstant: metricPlateView.frame.height),
            
            metricTitle.centerXAnchor.constraint(equalTo: metricPlateView.centerXAnchor),
            metricTitle.bottomAnchor.constraint(equalTo: metricPlateView.topAnchor, constant: -10),
            
            metricImage.centerXAnchor.constraint(equalTo: metricPlateView.centerXAnchor),
            metricImage.centerYAnchor.constraint(equalTo: metricPlateView.centerYAnchor),
            metricImage.widthAnchor.constraint(equalToConstant: metricImage.frame.width),
            metricImage.heightAnchor.constraint(equalToConstant: metricImage.frame.height),
            
            imperialPlateView.topAnchor.constraint(equalTo: metricPlateView.topAnchor),
            imperialPlateView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            imperialPlateView.widthAnchor.constraint(equalToConstant: imperialPlateView.frame.width),
            imperialPlateView.heightAnchor.constraint(equalToConstant: imperialPlateView.frame.height),
            
            imperialTitle.centerXAnchor.constraint(equalTo: imperialPlateView.centerXAnchor),
            imperialTitle.bottomAnchor.constraint(equalTo: metricTitle.bottomAnchor),
            
            imperialImage.centerXAnchor.constraint(equalTo: imperialPlateView.centerXAnchor),
            imperialImage.centerYAnchor.constraint(equalTo: imperialPlateView.centerYAnchor),
            imperialImage.widthAnchor.constraint(equalToConstant: imperialImage.frame.width),
            imperialImage.heightAnchor.constraint(equalToConstant: imperialImage.frame.height),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonBottomConstant),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
        ])
    }
}
