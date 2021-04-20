//
//  SwitcherView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 19.04.2021.
//

import UIKit

class SwitcherView: UIView {

    lazy var grayView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            .with(bgColor: Colors.sliderGray)
            .with(cornerRadius: self.frame.height/2)
            .with(autolayout: false)
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var greenView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height-6))
            .with(cornerRadius: (self.frame.height-6)/2)
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.greenView.frame
        gradient.colors = [Colors.topGradient!.cgColor,
                           Colors.bottomGradient!.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    let labelOne: UILabel = {
        let label = UILabel()
            .with(color: Colors.background)
            .with(alignment: .center)
            .with(fontName: "SFPro-Semibold", size: 16)
            .with(autolayout: false)
        label.text = "Мусор"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(fontName: "SFPro-Semibold", size: 16)
            .with(autolayout: false)
        label.text = "Статистика"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var delegate: SwitcherDelegate?
    var topViewDelegate: TopViewDelegate?
    var centerXGreenView: NSLayoutConstraint?
    
    var isLabelOneActivated: Bool = true
    var isLabelTwoActivated: Bool = false
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: 240, height: 48)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc func AnimateOne() {
        guard (isLabelOneActivated == false) else { return }
        DispatchQueue.main.async {
            self.topViewDelegate?.UpdateTitles(isRecylcing: true)
            self.delegate?.ShowRecycling()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.greenView.center.x = self.labelOne.center.x+3
            self.labelOne.textColor = Colors.background
            self.labelTwo.textColor = Colors.darkGrayText
        }, completion: { (result) in
            self.centerXGreenView?.constant = -self.grayView.frame.width*1/4+3
            self.greenView.layoutIfNeeded()
            self.isLabelOneActivated = true
            self.isLabelTwoActivated = false
        })
    }
    
    @objc func AnimateTwo() {
        guard (isLabelTwoActivated == false) else { return }
        DispatchQueue.main.async {
            self.topViewDelegate?.UpdateTitles(isRecylcing: false)
            self.delegate?.ShowStats()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.greenView.center.x = self.labelTwo.center.x-3
            self.labelTwo.textColor = Colors.background
            self.labelOne.textColor = Colors.darkGrayText
        }, completion: { (result) in
            self.centerXGreenView?.constant = self.grayView.frame.width*1/4-3
            self.greenView.layoutIfNeeded()
            self.isLabelTwoActivated = true
            self.isLabelOneActivated = false
        })
    }
}





extension SwitcherView{
    func SetSubviews(){
        self.addSubview(grayView)
        grayView.addSubview(greenView)
        greenView.layer.addSublayer(gradient)
        grayView.addSubview(labelOne)
        grayView.addSubview(labelTwo)
        
        labelOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AnimateOne)))
        labelTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AnimateTwo)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            grayView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            grayView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            grayView.widthAnchor.constraint(equalToConstant: grayView.frame.width),
            grayView.heightAnchor.constraint(equalToConstant: grayView.frame.height),
            
            greenView.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            greenView.widthAnchor.constraint(equalToConstant: greenView.frame.width),
            greenView.heightAnchor.constraint(equalToConstant: greenView.frame.height),
            
            labelOne.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            labelOne.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: -grayView.frame.width*1/4),
            labelOne.bottomAnchor.constraint(equalTo: grayView.bottomAnchor),
            
            labelTwo.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            labelTwo.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: grayView.frame.width*1/4),
            labelTwo.bottomAnchor.constraint(equalTo: greenView.bottomAnchor),
        ])
    
        centerXGreenView = greenView.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: -grayView.frame.width*1/4+3)
        centerXGreenView?.isActive = true
    }
}
