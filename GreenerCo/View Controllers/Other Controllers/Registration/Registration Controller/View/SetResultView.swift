//
//  SetResultView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 28.01.2021.
//

import UIKit

class SetResultView: UIView {
    
    let number: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Bold", size: 26)
            .with(alignment: .center)
            .with(numberOfLines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 10)
            .with(alignment: .center)
            .with(numberOfLines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "грамм"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}






extension SetResultView {
    
    func SetSubviews(){
        self.addSubview(number)
        self.addSubview(label)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            number.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 2)
        ])
    }
}
