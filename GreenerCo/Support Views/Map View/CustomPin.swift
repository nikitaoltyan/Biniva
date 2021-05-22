//
//  CustomPin.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import UIKit
import MapKit

class CustomPin: MKAnnotationView {
    
    let imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            .with(autolayout: false)
        image.tintColor = Colors.nearBlack
        image.image = UIImage(systemName: "trash")
        return image
    }()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        self.backgroundColor = .orange
        self.layer.cornerRadius = 35/2
        canShowCallout = false
        setSubviews()
        activateLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}





extension CustomPin {
    func setSubviews(){
        self.addSubview(imageView)
    }
    
    func activateLayout(){
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.width)
        ])
    }
}
