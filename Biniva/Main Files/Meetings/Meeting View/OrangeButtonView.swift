//
//  ButtonView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 13.01.2021.
//

import UIKit

class ButtonView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.white
        label.text = "Присоедениться"
        label.font = UIFont.init(name: "SFPro-Bold", size: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.orange
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension ButtonView {
    
    func SetSubviews(){
        
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            
        ])
    }
}
