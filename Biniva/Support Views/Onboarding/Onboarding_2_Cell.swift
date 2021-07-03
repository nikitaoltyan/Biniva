//
//  Onboarding_2_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_2_Cell: UICollectionViewCell {
    
    let mapImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 60,
                                              height: MainConstants.screenHeight/2 - 40))
            .with(autolayout: false)
            .with(borderWidth: 1, color: Colors.topGradient.cgColor)
            .with(cornerRadius: 13)
        image.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.8
        image.layer.shadowOffset = CGSize(width: 0, height: 2)
        return image
    }()
    
    let titleBlack: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Находи пункты переработки с помощью"
        return label
    }()
    
    let titleGreen: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 32)
        label.text = "Biniva"
        return label
    }()
    
    let subtitleGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
        label.text = "Карта, составленная самими пользователями!"
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
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
            self.delegate?.next(slide: 2)
        })
    }
}




extension Onboarding_2_Cell {
    func setSubviews() {
        self.addSubview(mapImage)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            mapImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 75),
            mapImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mapImage.widthAnchor.constraint(equalToConstant: mapImage.frame.width),
            mapImage.heightAnchor.constraint(equalToConstant: mapImage.frame.height),
            
            titleBlack.topAnchor.constraint(equalTo: mapImage.bottomAnchor, constant: 60),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
            
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 10),
            titleGreen.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 5),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: 25),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -58),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
        ])
    }
}
