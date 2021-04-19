//
//  ProgressView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.04.2021.
//

import UIKit

class ProgressView: UIView {

    lazy var grayCircleView: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let center = self.center
        let circularPath = UIBezierPath(arcCenter: center, radius: self.frame.width*0.36, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Colors.grayCircle.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 20
        
        shapeLayer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowOffset = CGSize(width: 4, height: 4)
        return shapeLayer
    }()
    
    lazy var circleView: CAGradientLayer = {
        let shapeLayer = CAShapeLayer()
        let center = self.center
        let circularPath = UIBezierPath(arcCenter: center, radius: self.frame.width*0.36, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = MainConstants.green.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 28
        
        shapeLayer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowOffset = CGSize(width: 4, height: 4)
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [Colors.topGradient!.cgColor,
                           Colors.bottomGradient!.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)

        gradient.mask = shapeLayer
        return gradient
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 48)
            .with(autolayout: false)
        label.text = "1,5 кг"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "собрано мусора"
        return label
    }()
    
    let warningTitle: UILabel = {
        let label = UILabel()
            .with(color: .darkGray)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Medium", size: 14)
            .with(autolayout: false)
        label.text = "максимальное значение за день"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension ProgressView {
    func SetSubviews(){
        self.layer.addSublayer(grayCircleView)
        self.layer.addSublayer(circleView)
        self.addSubview(weightLabel)
        self.addSubview(subtitle)
        self.addSubview(warningTitle)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            weightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
            
            subtitle.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            subtitle.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            
            warningTitle.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            warningTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 26),
            warningTitle.widthAnchor.constraint(equalToConstant: 139)
        ])
    }
}
