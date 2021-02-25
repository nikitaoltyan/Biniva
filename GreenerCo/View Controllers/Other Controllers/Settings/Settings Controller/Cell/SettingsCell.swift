//
//  SettingsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 21.12.2020.
//

import UIKit

class SettingsCell: UITableViewCell {

    let label: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not available"
        return label
    }()
    
    let forvardImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 18))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = .lightGray
        image.image = UIImage(systemName: "chevron.right")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = MainConstants.cellColor
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





extension SettingsCell {
    
    func SetSubviews() {
        self.addSubview(label)
        self.addSubview(forvardImage)
    }
    
    func ActivateLayouts() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            forvardImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            forvardImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            forvardImage.heightAnchor.constraint(equalToConstant: forvardImage.frame.height),
            forvardImage.widthAnchor.constraint(equalToConstant: forvardImage.frame.width)
        ])
    }
}
