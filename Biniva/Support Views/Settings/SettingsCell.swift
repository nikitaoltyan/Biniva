//
//  SettingsCell.swift
//  Biniva
//
//  Created by Nick Oltyan on 06.08.2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
        return view
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
    
    func setCell(forRowNumber row: Int, rowsInSection: Int) {
        guard row != rowsInSection else {
            cellView.layer.cornerRadius = 20
            return
        }
        if row == 0 { firstCell() }
        if row == rowsInSection-1 { lastCell() }
    }

    private
    func firstCell() {
        cellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cellView.layer.cornerRadius = 20
    }
    private
    func lastCell() {
        cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cellView.layer.cornerRadius = 20
        separator.isHidden = true
    }
}





extension SettingsCell {
    private
    func setSubviews() {
//        self.addSubview(cellView)
        self.addSubview(title)
        self.addSubview(chevron)
//        self.addSubview(separator)
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
//            cellView.topAnchor.constraint(equalTo: self.topAnchor),
//            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
//            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            chevron.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            chevron.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevron.heightAnchor.constraint(equalToConstant: chevron.frame.height),
            chevron.widthAnchor.constraint(equalToConstant: chevron.frame.width),
//            
//            separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
//            separator.rightAnchor.constraint(equalTo: self.rightAnchor),
//            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
