//
//  WeeklyStatsCell+Unsubscribed.swift
//  Biniva
//
//  Created by Nick Oltyan on 16.08.2021.
//

import UIKit

class WeeklyStatsCell_Unsubscribed: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_weekly_unsubscribed_cell_title", comment: "title for unsubscribed cell")
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 13)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_weekly_unsubscribed_cell_subtitle", comment: "subtitle for unsubscribed cell")
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 100))
            .with(autolayout: false)
        image.image = UIImage(named: "weekly_unsubscribed")
        return image
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}






extension WeeklyStatsCell_Unsubscribed {
    private
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(image)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            title.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 25),
            title.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -15),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -4),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
