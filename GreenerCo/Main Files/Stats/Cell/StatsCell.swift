//
//  StatsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 07.11.2020.
//

import UIKit

class StatsCell: UITableViewCell {

    let logedImage: UIImageView = {
        let imageScale: CGFloat = 85
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints =  false
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.width/3
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = MainConstants.nearBlack
        label.text = "1 бутылка – 150 гр."
        label.font = UIFont.init(name: "SFPro-Medium", size: 25.0)
        return label
    }()
    
    let dateAndTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = MainConstants.nearBlack
        label.text = "15:08   6 Марта"
        label.font = UIFont.init(name: "SFPro", size: 15.0)
        return label
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}




extension StatsCell {
    
    func SetSubviews(){
        self.addSubview(logedImage)
        self.addSubview(mainLabel)
        self.addSubview(dateAndTime)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            logedImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logedImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            logedImage.heightAnchor.constraint(equalToConstant: logedImage.frame.height),
            logedImage.widthAnchor.constraint(equalToConstant: logedImage.frame.width),
            
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.leftAnchor.constraint(equalTo: logedImage.rightAnchor, constant: 10),
            
            dateAndTime.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
            dateAndTime.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5)
        ])
    }
}
