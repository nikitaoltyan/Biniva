//
//  SettingsTableHeaderView.swift
//  Biniva
//
//  Created by Nick Oltyan on 06.08.2021.
//

import UIKit

class SettingsTableHeaderView: UIView {
    
    let backButton: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 35 }
            else { return 27 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale-5))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
        button.image = UIImage(systemName: "chevron.down")
        button.isUserInteractionEnabled = true
        return button
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
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: textSize)
        return label
    }()
    
    
    var delegate: settingsHeaderDelegate?

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 100)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTitle(title: String) {
        titleBlack.text = title
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.backAction()
        })
    }
}






extension SettingsTableHeaderView {
    private
    func setSubviews() {
        self.addSubview(backButton)
        self.addSubview(titleBlack)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.bottomAnchor.constraint(equalTo: backButton.bottomAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 25)
        ])
    }
}
