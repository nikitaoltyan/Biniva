//
//  CustomAddCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddCell: UITableViewCell {

    var itemImage: UIImageView!
    var itemColorView: UIView!
    var itemLabel: UILabel!
    
    let scale = 60 as CGFloat
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ItemColorView()
        ItemImage()
        Label()
        self.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func ItemColorView(){
        let view = UIView()
        self.addSubview(view)
        itemColorView = view
        itemColorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemColorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemColorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemColorView.widthAnchor.constraint(equalToConstant: scale),
            itemColorView.heightAnchor.constraint(equalToConstant: scale)
        ])
        itemColorView.layer.cornerRadius = scale/4
    }

    func ItemImage(){
        let newImage = UIImageView()
        self.addSubview(newImage)
        newImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newImage.topAnchor.constraint(equalTo: itemColorView.topAnchor, constant: 3),
            newImage.bottomAnchor.constraint(equalTo: itemColorView.bottomAnchor, constant: -3),
            newImage.leftAnchor.constraint(equalTo: itemColorView.leftAnchor, constant: 3),
            newImage.rightAnchor.constraint(equalTo: itemColorView.rightAnchor, constant: -3),
        ])
        newImage.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        itemImage = newImage
    }
    
    func Label(){
        let newLabel = UILabel()
        self.addSubview(newLabel)
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newLabel.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: 20),
            newLabel.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor),
            newLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            newLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        newLabel.font = UIFont.init(name: "SFPro", size: 22)
        newLabel.textColor = .darkGray
        itemLabel = newLabel
    }
}
