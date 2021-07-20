//
//  EmptyImagePinCell.swift
//  Biniva
//
//  Created by Nick Oltyan on 22.06.2021.
//

import UIKit

class ImagePinCell_Empty: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_pin_empty_title", comment: "Title for empty photo states")
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 13)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_pin_empty_subtitle", comment: "subtitle for empty photo states")
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 100))
            .with(autolayout: false)
        let useImage = UIImage(named: "EmptyPhotoState")
        image.image = useImage?.resize(targetSize: CGSize(width: 130, height: 100))
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



extension ImagePinCell_Empty{
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(image)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6),
            title.widthAnchor.constraint(equalToConstant: 190),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.widthAnchor.constraint(equalToConstant: 190),
            
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
        ])
    }
}
