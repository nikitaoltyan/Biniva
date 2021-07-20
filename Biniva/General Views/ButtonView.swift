//
//  ButtonView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 13.01.2021.
//

import UIKit

class ButtonView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.white
        label.textAlignment = .center
        label.text = NSLocalizedString("add_button", comment: "Add title for button")
        label.font = UIFont.init(name: "SFPro-Medium", size: 20.0)
        return label
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    var isActive: Bool = true

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: 55)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 55/2
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension ButtonView {
    
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(label)
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
