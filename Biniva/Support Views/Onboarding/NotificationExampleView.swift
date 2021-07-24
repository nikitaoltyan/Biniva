//
//  NotificationExampleView.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class NotificationExampleView: UIView {
    
    let icon: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 19, height: 19))
            .with(autolayout: false)
        image.image = UIImage(named: "onboarding_icon")
        return image
    }()
    
    let name: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: .gray)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
        label.text = "BINIVA"
        return label
    }()
    
    let time: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: .gray)
            .with(alignment: .right)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = "RIGHT NOW"
        return label
    }()
    
    let title: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Semibold", size: 16)
        label.text = NSLocalizedString("notification_title", comment: "Title for notification")
        return label
    }()
    
    let subtitle: UIView = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
        label.text = NSLocalizedString("notification_subtitle", comment: "Body for notification")
        return label
    }()
    

    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth-40, height: 116)
        super.init(frame: useFrame)
        setSubviews()
        activateLayouts()
        self.layer.cornerRadius = 10
        self.backgroundColor = Colors.sliderGray
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension NotificationExampleView {
    func setSubviews() {
        self.addSubview(icon)
        self.addSubview(name)
        self.addSubview(time)
        self.addSubview(title)
        self.addSubview(subtitle)
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            icon.heightAnchor.constraint(equalToConstant: icon.frame.height),
            icon.widthAnchor.constraint(equalToConstant: icon.frame.width),
            
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            name.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 6),
            
            time.topAnchor.constraint(equalTo: name.topAnchor),
            time.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            title.leftAnchor.constraint(equalTo: icon.leftAnchor),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            subtitle.leftAnchor.constraint(equalTo: title.leftAnchor),
            subtitle.rightAnchor.constraint(equalTo: title.rightAnchor),
        ])
    }
}
