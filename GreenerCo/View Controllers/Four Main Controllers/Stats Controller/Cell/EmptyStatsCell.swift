//
//  EmptyStatsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 01.03.2021.
//

import UIKit

class EmptyStatsCell: UITableViewCell {

    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.font = UIFont.init(name: "SFPro", size: 22.0)
        label.text = "В этот день не было мусора! Молодец!"
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}



extension EmptyStatsCell {
    
    func SetSubviews(){
        self.addSubview(mainLabel)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30)
        ])
    }
}
