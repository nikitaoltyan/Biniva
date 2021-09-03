//
//  AskForPointsHeader.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.09.2021.
//

import UIKit

class AskForPointsHeader: UIView {

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
        label.text = NSLocalizedString("settings_ask_for_points", comment: "")
        return label
    }()
    
    
    let desc: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
        label.text = NSLocalizedString("ask_for_points_header_desc", comment: "")
        return label
    }()
    
    
    var delegate: settingsHeaderDelegate?

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 210)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.backAction()
        })
    }

}






extension AskForPointsHeader {
    private
    func setSubviews() {
        self.addSubview(desc)
        self.addSubview(backButton)
        self.addSubview(titleBlack)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            desc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            
            backButton.bottomAnchor.constraint(equalTo: desc.topAnchor, constant: -25),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.bottomAnchor.constraint(equalTo: backButton.bottomAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 25)
        ])
    }
}
