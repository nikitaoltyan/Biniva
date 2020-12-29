//
//  AddThirdItemView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 01.11.2020.
//

import UIKit

class AddThirdItemView: UIView {

    override func awakeFromNib() {
        self.backgroundColor = MaterialsColors.paperOrange

        let image: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = MaterialsIcons.paper
            return image
        }()
        self.addSubview(image)
        
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
            ])
        } else {
            const.append(contentsOf: [
                image.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
                image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
            ])
        }
        NSLayoutConstraint.activate(const)
    }

}
