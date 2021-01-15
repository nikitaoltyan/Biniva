//
//  BackTopView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 15.01.2021.
//

import UIKit

class BackTopView: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "Big Title Name"
        label.font = UIFont.init(name: "SFPro-Heavy", size: 27.0)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    var delegate: BackTopDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    @objc func BackAction(sender: UIButton!) {
        delegate?.Back()
    }
}





extension BackTopView {
    
    func SetSubviews(){
        self.addSubview(label)
        self.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    func ActivateLayouts(){
        let topConst: CGFloat = {if MainConstants.screenHeight>700 {return 20} else {return 12}}()
        let labelYConst: CGFloat = {if MainConstants.screenHeight>700 {return 20} else {return 0}}()
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: topConst),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelYConst),
            label.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 15)
        ])
    }
}





protocol BackTopDelegate {
    func Back()
}
