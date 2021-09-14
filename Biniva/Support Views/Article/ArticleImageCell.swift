//
//  ArticleImageCell.swift
//  Biniva
//
//  Created by Biniva on 13.07.2021.
//

import UIKit

class ArticleImageCell: UITableViewCell {
    
    
    let image: UIImageView = {
        let image = UIImageView()
            .with(autolayout: false)
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension ArticleImageCell {
    private
    func setSubviews(){
        self.addSubview(image)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

