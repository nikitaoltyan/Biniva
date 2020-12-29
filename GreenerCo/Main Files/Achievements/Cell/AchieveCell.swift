//
//  AchieveCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 08.11.2020.
//

import UIKit

class AchieveCell: UICollectionViewCell {
    
    var achieveImage: UIImageView!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 242/255, green: 252/255, blue: 250/255, alpha: 1)
        SetImage()
    }
    
    func SetImage(){
        let image = UIImageView()
        self.addSubview(image)
        achieveImage = image
        let size = self.frame.height - 16
        achieveImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            achieveImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            achieveImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            achieveImage.widthAnchor.constraint(equalToConstant: size),
            achieveImage.heightAnchor.constraint(equalToConstant: size)
        ])
        achieveImage.layer.masksToBounds = true
        achieveImage.layer.cornerRadius = 7
    }
}
