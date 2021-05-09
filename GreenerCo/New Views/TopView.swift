//
//  TopView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.04.2021.
//

import UIKit

class TopView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(fontName: "SFPro-Semibold", size: 28)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: .gray)
            .with(alignment: .left)
            .with(fontName: "SFPro-Regular", size: 18)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()

    
    override init(frame: CGRect) {
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 130 }
            else { return 95 }
        }()
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: height)
        super.init(frame: useFrame)
        self.title.text = "Переработка"
        self.subtitle.text = "поможем сегодня природе?"
        self.backgroundColor = .white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}



extension TopView: TopViewDelegate {
    func UpdateTitles(isRecylcing: Bool) {
        var translation: CGFloat { if (isRecylcing) {return 300} else {return -300}}
        UIView.animate(withDuration: 0.15, animations: {
            self.title.transform = CGAffineTransform.init(translationX: translation, y: 0)
            self.subtitle.transform = CGAffineTransform.init(translationX: translation, y: 0)
        }, completion: { (_) in
            self.title.transform = CGAffineTransform(translationX: -translation, y: 0)
            self.subtitle.transform = CGAffineTransform(translationX: -translation, y: 0)
            UIView.animate(withDuration: 0.15, animations: {
                self.title.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.subtitle.transform = CGAffineTransform.init(translationX: 0, y: 0)
            })
        })
        if (isRecylcing) {
            title.text = "Переработка"
            subtitle.text = "поможем сегодня природе"
        } else {
            title.text = "Твои успехи"
            subtitle.text = "продолжай в том же духе"
        }
    }
}




extension TopView {
    func SetSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            subtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 26),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            
            title.leftAnchor.constraint(equalTo: subtitle.leftAnchor),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -4)
        ])
    }
}
