//
//  Onboarding_1_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 02.07.2021.
//

import UIKit

class Onboarding_1_Cell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 550))
            .with(autolayout: false)
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
        gradient.colors = [UIColor.orange.cgColor,
                           Colors.background.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    let titleBlack: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Открой новый мир"
        return label
    }()
    
    let titleGreen: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "экологии"
        return label
    }()
    
    let subtitleGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
        label.text = "Сейчас самое время задуматься о том, сколько мы потребляем и что можем с этим сделать"
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = "Начать"
        return view
    }()
    
    let descGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = "Мы очень ценим вашу приватность, поэтому мы хотели, чтобы вы знали, как мы используем продоставленную вами личную информацию. Нажав Начать вы соглашаетесь с"
        return label
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 12)
        label.text = "Условиями"
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
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.width),
            
            gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradientView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gradientView.widthAnchor.constraint(equalToConstant: gradientView.frame.width),
            gradientView.heightAnchor.constraint(equalToConstant: gradientView.frame.height),
            
            titleBlack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleBlack.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
            
            titleGreen.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 0),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: 20),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: subtitleGray.bottomAnchor, constant: 40),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            
            descGray.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            descGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            descGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            conditionsLabel.topAnchor.constraint(equalTo: descGray.bottomAnchor, constant: 3),
            conditionsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
