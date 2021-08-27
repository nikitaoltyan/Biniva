//
//  DisabledGeolocationView.swift
//  Biniva
//
//  Created by Nick Oltyan on 26.08.2021.
//

import UIKit

class DisabledGeolocationView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 19)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_disabled_geolocation_title", comment: "")
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_disabled_geolocation_desc", comment: "")
        return label
    }()
    
    let activateButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 230, height: 40))
            .with(autolayout: false)
            .with(bgColor: .lightGray)
            .with(cornerRadius: 12)
        
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.setTitle(NSLocalizedString("map_disabled_geolocation_button", comment: ""), for: .normal)
        button.setTitleColor(Colors.background, for: .normal)
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    
    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 250)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 16
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func activateAction() {
        activateButton.tap(completion: {_ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
    }
}





extension DisabledGeolocationView {
    private
    func setSubviews() {
        self.addSubview(title)
        self.addSubview(desc)
        self.addSubview(activateButton)
        
        activateButton.addTarget(self, action: #selector(activateAction), for: .touchUpInside)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            activateButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            activateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activateButton.heightAnchor.constraint(equalToConstant: activateButton.frame.height),
            activateButton.widthAnchor.constraint(equalToConstant: activateButton.frame.width),
        ])
    }
}
