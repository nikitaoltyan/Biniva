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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/3-10, height: self.frame.height-6))
            .with(cornerRadius: (self.frame.height-6)/2)
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.greenView.frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
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
        label.text = NSLocalizedString("switcher_recycling", comment: "recycling switcher label")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(fontName: "SFPro-Semibold", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("switcher_stats", comment: "stats switcher label")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let labelThree: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(fontName: "SFPro-Semibold", size: 16)
            .with(autolayout: false)
        label.text = NSLocalizedString("switcher_map", comment: "map switcher label")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    var delegate: SwitcherDelegate?
    var topViewDelegate: TopViewDelegate?
    var widthGreenView: NSLayoutConstraint?
    var centerXGreenView: NSLayoutConstraint?
    
    var isLabelOneActivated: Bool = true
    var isLabelTwoActivated: Bool = false
    var isLabelThreeActivated: Bool = false
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: 325, height: 48)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func animateOne() {
        guard (isLabelOneActivated == false) else { return }
        DispatchQueue.main.async {
            self.topViewDelegate?.updateTitles(isRecylcing: true)
            self.delegate?.showRecycling()
//            self.delegate?.hideTopView(false)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.greenView.center.x = self.labelOne.center.x+3
            self.greenView.transform = CGAffineTransform(scaleX: 0.9, y: 1)
            self.labelOne.textColor = Colors.background
            self.labelTwo.textColor = Colors.darkGrayText
            self.labelThree.textColor = Colors.darkGrayText
        }, completion: { (result) in
            self.centerXGreenView?.constant = -self.grayView.frame.width*1/3
            self.greenView.layoutIfNeeded()
            self.isLabelOneActivated = true
            self.isLabelTwoActivated = false
            self.isLabelThreeActivated = false
        })
    }
    
    
    @objc
    func animateTwo() {
        guard (isLabelTwoActivated == false) else { return }
        DispatchQueue.main.async {
            self.topViewDelegate?.updateTitles(isRecylcing: false)
            self.delegate?.showStats()
//            self.delegate?.hideTopView(false)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.greenView.center.x = self.labelTwo.center.x-3
            self.greenView.transform = CGAffineTransform(scaleX: 1.1, y: 1)
            self.labelTwo.textColor = Colors.background
            self.labelOne.textColor = Colors.darkGrayText
            self.labelThree.textColor = Colors.darkGrayText
        }, completion: { (result) in
            self.centerXGreenView?.constant = 0
            self.greenView.frame.size.width = 170
            self.greenView.layoutIfNeeded()
            self.isLabelTwoActivated = true
            self.isLabelOneActivated = false
            self.isLabelThreeActivated = false
        })
    }
    
    @objc
    func animateThree() {
        guard (isLabelThreeActivated == false) else { return }
        DispatchQueue.main.async {
            self.delegate?.showMap()
//            self.delegate?.hideTopView(true)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.greenView.center.x = self.labelThree.center.x-5
            self.greenView.transform = CGAffineTransform(scaleX: 0.9, y: 1)
            self.labelThree.textColor = Colors.background
            self.labelTwo.textColor = Colors.darkGrayText
            self.labelOne.textColor = Colors.darkGrayText
        }, completion: { (result) in
            self.centerXGreenView?.constant = self.grayView.frame.width*1/3
            self.layoutIfNeeded()
            self.isLabelThreeActivated = true
            self.isLabelTwoActivated = false
            self.isLabelOneActivated = false
        })
    }
}





extension SwitcherView{
    func setSubviews(){
        self.addSubview(grayView)
        grayView.addSubview(greenView)
        greenView.layer.addSublayer(gradient)
        grayView.addSubview(labelOne)
        grayView.addSubview(labelTwo)
        grayView.addSubview(labelThree)
        
        labelOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOne)))
        labelTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateTwo)))
        labelThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateThree)))
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            grayView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            grayView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            grayView.widthAnchor.constraint(equalToConstant: grayView.frame.width),
            grayView.heightAnchor.constraint(equalToConstant: grayView.frame.height),
            
            greenView.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            greenView.heightAnchor.constraint(equalToConstant: greenView.frame.height),
            
            labelOne.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            labelOne.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: -grayView.frame.width*1/3),
            labelOne.bottomAnchor.constraint(equalTo: grayView.bottomAnchor),
            
            labelTwo.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            labelTwo.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: 0),
            labelTwo.bottomAnchor.constraint(equalTo: greenView.bottomAnchor),
            
            labelThree.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            labelThree.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: grayView.frame.width*1/3),
            labelThree.bottomAnchor.constraint(equalTo: greenView.bottomAnchor),
        ])
    
        centerXGreenView = greenView.centerXAnchor.constraint(equalTo: grayView.centerXAnchor, constant: -grayView.frame.width*1/3+3)
        widthGreenView = greenView.widthAnchor.constraint(equalToConstant: greenView.frame.width)
        centerXGreenView?.isActive = true
        widthGreenView?.isActive = true
    }
}
