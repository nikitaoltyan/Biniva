//
//  AddButtonWithPhotoView.swift
//  Biniva
//
//  Created by Nick Oltyan on 23.07.2021.
//

import UIKit

class AddButtonWithPhotoView: UIView {
    
    lazy var photoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/3, height: 48))
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
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
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
        self.layer.cornerRadius = 55/2
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    @objc
    func photoAction() {
        print("photoAction")
        delegate?.openCamera()
    }
    
    @objc
    func addAction() {
        print("addAction")
        delegate?.add()
    }
}





extension AddButtonWithPhotoView {
    
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(photoView)
        self.addSubview(label)
        self.photoView.addSubview(image)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        self.photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(photoAction)))
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            photoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3.5),
            photoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoView.widthAnchor.constraint(equalToConstant: photoView.frame.width),
            photoView.heightAnchor.constraint(equalToConstant: photoView.frame.height),
            
            image.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.photoView.frame.width/2 - 6),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
