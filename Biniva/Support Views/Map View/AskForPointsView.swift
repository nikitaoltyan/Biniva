//
//  AskForPointsView.swift
//  Biniva
//
//  Created by Nick Oltyan on 26.08.2021.
//

import UIKit

class AskForPointsView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_ask_for_points_title", comment: "")
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 14)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_ask_for_points_desc", comment: "")
        return label
    }()
    
    let closeButton: CloseCircleView = {
        let view = CloseCircleView()
            .with(autolayout: false)
        return view
    }()
    
    let askButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
            .with(autolayout: false)
            .with(bgColor: .lightGray)
            .with(cornerRadius: 12)
        
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        button.setTitle(NSLocalizedString("map_ask_for_points_button", comment: ""), for: .normal)
        button.setTitleColor(Colors.background, for: .normal)
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    var delegate: askForPointsDelegate?
    
    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 168)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 12
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func askAction() {
        Vibration.soft()
        askButton.tap(completion: { _ in
            self.delegate?.askForPoints()
        })
    }
    
    @objc
    func closeAction() {
        closeButton.tap(completion: { _ in
            self.delegate?.close()
        })
    }
}





extension AskForPointsView {
    private
    func setSubviews() {
        self.addSubview(title)
        self.addSubview(desc)
        self.addSubview(closeButton)
        self.addSubview(askButton)
        
        askButton.addTarget(self, action: #selector(askAction), for: .touchUpInside)
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17),
            
            closeButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17),
            closeButton.widthAnchor.constraint(equalToConstant: closeButton.frame.width),
            closeButton.heightAnchor.constraint(equalToConstant: closeButton.frame.height),
            
            askButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            askButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            askButton.heightAnchor.constraint(equalToConstant: askButton.frame.height),
            askButton.widthAnchor.constraint(equalToConstant: askButton.frame.width),
        ])
    }
}

