//
//  Onboarding_4_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_4_Cell: UICollectionViewCell {
    
    let titleBlack: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Разрешить отправку уведомлений?"
        return label
    }()
    
    let titleGreen: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Они будут отправляться всего 1 раз в день, вечером"
        return label
    }()
    
    let subtitleGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
        label.text = "С уведомлением ты точно не забудешь записать весь свой мусор"
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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func buttonTap() {
        print("Ask about notifications")
//        button.tap(completion: { (_) in
//            self.delegate?.next(slide: 5)
//        })
    }
    
    @objc
    func skipTap() {
        button.tap(completion: { (_) in
            self.delegate?.next(slide: 4)
        })
    }
}




extension Onboarding_4_Cell {
    func setSubviews() {
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        self.addSubview(skipLabel)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
        skipLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipTap)))
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            skipLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            skipLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            button.bottomAnchor.constraint(equalTo: skipLabel.topAnchor, constant: -17),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            
            subtitleGray.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -38),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            titleGreen.bottomAnchor.constraint(equalTo: subtitleGray.topAnchor, constant: -38),
            titleGreen.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            titleGreen.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
            
            titleBlack.bottomAnchor.constraint(equalTo: titleGreen.topAnchor, constant: -38),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
        ])
    }
}

