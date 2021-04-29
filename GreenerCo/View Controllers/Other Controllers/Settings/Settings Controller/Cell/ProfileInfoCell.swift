//
//  ProfileInfoCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 24.02.2021.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
    
    let profileImage: UIImageView = {
        let imageScale: CGFloat = 75
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
            .with(cornerRadius: imageScale/2)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let username: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Medium", size: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
            .with(color: .gray)
            .with(fontName: "SFPro", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    
    func UpdateData(userId uid: String?){
//        Server.GetUserMainData(forUserId: uid, userData: { result in
//            DispatchQueue.main.async { self.profileImage.downloadImage(from: result["image"] as? String) }
//            self.username.text = result["username"] as? String
//            self.email.text = result["email"] as? String
//        })
    }
}





extension ProfileInfoCell{
    
    func SetSubviews() {
        self.addSubview(profileImage)
        self.addSubview(username)
        self.addSubview(email)
    }
    
    func ActivateLayouts() {
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            profileImage.heightAnchor.constraint(equalToConstant: profileImage.frame.height),
            profileImage.widthAnchor.constraint(equalToConstant: profileImage.frame.width),
            
            username.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 22),
            username.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -14),
            
            email.leftAnchor.constraint(equalTo: username.leftAnchor),
            email.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 14),
        ])
    }
}
