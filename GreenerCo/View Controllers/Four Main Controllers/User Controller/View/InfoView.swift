//
//  InfoView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 15.01.2021.
//

import UIKit

class InfoView: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "2"
        label.font = UIFont.init(name: "SFPro-Medium", size: 28.0)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "посещено"
        label.font = UIFont.init(name: "SFPro", size: 6.0)
        return label
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





extension InfoView {
    
    func SetSubviews(){
        self.addSubview(numberLabel)
        self.addSubview(descLabel)
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor),
            descLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}