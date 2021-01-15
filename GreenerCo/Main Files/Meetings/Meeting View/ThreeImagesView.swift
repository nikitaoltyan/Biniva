//
//  ThreeImagesView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 15.01.2021.
//

import UIKit

class ThreeImagesView: UIView {
    
    let scale: CGFloat = 25
    
    lazy var imageOne: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    lazy var imageTwo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    lazy var imageThree: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}





extension ThreeImagesView {
    
    func SetSubviews(){
        self.addSubview(imageOne)
        self.addSubview(imageTwo)
        self.addSubview(imageThree)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            imageOne.topAnchor.constraint(equalTo: self.topAnchor),
            imageOne.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageOne.heightAnchor.constraint(equalToConstant: imageOne.frame.height),
            imageOne.widthAnchor.constraint(equalToConstant: imageOne.frame.width),
            
            imageTwo.topAnchor.constraint(equalTo: imageOne.topAnchor),
            imageTwo.leftAnchor.constraint(equalTo: imageOne.centerXAnchor, constant: 5),
            imageTwo.heightAnchor.constraint(equalToConstant: imageTwo.frame.height),
            imageTwo.widthAnchor.constraint(equalToConstant: imageTwo.frame.width),
            
            imageThree.topAnchor.constraint(equalTo: imageOne.topAnchor),
            imageThree.leftAnchor.constraint(equalTo: imageTwo.centerXAnchor, constant: 5),
            imageThree.heightAnchor.constraint(equalToConstant: imageThree.frame.height),
            imageThree.widthAnchor.constraint(equalToConstant: imageThree.frame.width)
        ])
    }
}

