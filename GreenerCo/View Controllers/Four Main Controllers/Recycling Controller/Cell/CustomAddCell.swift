//
//  CustomAddCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddCell: UITableViewCell {
    
    let itemView: ItemView = {
        let scale: CGFloat = 60
        let view = ItemView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = scale/3
        return view
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "SFPro", size: 24)
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
        self.addSubview(itemView)
        self.addSubview(itemLabel)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            itemView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemView.widthAnchor.constraint(equalToConstant: itemView.frame.width),
            itemView.heightAnchor.constraint(equalToConstant: itemView.frame.height),
            
            itemLabel.leftAnchor.constraint(equalTo: itemView.rightAnchor, constant: 20),
            itemLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor)
        ])
    }
}
