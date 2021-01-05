//
//  AddPaperView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class AddItemView: UIView {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubview()
        ActivateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension AddItemView {

    func SetSubview(){
        self.addSubview(image)
    }

    func ActivateConstraints(){
        var gap: CGFloat!
        if MainConstants.screenHeight > 700 {gap = 10} else {gap = 5}
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: gap),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -gap),
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: gap),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -gap)
        ])
    }

}
