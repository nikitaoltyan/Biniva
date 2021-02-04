//
//  ItemView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 04.02.2021.
//

import Foundation
import UIKit

class ItemView: UIView {
    
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





extension ItemView {

    func SetSubview(){
        self.addSubview(image)
    }

    func ActivateConstraints(){
        var gap: CGFloat!
        if MainConstants.screenHeight > 700 {gap = 8} else {gap = 6}
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: gap/1.5),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: self.frame.height-gap),
            image.widthAnchor.constraint(equalToConstant: self.frame.width-gap)
        ])
    }

}
