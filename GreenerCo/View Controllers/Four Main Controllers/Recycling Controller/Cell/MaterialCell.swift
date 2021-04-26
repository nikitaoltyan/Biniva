//
//  MaterialCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 20.04.2021.
//

import UIKit

class MaterialCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let size: CGFloat = 270
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 28)
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
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 80),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
