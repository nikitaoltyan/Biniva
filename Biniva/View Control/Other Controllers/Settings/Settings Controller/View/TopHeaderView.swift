//
//  HeadersViews.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.12.2020.
//

import UIKit

class TopHeaderView: UIView {
    
    let backImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 25))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        image.image = UIImage(systemName: "chevron.left")
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Heavy", size: 31)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        return label
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearWhite)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var delegate: HeaderDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.headerColor
        self.addSubview(backImage)
        self.addSubview(label)
        self.addSubview(bottomLine)
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Back)))
        NSLayoutConstraint.activate([
            backImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            backImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            backImage.heightAnchor.constraint(equalToConstant: backImage.frame.height),
            backImage.widthAnchor.constraint(equalToConstant: backImage.frame.width),
            
            label.leftAnchor.constraint(equalTo: backImage.rightAnchor, constant: 14),
            label.centerYAnchor.constraint(equalTo: backImage.centerYAnchor),
            
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func Back(){
        delegate?.Back()
    }

}





protocol HeaderDelegate {
    func Back()
}
