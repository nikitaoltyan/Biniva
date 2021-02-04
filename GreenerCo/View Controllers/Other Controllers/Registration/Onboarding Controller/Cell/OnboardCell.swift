//
//  OnboardCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.01.2021.
//

import UIKit

class OnboardCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-40, height: MainConstants.screenWidth-140))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = MainConstants.nearBlack
        label.font = UIFont(name: "SFPro-Bold", size: 23)
        label.textAlignment = .left
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = MainConstants.nearBlack
        label.font = UIFont(name: "SFPro", size: 15)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}





extension OnboardCell {
    
    func SetSubviews(){
        self.addSubview(image)
        self.addSubview(mainLabel)
//        self.addSubview(secondLabel)
    }
    
    func ActivateLayouts(){
        let imageTop: CGFloat = {if MainConstants.screenHeight>700 { return 80 } else { return 65 }}()
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: imageTop),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            mainLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            mainLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
//            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 7),
//            secondLabel.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
//            secondLabel.rightAnchor.constraint(equalTo: mainLabel.rightAnchor)
        ])
    }
}
