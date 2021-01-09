//
//  TopViewCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 08.11.2020.
//

import UIKit

class TopViewCell: UICollectionViewCell{
    
    var delegateMeeting: AddMeetingDelegate?
    var delegateBack: BackDelegate?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.white
        label.font = UIFont.init(name: "Palatino-Bold", size: 35.0)
        return label
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    let plusView: CompletePlusView = {
        let width: CGFloat = 36
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = width/3
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.backgroundColor = MainConstants.green
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let backImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 25))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.white
        image.image = UIImage(systemName: "chevron.left")
        return image
    }()
    
    
    var backImageWidthConstraint: NSLayoutConstraint?
    var mainLabelLeftConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.green
        SetSubview()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    Delete after AchieveController redevelopment
    override func awakeFromNib() {
        SetSubview()
        ActivateLayouts()
        SetRightConstraints()
    }
    
    @objc func AddMeeting(){
        print("Add meeting after tap")
        delegateMeeting?.addMeeting()
    }
    
    @objc func Back(){
        print("Back after tap")
        delegateBack?.Back()
    }
}



extension TopViewCell {
    
    func SetSubview(){
        self.addSubview(mainLabel)
        self.addSubview(mainView)
        self.addSubview(plusView)
        self.addSubview(backImage)
        
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddMeeting)))
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Back)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 97),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 52),
            backImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            backImage.heightAnchor.constraint(equalToConstant: backImage.frame.height),
            
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            
            plusView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width)
        ])
        
        backImageWidthConstraint = backImage.widthAnchor.constraint(equalToConstant: backImage.frame.width)
        mainLabelLeftConstraint = mainLabel.leftAnchor.constraint(equalTo: backImage.rightAnchor, constant: 0)
        backImageWidthConstraint?.isActive = true
        mainLabelLeftConstraint?.isActive = true
    }
    
    func SetRightConstraints(){
        if (plusView.isHidden) {
            backImageWidthConstraint?.constant = backImage.frame.width
            mainLabelLeftConstraint?.constant = 20
            self.layoutIfNeeded()
        } else {
            backImageWidthConstraint?.constant = 0
            mainLabelLeftConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }
    
}



protocol AddMeetingDelegate {
    func addMeeting()
}

protocol BackDelegate {
    func Back()
}
