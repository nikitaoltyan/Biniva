//
//  TakePhotoCell.swift
//  Biniva
//
//  Created by Никита Олтян on 28.06.2021.
//

import UIKit

class TakePhotoCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width - 65, height: self.frame.height - 80))
            .with(autolayout: false)
        image.image = UIImage(systemName: "camera.fill")
        image.tintColor = Colors.background
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.sliderGray
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension TakePhotoCell {
    func setSubviews() {
        self.addSubview(image)
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height)
        ])
    }
}
