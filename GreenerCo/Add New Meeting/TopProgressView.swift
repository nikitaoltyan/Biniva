//
//  TopProgressView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.12.2020.
//

import UIKit

class TopProgressView: UIView {
    
    let backImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        return image
    }()
    
    var delegate: TopProgressDelegate?
    var slide: Int!
    
    let closeMark = "xmark"
    let backMark = "chevron.left"

    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubview()
        ActivateLayouts()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlide)))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func ChangeImage(){
        print("Change image function")
        switch slide!{
        case 0:
            backImage.image = UIImage(systemName: closeMark)
        default:
            backImage.image = UIImage(systemName: backMark)
        }
    }

    @objc func NextSlide(){
        print("Slide: \(slide!)")
        delegate?.NextSlide()
    }
}




extension TopProgressView {
    
    func SetSubview(){
        self.addSubview(backImage)
        backImage.image = UIImage(systemName: closeMark)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            backImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            backImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            backImage.heightAnchor.constraint(equalToConstant: 30),
            backImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
