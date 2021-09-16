//
//  AddButtonWithPhotoView.swift
//  Biniva
//
//  Created by Nick Oltyan on 23.07.2021.
//

import UIKit

class AddButtonWithPhotoView: UIView {
    
    let photoView: UIView = {
        let view = UIView()
            .with(autolayout: false)
            .with(cornerRadius: 48/2)
            .with(bgColor: Colors.background)
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 25))
            .with(autolayout: false)
        image.image = UIImage(systemName: "camera.fill")
        image.tintColor = Colors.bottomGradient
        return image
    }()

    let label: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.background)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 20.0)
            .with(numberOfLines: 1)
        label.text = NSLocalizedString("add_button", comment: "Title for add button")
        return label
    }()
    
    lazy var underCameraView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/3+7, height: 55))
            .with(autolayout: false)
            .with(cornerRadius: 55/2)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var addView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width*2/3 - 15, height: 55))
            .with(autolayout: false)
            .with(cornerRadius: 55/2)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var gradient_1: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = underCameraView.frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    lazy var gradient_2: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = addView.frame
        gradient.colors = [Colors.topGradient.cgColor,
                           Colors.bottomGradient.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        return gradient
    }()
    
    
    var delegate: recyclingButtonDelegate?

    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: 55)
        super.init(frame: useFrame)
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // Detecting changing to Dark/Light theam.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        gradient_1.colors = [Colors.topGradient.cgColor,
                             Colors.bottomGradient.cgColor]
        gradient_2.colors = [Colors.topGradient.cgColor,
                             Colors.bottomGradient.cgColor]
        self.setNeedsLayout()
    }
    
    @objc
    func photoAction() {
        underCameraView.tap(completion: { _ in
            self.delegate?.openCamera()
        })
    }
    
    @objc
    func addAction() {
        addView.tap(completion: { _ in
            self.delegate?.add()
        })
    }
}






extension AddButtonWithPhotoView {
    private
    func setSubviews(){
        self.addSubview(underCameraView)
        underCameraView.layer.addSublayer(gradient_1)
        underCameraView.addSubview(photoView)
        photoView.addSubview(image)
        
        self.addSubview(addView)
        addView.layer.addSublayer(gradient_2)
        addView.addSubview(label)
        
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        underCameraView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(photoAction)))
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            underCameraView.leftAnchor.constraint(equalTo: self.leftAnchor),
            underCameraView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            underCameraView.widthAnchor.constraint(equalToConstant: underCameraView.frame.width),
            underCameraView.heightAnchor.constraint(equalToConstant: underCameraView.frame.height),
            
            photoView.topAnchor.constraint(equalTo: underCameraView.topAnchor, constant: 3.5),
            photoView.leftAnchor.constraint(equalTo: underCameraView.leftAnchor, constant: 3.5),
            photoView.rightAnchor.constraint(equalTo: underCameraView.rightAnchor, constant: -3.5),
            photoView.bottomAnchor.constraint(equalTo: underCameraView.bottomAnchor, constant: -3.5),
            
            image.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            addView.rightAnchor.constraint(equalTo: self.rightAnchor),
            addView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            addView.widthAnchor.constraint(equalToConstant: addView.frame.width),
            addView.heightAnchor.constraint(equalToConstant: addView.frame.height),
            
            label.centerXAnchor.constraint(equalTo: addView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: addView.centerYAnchor)
        ])
    }
}
