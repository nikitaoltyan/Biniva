//
//  MaterialPinCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import UIKit

class MaterialPinCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .orange
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}



extension MaterialPinCell{
    func setSubviews(){
        
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
        
        ])
    }
}
