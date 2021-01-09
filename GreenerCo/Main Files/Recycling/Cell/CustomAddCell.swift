//
//  CustomAddCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddCell: UITableViewCell {
    
    let itemColorView: UIView = {
        let scale: CGFloat = 60
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = scale/3
        return view
    }()
    
    let itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "SFPro", size: 25)
        label.textColor = MainConstants.nearBlack
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






extension CustomAddCell{
    func SetSubviews(){
        self.addSubview(itemColorView)
        self.addSubview(itemImage)
        self.addSubview(itemLabel)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            itemColorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemColorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemColorView.widthAnchor.constraint(equalToConstant: itemColorView.frame.width),
            itemColorView.heightAnchor.constraint(equalToConstant: itemColorView.frame.height),
            
            itemImage.topAnchor.constraint(equalTo: itemColorView.topAnchor, constant: 3),
            itemImage.bottomAnchor.constraint(equalTo: itemColorView.bottomAnchor, constant: -3),
            itemImage.leftAnchor.constraint(equalTo: itemColorView.leftAnchor, constant: 3),
            itemImage.rightAnchor.constraint(equalTo: itemColorView.rightAnchor, constant: -3),
            
            itemLabel.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: 20),
            itemLabel.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor)
        ])
    }
}
