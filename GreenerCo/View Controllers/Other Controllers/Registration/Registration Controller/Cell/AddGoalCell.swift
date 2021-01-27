//
//  AddGoalCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class AddGoalCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension AddGoalCell {
    
    func SetSubviews(){
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            
        ])
    }
}
