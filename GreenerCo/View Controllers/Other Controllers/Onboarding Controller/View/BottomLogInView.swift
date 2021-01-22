//
//  BottomLogInView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.01.2021.
//

import UIKit

class BottomLogInView: UIView {

    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let logInApple: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-100, height: 60))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 15
        view.label.text = "Sign in with Apple"
        view.label.textColor = MainConstants.nearBlack
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.green
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}





extension BottomLogInView {
    
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(logInApple)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 30),
            
            logInApple.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logInApple.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 50),
            logInApple.heightAnchor.constraint(equalToConstant: logInApple.frame.height),
            logInApple.widthAnchor.constraint(equalToConstant: logInApple.frame.width)
        ])
    }
}
