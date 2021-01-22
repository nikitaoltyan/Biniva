//
//  HeadersViews.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.12.2020.
//

import UIKit

class TopHeaderView: UIView {
    
    let backImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        image.image = UIImage(systemName: "chevron.left")
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "Settings"
        label.font = UIFont(name: "SFPro-Heavy", size: 31)
        return label
    }()

    var delegate: HeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.headerColor
        self.addSubview(backImage)
        self.addSubview(label)
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Back)))
        NSLayoutConstraint.activate([
            backImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            backImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            backImage.heightAnchor.constraint(equalToConstant: 25),
            backImage.widthAnchor.constraint(equalToConstant: 18),
            
            label.leftAnchor.constraint(equalTo: backImage.rightAnchor, constant: 14),
            label.centerYAnchor.constraint(equalTo: backImage.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func Back(){
        delegate?.Back()
    }

}




class OtherHeaderView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "Header"
        label.font = UIFont(name: "SFPro-Medium", size: 23)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.headerColor
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}


protocol HeaderDelegate {
    func Back()
}
