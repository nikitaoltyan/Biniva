//
//  MaterialCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 20.04.2021.
//

import UIKit

class MaterialCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let size: CGFloat = {
            if MainConstants.screenHeight > 700 { return 270 }
            else { return 235 }
        }()
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 24)
            .with(autolayout: false)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






extension MaterialCell {
    func SetSubviews(){
        self.addSubview(image)
        self.addSubview(title)
    }
    
    func ActivateLayouts(){
        let imageTopConst: CGFloat = {
            if MainConstants.screenHeight > 700 { return 50 }
            else { return 30 }
        }()
        let titleTopConst: CGFloat = {
            if MainConstants.screenHeight == 736 { return 80 }
            if MainConstants.screenHeight > 700 { return 120 }
            else { return 40 }
        }()
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: imageTopConst),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: titleTopConst),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
