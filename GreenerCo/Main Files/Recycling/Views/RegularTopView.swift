//
//  RegularTopView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.01.2021.
//

import UIKit

class RegularTopView: UIView {

    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.white
        label.textAlignment = .left
        label.font = UIFont(name: "Palatino-Bold", size: 35.0)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}






extension RegularTopView {
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(mainView)
        self.addSubview(pageLabel)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 97),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            pageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15)
        ])
    }
}
