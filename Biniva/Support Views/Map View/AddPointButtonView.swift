//
//  AddPointButton.swift
//  Biniva
//
//  Created by Никита Олтян on 27.06.2021.
//

import UIKit

class AddPointButtonView: UIView {
    
    let horizontalView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 29, height: 2))
            .with(autolayout: false)
            .with(bgColor: Colors.darkGrayText)
        return view
    }()
    
    let verticalView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 29))
            .with(autolayout: false)
            .with(bgColor: Colors.darkGrayText)
        return view
    }()

    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 4)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension AddPointButtonView {
    func setSubviews() {
        self.addSubview(horizontalView)
        self.addSubview(verticalView)
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            horizontalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalView.widthAnchor.constraint(equalToConstant: horizontalView.frame.width),
            horizontalView.heightAnchor.constraint(equalToConstant: horizontalView.frame.height),
            
            verticalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            verticalView.widthAnchor.constraint(equalToConstant: verticalView.frame.width),
            verticalView.heightAnchor.constraint(equalToConstant: verticalView.frame.height)
        ])
    }
}
