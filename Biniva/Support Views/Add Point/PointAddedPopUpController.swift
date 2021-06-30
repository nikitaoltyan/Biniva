//
//  PointAddedPopUpController.swift
//  Biniva
//
//  Created by Nick Oltyan on 30.06.2021.
//

import UIKit

class PointAddedPopUpController: UIViewController {
    
    let popUpView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 315, height: 400))
            .with(autolayout: false)
            .with(bgColor: Colors.background)
            .with(cornerRadius: 16)
        
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    
    let addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
            .with(cornerRadius: 12)
        
        button.setTitle("Отлично!", for: .normal)
        button.setTitleColor(Colors.background, for: .normal)
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }

    @objc
    func close() {
        
    }
}






extension PointAddedPopUpController {
    func setSubviews() {
        view.addSubview(popUpView)
        
        popUpView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.widthAnchor.constraint(equalToConstant: popUpView.frame.width),
            popUpView.heightAnchor.constraint(equalToConstant: popUpView.frame.height)
        ])
    }
}
