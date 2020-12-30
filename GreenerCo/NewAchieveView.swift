//
//  NewAchieveView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 30.12.2020.
//

import UIKit

class NewAchieveView: UIView {
    
    let closeImage: UIImageView = {
        let imageScale: CGFloat = 24
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Close)))
        image.image = UIImage(systemName: "xmark")
        image.tintColor = MainConstants.nearBlack
        return image
    }()
    
    let achieveImage: UIImageView = {
        let imageScale: CGFloat = 80
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let achieveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.font = UIFont(name: "SFPro-Medium", size: 25)
        return label
    }()
    
    let achieveDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.font = UIFont(name: "SFPro", size: 16)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc func Close(){
        print("Close")
    }

}




extension NewAchieveView {
    func SetSubviews(){
        self.addSubview(closeImage)
        self.addSubview(achieveImage)
        self.addSubview(achieveLabel)
        self.addSubview(achieveDesc)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            closeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            closeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            closeImage.heightAnchor.constraint(equalToConstant: closeImage.frame.height),
            closeImage.widthAnchor.constraint(equalToConstant: closeImage.frame.width),
            
            achieveImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            achieveImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            achieveImage.heightAnchor.constraint(equalToConstant: achieveImage.frame.height),
            achieveImage.widthAnchor.constraint(equalToConstant: achieveImage.frame.width),
            
            achieveLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            achieveLabel.topAnchor.constraint(equalTo: achieveImage.bottomAnchor, constant: 12),
            
            achieveDesc.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            achieveDesc.topAnchor.constraint(equalTo: achieveDesc.bottomAnchor, constant: 12),
            achieveDesc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            achieveDesc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
}
