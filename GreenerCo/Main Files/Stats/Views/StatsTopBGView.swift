//
//  TopBGView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsTopBGView: UIView {

    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        let label: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(red: 242/255, green: 252/255, blue: 250/255, alpha: 1)
            label.text = "Статистика"
            label.font = UIFont.init(name: "Palatino-Bold", size: 35.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        self.addSubview(label)

        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 39),
                label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                label.heightAnchor.constraint(equalToConstant: 42),
                label.widthAnchor.constraint(equalToConstant: 232)
            ])
        } else {
            const.append(contentsOf: [
                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 39),
                label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                label.heightAnchor.constraint(equalToConstant: 39),
                label.widthAnchor.constraint(equalToConstant: 232)
            ])
        }
        NSLayoutConstraint.activate(const)
    }

}
