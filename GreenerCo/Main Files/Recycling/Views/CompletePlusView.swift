//
//  CompletePlusView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.12.2020.
//

import UIKit

class CompletePlusView: UIView {

    let verticalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let horizontalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        SetSubview()
        ActivateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension CompletePlusView {

    func SetSubview(){
        self.addSubview(verticalView)
        self.addSubview(horizontalView)
    }

    func ActivateConstraints(){
        var width: CGFloat!
        var gap: CGFloat!
        
        switch self.frame.width {
        case 58:
            print(58)
            width = 11
            gap = 8
        case 70:
            print(70)
            width = 13
            gap = 6
        default:
            print("default")
            width = 8
            gap = 4
        }
        
        NSLayoutConstraint.activate([
            verticalView.topAnchor.constraint(equalTo: self.topAnchor, constant: gap),
            verticalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalView.widthAnchor.constraint(equalToConstant: width),
            verticalView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -gap),
            
            horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: gap),
            horizontalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalView.heightAnchor.constraint(equalToConstant: width),
            horizontalView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -gap)
        ])
    }

}
