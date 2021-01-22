//
//  CategoryNameCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 16.12.2020.
//

import UIKit

class CategoryNameCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "Big Title Name"
        label.font = UIFont.init(name: "SFPro-Bold", size: 27.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        self.addSubview(categoryLabel)
        ActivateLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func ActivateLayers(){
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
    }
}
