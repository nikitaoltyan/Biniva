//
//  MessageCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 09.12.2020.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var commentIndex: Int?
    var delegate: myTableDelegate?
    let imageScale = 28 as CGFloat
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = MainConstants.white
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(dataLabel)
        self.contentView.addSubview(messageLabel)
//        self.contentView.addSubview(answerLabel)
        ActivateConstraints()
        answerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenProfile)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func OpenProfile(){
        print("open profile")
        delegate?.myTableDelegate(commentIndex: commentIndex ?? 0)
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "nikitaoltyan"
        label.font = UIFont.init(name: "SFPro-Medium", size: 17.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "10 December"
        label.textAlignment = .right
        label.font = UIFont.init(name: "SFPro", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 28/2
        return image
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 0
        label.text = "Some custome message text."
        label.textAlignment = .left
        label.font = UIFont.init(name: "SFPro", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Ответить"
        label.textAlignment = .left
        label.font = UIFont.init(name: "SFPro-Medium", size: 13.0)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func ActivateConstraints(){
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            profileImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            profileImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            profileImage.heightAnchor.constraint(equalToConstant: imageScale),
            profileImage.widthAnchor.constraint(equalToConstant: imageScale),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15),
            
            dataLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            dataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            messageLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            messageLabel.rightAnchor.constraint(equalTo: dataLabel.rightAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
//            
//            answerLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 6),
//            answerLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
//            answerLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate(const)
    }
}





protocol myTableDelegate {
    func myTableDelegate(commentIndex: Int)
}
