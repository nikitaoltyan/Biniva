//
//  StatsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 07.11.2020.
//

import UIKit

class StatsCell: UITableViewCell {

    var logedImage: UIImageView!
    var dateAndTime: UILabel!
    var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 242/255, green: 252/255, blue: 250/255, alpha: 1)
        LogedImage()
        MainLabel()
        DateAndTime()
    }
    
    func LogedImage(){
        let image = UIImageView()
        self.addSubview(image)
        logedImage = image
        let scale = 100 as CGFloat
        logedImage.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            logedImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logedImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            logedImage.heightAnchor.constraint(equalToConstant: scale),
            logedImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        logedImage.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        logedImage.layer.masksToBounds = true
        logedImage.layer.cornerRadius = scale/2
    }
    
    func MainLabel(){
        let label = UILabel()
        self.addSubview(label)
        mainLabel = label
        mainLabel.textColor = .darkGray
        mainLabel.text = "1 бутылка – 150 гр."
        mainLabel.font = UIFont.init(name: "Palatino Bold", size: 25.0)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.leftAnchor.constraint(equalTo: logedImage.rightAnchor, constant: 10),
            mainLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    func DateAndTime(){
        let label = UILabel()
        self.addSubview(label)
        dateAndTime = label
        dateAndTime.textColor = .darkGray
        dateAndTime.text = "15:08   6 Марта"
        dateAndTime.font = UIFont.init(name: "Palatino", size: 15.0)
        dateAndTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateAndTime.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
            dateAndTime.rightAnchor.constraint(equalTo: self.rightAnchor),
            dateAndTime.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            dateAndTime.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
