//
//  TopView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.04.2021.
//

import UIKit

class TopView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(fontName: "SFPro-Semibold", size: 28)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: .gray)
            .with(alignment: .left)
            .with(fontName: "SFPro-Regular", size: 18)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            .with(autolayout: false)
            .with(bgColor: .clear)
        let image = UIImage(systemName: "gearshape.fill")?.withRenderingMode(.alwaysTemplate)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(image, for: .normal)
        button.tintColor = Colors.darkGrayText
        
        button.isHidden = true
        return button
    }()

    var delegate: topViewDelegate?
    
    override init(frame: CGRect) {
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 130 }
            else { return 95 }
        }()
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: height)
        super.init(frame: useFrame)
        self.title.text = NSLocalizedString("top_view_title_recycling", comment: "recycling topView Label")
        self.subtitle.text = NSLocalizedString("top_view_subtitle_recycling", comment: "recycling topView support subtitle")
        self.backgroundColor = .white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func openSettings() {
        delegate?.openSettings()
    }
}



extension TopView: TopViewDelegate {
    func updateTitles(isRecylcing: Bool) {
        var translation: CGFloat { if (isRecylcing) {return 300} else {return -300}}
        UIView.animate(withDuration: 0.15, animations: {
            self.title.transform = CGAffineTransform.init(translationX: translation, y: 0)
            self.subtitle.transform = CGAffineTransform.init(translationX: translation, y: 0)
        }, completion: { (_) in
            self.title.transform = CGAffineTransform(translationX: -translation, y: 0)
            self.subtitle.transform = CGAffineTransform(translationX: -translation, y: 0)
            UIView.animate(withDuration: 0.15, animations: {
                self.title.transform = CGAffineTransform.init(translationX: 0, y: 0)
                self.subtitle.transform = CGAffineTransform.init(translationX: 0, y: 0)
            })
        })
        if (isRecylcing) {
            title.text = NSLocalizedString("top_view_title_recycling", comment: "recycling topView Label")
            subtitle.text = NSLocalizedString("top_view_subtitle_recycling", comment: "recycling topView support subtitle")
        } else {
            title.text = NSLocalizedString("top_view_title_stats", comment: "stats topView support subtitle")
            subtitle.text = NSLocalizedString("top_view_subtitle_stats", comment: "stats topView support subtitle")
        }
    }
}




extension TopView {
    func SetSubviews(){
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(settingsButton)
        
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            subtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 26),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            
            title.leftAnchor.constraint(equalTo: subtitle.leftAnchor),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -4),
            
            settingsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -26),
            settingsButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: settingsButton.frame.width),
            settingsButton.heightAnchor.constraint(equalToConstant: settingsButton.frame.height)
        ])
    }
}
