//
//  RegularTopView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.01.2021.
//

import UIKit

class RegularTopView: UIView {
    
    var statsDelegate: StatsDelegate?
    var recyclingDelegate: RecyclingDelegate?
    var pageName: String?
        
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.white
        label.textAlignment = .left
        label.font = UIFont(name: "Palatino-Bold", size: 35.0)
        return label
    }()
    
    let imageButton: UIImageView = {
        let scale: CGFloat = 35
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "checkmark.shield")
        image.tintColor = MainConstants.white
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.green
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func OpenViewController(){
        switch (pageName ?? "stats") {
        case "stats":
            print("stats delegate")
            statsDelegate?.OpenAchievements()
        default:
            print("recycling delegate")
            recyclingDelegate?.OpenTipsList()
        }
    }
    
}






extension RegularTopView {
    func SetSubviews(){
        self.addSubview(mainView)
        self.addSubview(pageLabel)
        self.addSubview(imageButton)
        
        imageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenViewController)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 97),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            pageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            
            imageButton.centerYAnchor.constraint(equalTo: pageLabel.centerYAnchor),
            imageButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            imageButton.heightAnchor.constraint(equalToConstant: imageButton.frame.height),
            imageButton.widthAnchor.constraint(equalToConstant: imageButton.frame.width)
        ])
    }
}




protocol StatsDelegate {
    func OpenAchievements()
}
