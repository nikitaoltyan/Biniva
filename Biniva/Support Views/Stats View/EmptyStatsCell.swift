//
//  EmptyStatsCell.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 13.05.2021.
//

import UIKit

class EmptyStatsCell: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_empty_cell_title", comment: "title for empty state Cell")
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 13)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_empty_cell_subtitle", comment: "title for empty state Cell")
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension EmptyStatsCell {
    private
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            title.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 25),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 7),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35)
        ])
    }
}
