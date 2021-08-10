//
//  ProgressView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 18.04.2021.
//

import UIKit

class ProgressView: UIView {
    
    let measure = Measure()

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
    
    lazy var maskCircle: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let center = self.center
        let circularPath = UIBezierPath(arcCenter: center, radius: self.frame.width*0.36, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Colors.darkGrayText.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = 28
        
        shapeLayer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowOffset = CGSize(width: 4, height: 4)
        return shapeLayer
    }()
    
    lazy var circleView: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.mask = maskCircle
        return gradient
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 48)
            .with(autolayout: false)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = NSLocalizedString("progress_view_subtitle", comment: "subtitle for progress view")
        return label
    }()
    
    let warningTitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Medium", size: 14)
            .with(autolayout: false)
        return label
    }()
    
    // Should be setted with initializer.
    var currentValue: Int = 0 // In gramms
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
        setUpInitial()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setUpInitial(){
        print("ProgressView setUpInitial")
        DataFunction().getTotalLogged(forDate: Date().onlyDate, result: { (logged) in
            self.currentValue = logged
            self.maskCircle.strokeEnd = CGFloat(logged)/2000.0
            self.setLabels()
        })
    }
    
    func update(addWeight weight: Int){
        animate(addValue: weight)
        currentValue += weight
        setLabels()
    }
    
    func animate(addValue: Int){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(currentValue)/2000.0
        animation.toValue = CGFloat(currentValue + addValue)/2000.0
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        maskCircle.add(animation, forKey: nil)
    }
    
    func setLabels(){
        weightLabel.text = "\(measure.getMeasurementString(weight: currentValue, forNeededType: .kilogramm))"
        
        if (Double(currentValue) < 1100) { // 1100 gramms as Iconic
            warningTitle.text = NSLocalizedString("progress_view_warning_good", comment: "Title for good results")
        } else {
            warningTitle.text = NSLocalizedString("progress_view_warning_bad", comment: "Title for bad results")
        }
    }
}





extension ProgressView {
    func setSubviews(){
        self.layer.addSublayer(grayCircleView)
        self.layer.addSublayer(circleView)
        self.addSubview(weightLabel)
        self.addSubview(subtitle)
        self.addSubview(warningTitle)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            weightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
            
            subtitle.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            subtitle.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 3),
            
            warningTitle.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            warningTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 18),
            warningTitle.widthAnchor.constraint(equalToConstant: 139)
        ])
    }
}
