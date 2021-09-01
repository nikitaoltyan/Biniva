//
//  SubStatsUsersView.swift
//  Biniva
//
//  Created by Nick Oltyan on 01.09.2021.
//

import UIKit

class SubStatsUsersView: UIView {
    
    let function = SubStatsFunctions()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.3)
        return gradient
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 20)
        label.text = "пользователей"
        return label
    }()
    
    let number: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Semibold", size: 24)
        return label
    }()
    
    let time: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .right)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        return label
    }()
    
    let allBar: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 25))
            .with(autolayout: false)
            .with(bgColor: Colors.grayCircle)
            .with(cornerRadius: 8)
        return view
    }()
    
    let successBar: UIView = {
        let view = UIView()
            .with(autolayout: false)
            .with(bgColor: Colors.topGradient)
            .with(cornerRadius: 8)
        return view
    }()

    
    var barWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 165)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 30
        setSubviews()
        activateLayouts()
        update()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private
    func update() {
        let usersNumber = function.gainedGarbageNumber()
        number.text = "\(usersNumber)"
//        time.text = ""
        
        let width = self.frame.width - 60
        let setWidth = function.calculateUsersBarWidth(current: Double(usersNumber), width: Double(width))
        
        print("Got number: \(usersNumber) and setWidth: \(setWidth)")
        barWidthConstraint?.constant = CGFloat(setWidth)
        self.layoutIfNeeded()
    }

}






extension SubStatsUsersView {
    private
    func setSubviews() {
        self.layer.addSublayer(gradient)
        self.addSubview(title)
        self.addSubview(number)
        self.addSubview(allBar)
        self.addSubview(time)
        allBar.addSubview(successBar)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            
            allBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35),
            allBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            allBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            allBar.heightAnchor.constraint(equalToConstant: allBar.frame.height),
            
            number.bottomAnchor.constraint(equalTo: allBar.topAnchor, constant: -3),
            number.leftAnchor.constraint(equalTo: allBar.leftAnchor),
            
            time.bottomAnchor.constraint(equalTo: allBar.topAnchor, constant: -3),
            time.rightAnchor.constraint(equalTo: allBar.rightAnchor),
            
            successBar.topAnchor.constraint(equalTo: allBar.topAnchor),
            successBar.bottomAnchor.constraint(equalTo: allBar.bottomAnchor),
            successBar.leftAnchor.constraint(equalTo: allBar.leftAnchor)
        ])
        
        barWidthConstraint = successBar.widthAnchor.constraint(equalToConstant: 60)
        barWidthConstraint?.isActive = true
    }
}
