//
//  MaterialInfoButton.swift
//  Biniva
//
//  Created by Nick Oltyan on 07.09.2021.
//


import UIKit

class MaterialInfoButton: UIView {
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            .with(autolayout: false)
        image.image = UIImage(systemName: "questionmark.circle")
        image.tintColor = Colors.darkGrayText
        return image
    }()

    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension MaterialInfoButton {
    private
    func setSubviews() {
        self.addSubview(image)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height)
        ])
    }
}
