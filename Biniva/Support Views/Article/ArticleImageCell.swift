//
//  ArticleImageCell.swift
//  Biniva
//
//  Created by Никита Олтян on 13.07.2021.
//

import UIKit

class ArticleImageCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension ArticleImageCell {
    func setSubviews() {
        
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
        
        ])
    }
}

