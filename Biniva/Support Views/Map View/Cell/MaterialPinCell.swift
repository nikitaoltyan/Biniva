//
//  MaterialPinCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import UIKit

class MaterialPinCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            .with(autolayout: false)
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .orange
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var isCellSelected: Bool = false
}



extension MaterialPinCell{
    func setSubviews(){
        self.addSubview(image)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width)
        ])
    }
}
