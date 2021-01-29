//
//  EmptyMeetingsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.01.2021.
//

import UIKit

class EmptyMeetingsCell: UICollectionViewCell {
    
    let mainLabel: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 30)
            .with(color: MainConstants.nearBlack)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Похоже, сейчас мало встреч"
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 190, height: 270))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Hands_Phone")
        return image
    }()
    
    let explanation: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 15)
            .with(color: .lightGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Попробуй создать свою!"
        return label
    }()
    
    let createMeeting: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-90, height: 60))
            .with(bgColor: MainConstants.orange)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "Создать встречу"
        view.label.textColor = MainConstants.white
        view.isUserInteractionEnabled = true
        view.isActive = true
        return view
    }()
    
    var delegateMeeting: AddMeetingDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc func AddMeeting(){
        print("Add meeting after tap")
        delegateMeeting?.addMeeting()
    }
}





extension EmptyMeetingsCell{
    
    func SetSubviews(){
        self.addSubview(mainLabel)
        self.addSubview(image)
        self.addSubview(explanation)
        self.addSubview(createMeeting)
        
        createMeeting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddMeeting)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: 200),
            
            image.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            explanation.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            explanation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            createMeeting.topAnchor.constraint(equalTo: explanation.bottomAnchor, constant: 40),
            createMeeting.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createMeeting.widthAnchor.constraint(equalToConstant: createMeeting.frame.width),
            createMeeting.heightAnchor.constraint(equalToConstant: createMeeting.frame.height),
        ])
    }
}
