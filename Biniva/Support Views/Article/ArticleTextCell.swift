//
//  ArticleTextCell.swift
//  Biniva
//
//  Created by Никита Олтян on 13.07.2021.
//

import UIKit

class ArticleTextCell: UITableViewCell {
    
    let text: UILabel  = {
        let label = UILabel()
            .with(alignment: .left)
            .with(autolayout: false)
            .with(numberOfLines: 0)
            .with(color: Colors.nearBlack)
            .with(fontName: "SFPro", size: 20)
        return label
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
    
    func setText(text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.text.attributedText = attributedString
    }
}






extension ArticleTextCell {
    private
    func setSubviews() {
        self.addSubview(text)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            text.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            text.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
