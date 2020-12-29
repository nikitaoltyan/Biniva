//
//  TopViewCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 08.11.2020.
//

import UIKit

class TopViewCell: UICollectionViewCell{
    
    var delegate: AddMeetingDelegate?
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    @objc func AddMeeting(){
        print("Add meeting after tap")
        delegate?.addMeeting()
    }
}



extension TopViewCell {
    
    func SetSubview(){
        self.addSubview(topView)
        self.addSubview(mainLabel)
        self.addSubview(mainView)
        self.addSubview(plusView)
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddMeeting)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 200),
            
            mainView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -103),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 50),
            
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            mainLabel.heightAnchor.constraint(equalToConstant: 39),
            mainLabel.widthAnchor.constraint(equalToConstant: 232),
            
            plusView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width)
        ])
    }
    
}

protocol AddMeetingDelegate {
    func addMeeting()
}
