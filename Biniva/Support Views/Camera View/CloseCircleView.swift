//
//  CloseCircleView.swift
//  Biniva
//
//  Created by Никита Олтян on 25.07.2021.
//

import UIKit

class CloseCircleView: UIView {
    
    let crossLine_1: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 17))
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
        return view
    }()
    
    let crossLine_2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 17))
            .with(autolayout: false)
            .with(bgColor: Colors.sliderGray)
        return view
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: 23, height: 23)
        super.init(frame: useFrame)
        backgroundColor = .lightGray
        layer.cornerRadius = 23/2
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}






extension CloseCircleView {
    
    func setSubviews(){
        self.addSubview(crossLine_1)
        self.addSubview(crossLine_2)
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            crossLine_1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            crossLine_1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            crossLine_1.widthAnchor.constraint(equalToConstant: crossLine_1.frame.width),
            crossLine_1.heightAnchor.constraint(equalToConstant: crossLine_1.frame.height),
            
            crossLine_2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            crossLine_2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            crossLine_2.widthAnchor.constraint(equalToConstant: crossLine_2.frame.width),
            crossLine_2.heightAnchor.constraint(equalToConstant: crossLine_2.frame.height),
        ])
        crossLine_1.transform = CGAffineTransform(rotationAngle: .pi/4)
        crossLine_2.transform = CGAffineTransform(rotationAngle: -.pi/4)
    }
}
