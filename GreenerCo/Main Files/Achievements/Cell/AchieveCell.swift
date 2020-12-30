//
//  AchieveCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 08.11.2020.
//

import UIKit

class AchieveCell: UICollectionViewCell {
    
    let achieveImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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




extension AchieveCell {
    func SetSubviews(){
        self.addSubview(achieveImage)
    }
    
    func ActivateLayouts(){
        let imageScale: CGFloat = self.frame.height - 16
        NSLayoutConstraint.activate([
            achieveImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            achieveImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            achieveImage.widthAnchor.constraint(equalToConstant: imageScale),
            achieveImage.heightAnchor.constraint(equalToConstant: imageScale)
        ])
    }
}
