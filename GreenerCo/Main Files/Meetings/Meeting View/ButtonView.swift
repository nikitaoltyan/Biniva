//
//  ButtonView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 13.01.2021.
//

import UIKit

class ButtonView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.white
        label.textAlignment = .center
        label.text = "Присоедениться"
        label.font = UIFont.init(name: "SFPro-Bold", size: 25.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.orange
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension ButtonView {
    
    func SetSubviews(){
        self.addSubview(label)
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
