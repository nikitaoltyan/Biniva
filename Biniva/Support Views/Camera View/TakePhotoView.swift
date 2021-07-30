//
//  TakePhotoView.swift
//  Biniva
//
//  Created by Никита Олтян on 23.07.2021.
//

import UIKit

class TakePhotoView: UIView {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 31))
            .with(autolayout: false)
        image.tintColor = Colors.background
        return image
    }()

    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: 70, height: 70)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 70/2
        
        setSubviews()
        activateLayouts()
        setCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setCamera() {
        #if available 
        image.image = UIImage(systemName: "camera.fill")
    }
    
    func setTray() {
        image.image = UIImage(systemName: "tray.and.arrow.down.fill")
    }
}





extension TakePhotoView {
    
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(image)
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height)
        ])
    }
}
