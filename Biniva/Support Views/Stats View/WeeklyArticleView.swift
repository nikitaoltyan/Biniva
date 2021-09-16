//
//  WeeklyArticleView.swift
//  Biniva
//
//  Created by Nick Oltyan on 23.08.2021.
//

import UIKit


class WeeklyArticleView: UIView {
    
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
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: 30)
        label.text = NSLocalizedString("stats_weekly_article_title", comment: "")
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
            .with(autolayout: false)
        return image
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 165)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 30
        setSubviews()
        activateLayouts()
        update()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        self.setNeedsLayout()
    }
    
    func update() {
        if Defaults.getIsSubscribed() {
            let imageNumber = Int.random(in: 0...6)
            image.image = UIImage(named: "article_cover_\(imageNumber)")
            image.transform = CGAffineTransform(rotationAngle: .pi/5)
        } else {
            let imageNumber = Int.random(in: 0...2)
            image.image = UIImage(named: "article_cover_unsubscribed_\(imageNumber)")
            image.transform = CGAffineTransform(scaleX: 0.9, y: 0.7)
        }
    }
}




extension WeeklyArticleView {
    private
    func setSubviews() {
        self.layer.addSublayer(gradient)
        self.addSubview(image)
        self.addSubview(title)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: self.frame.width * 0.8),
            
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            title.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),
        ])
    }
}
