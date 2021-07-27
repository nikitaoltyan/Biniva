//
//  AlertCameraView.swift
//  Biniva
//
//  Created by Никита Олтян on 25.07.2021.
//

import UIKit

class AlertCameraView: UIView {
    
    let title: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Semibold", size: 18)
        label.text = "Ты можешь нам помочь!"
        return label
    }()
    
    let subtitle: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
        label.text = "Мы разрабатываем интелектуальную систему автоматического определения мусора с помощью камеры.\n\nПожалуйста, сфотографируй свой мусор и отметь его вес. Спасибо!"
        return label
    }()
    
    let closeButton: CloseCircleView = {
        let view = CloseCircleView()
            .with(autolayout: false)
        return view
    }()
    
    var delegate: alertCameraDelegate?
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth-25, height: 180)
        super.init(frame: useFrame)
        backgroundColor = Colors.sliderGray
        layer.cornerRadius = 9
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    @objc
    func closeAction() {
        closeButton.tap(completion: { _ in
            self.delegate?.closeAlert()
        })
    }
}






extension AlertCameraView {
    
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(closeButton)
        
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17),
            
            closeButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17),
            closeButton.widthAnchor.constraint(equalToConstant: closeButton.frame.width),
            closeButton.heightAnchor.constraint(equalToConstant: closeButton.frame.height),
        ])
    }
}
