//
//  OtherHeaderView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 24.02.2021.
//

import Foundation
import UIKit


class OtherHeaderView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Medium", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        return label
    }()
    
    let topLine: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearWhite)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearWhite)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.headerColor
        self.addSubview(label)
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            
            topLine.topAnchor.constraint(equalTo: self.topAnchor),
            topLine.leftAnchor.constraint(equalTo: self.leftAnchor),
            topLine.rightAnchor.constraint(equalTo: self.rightAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1),
            
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
