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
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-70, height: 53))
            .with(borderWidth: 1.2, color: MainConstants.white.cgColor)
            .with(bgColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "ВОЙТИ С APPLE"
        view.label.font = UIFont(name: "SFPro", size: 16)
        view.label.textColor = MainConstants.white
        return view
    }()
    
    let logInFacebook: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-70, height: 53))
            .with(borderWidth: 1.2, color: MainConstants.white.cgColor)
            .with(bgColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "SIGN IN WITH FACEBOOK"
        view.label.font = UIFont(name: "SFPro", size: 16)
        view.label.textColor = MainConstants.white
        return view
    }()
    
    let logInEmail: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-70, height: 53))
            .with(borderWidth: 1.2, color: MainConstants.white.cgColor)
            .with(bgColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "ВОЙТИ С EMAIL"
        view.label.font = UIFont(name: "SFPro", size: 16)
        view.label.textColor = MainConstants.white
        return view
    }()
    
    var delegate: OnbordingDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.green
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    @objc func OpenApple(){
        delegate?.OpenApple()
    }
    
    @objc func OpenEmail(){
        delegate?.OpenEmail()
    }
}





extension BottomLogInView {
    
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(logInApple)
//        self.addSubview(logInFacebook)
        self.addSubview(logInEmail)
        
        logInApple.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenApple)))
        logInEmail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenEmail)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 30),
            
            logInApple.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logInApple.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 60),
            logInApple.heightAnchor.constraint(equalToConstant: logInApple.frame.height),
            logInApple.widthAnchor.constraint(equalToConstant: logInApple.frame.width),
//
//            logInFacebook.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            logInFacebook.topAnchor.constraint(equalTo: logInApple.bottomAnchor, constant: 17),
//            logInFacebook.heightAnchor.constraint(equalToConstant: logInFacebook.frame.height),
//            logInFacebook.widthAnchor.constraint(equalToConstant: logInFacebook.frame.width),
            
            logInEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logInEmail.topAnchor.constraint(equalTo: logInApple.bottomAnchor, constant: 17),
            logInEmail.heightAnchor.constraint(equalToConstant: logInEmail.frame.height),
            logInEmail.widthAnchor.constraint(equalToConstant: logInEmail.frame.width)
        ])
    }
}
