//
//  ExtraAddCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 21.04.2021.
//

import UIKit

class ExtraAddCell: UICollectionViewCell {
    
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width-6, height: self.frame.height-6))
            .with(borderWidth: 2, color: Colors.topGradient.cgColor)
            .with(cornerRadius: 10)
            .with(bgColor: .clear)
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    let title: UILabel = {
        let size: CGFloat = {
            if MainConstants.screenHeight > 700 { return 18 }
            else { return 14 }
        }()
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Semibold", size: size)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    let subtitle: UILabel = {
        let size: CGFloat = {
            if MainConstants.screenHeight > 700 { return 13 }
            else { return 10 }
        }()
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(fontName: "SFPro-Regular", size: size)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func select(){
        view.layer.borderWidth = 0
        view.layer.insertSublayer(gradient, at: 0)
        title.textColor = Colors.background
        subtitle.textColor = Colors.background
    }
    
    func unselect(){
        gradient.removeFromSuperlayer()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        title.textColor = Colors.nearBlack
        subtitle.textColor = Colors.darkGrayText
    }
}




extension ExtraAddCell {
    func SetSubviews(){
        self.addSubview(view)
        view.addSubview(title)
        view.addSubview(subtitle)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: view.frame.width),
            view.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -3),
            
            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitle.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 5),
        ])
    }
}
