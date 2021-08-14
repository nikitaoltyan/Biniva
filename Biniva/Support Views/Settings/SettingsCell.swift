//
//  SettingsCell.swift
//  Biniva
//
//  Created by Nick Oltyan on 06.08.2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            .with(autolayout: false)
        image.tintColor = Colors.nearBlack
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(alignment: .left)
            .with(fontName: "SFPro", size: 16)
            .with(numberOfLines: 1)
            .with(color: Colors.nearBlack)
        return label
    }()
    
    let chevron: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 17 }
            else { return 15 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale-5, height: scale))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
        button.image = UIImage(systemName: "chevron.right")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let separator: UIView = {
        let view = UIView()
            .with(autolayout: false)
            .with(bgColor: Colors.background)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.sliderGray
        setSubviews()
        activateLayout()
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension SettingsCell {
    private
    func setSubviews() {
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(chevron)
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            title.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 14),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            chevron.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            chevron.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevron.heightAnchor.constraint(equalToConstant: chevron.frame.height),
            chevron.widthAnchor.constraint(equalToConstant: chevron.frame.width),
        ])
    }
}
