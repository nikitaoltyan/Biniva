//
//  ArcticleHeaderView.swift
//  Biniva
//
//  Created by Никита Олтян on 13.07.2021.
//

import UIKit

class ArticleHeaderView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 26)
        label.text = "Article Label"
        return label
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 90)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension ArticleHeaderView {
    private
    func setSubviews() {
        self.addSubview(title)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13)
        ])
    }
}
