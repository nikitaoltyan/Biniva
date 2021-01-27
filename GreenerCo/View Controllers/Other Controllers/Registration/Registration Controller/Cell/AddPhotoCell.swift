//
//  AddPhotoCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension AddPhotoCell {
    
    func SetSubviews(){
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            
        ])
    }
}

