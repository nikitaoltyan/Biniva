//
//  AskForCommentView.swift
//  Biniva
//
//  Created by Nick Oltyan on 10.09.2021.
//

import UIKit

class AskForCommentView: UIView {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.3)
        return gradient
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: 24)
        label.text = NSLocalizedString("leave_comment_title", comment: "")
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
            .with(autolayout: false)
        image.image = UIImage(named: "ask_for_comment")
        return image
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 100)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 30
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}







extension AskForCommentView {
    private
    func setSubviews() {
        self.layer.addSublayer(gradient)
        self.addSubview(title)
        self.addSubview(image)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            title.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),
        ])
    }
}
