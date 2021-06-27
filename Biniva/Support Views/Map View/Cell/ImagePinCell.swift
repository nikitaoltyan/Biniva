//
//  ImagePinCell.swift
//  Biniva
//
//  Created by Nikita Oltyan on 22.06.2021.
//

import UIKit

class ImagePinCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
            .with(autolayout: false)
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}



extension ImagePinCell{
    func setSubviews(){
        self.addSubview(image)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

