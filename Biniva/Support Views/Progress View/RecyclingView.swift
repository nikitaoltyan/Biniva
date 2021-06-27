//
//  RecyclingView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 19.04.2021.
//

import UIKit

protocol RecyclingProgressDelegate {
    func update(addWeight weight: Int)
}

class RecyclingView: UIView {
    
    let progressView: ProgressView = {
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 400 }
            else { return 380 }
        }()
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: height, height: height))
            .with(autolayout: false)
        return view
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    var delegate: RecyclingDelegate?

    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func add(){
        delegate?.Add()
    }
}


extension RecyclingView: RecyclingProgressDelegate {
    func update(addWeight weight: Int) {
        progressView.update(addWeight: weight)
    }
}




extension RecyclingView {
    func SetSubviews(){
        self.addSubview(progressView)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(add)))
    }
    
    func ActivateLayouts(){
        let buttonBottomConst: CGFloat = {
            if MainConstants.screenHeight == 736 { return -40 }
            else if MainConstants.screenHeight > 700 { return -66 }
            else { return -30 }
        }()
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonBottomConst),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width)
        ])
    }
}
