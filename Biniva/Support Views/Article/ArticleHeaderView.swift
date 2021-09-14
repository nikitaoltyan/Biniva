//
//  ArcticleHeaderView.swift
//  Biniva
//
//  Created by Nick Oltyan on 13.07.2021.
//

import UIKit

class ArticleHeaderView: UIView {
    
    let backButton: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 32 }
            else { return 25 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale-5))
            .with(autolayout: false)
        button.tintColor = Colors.nearBlack
        button.image = UIImage(systemName: "chevron.down")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let titleBlack: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 24
            case 736: return 24
            default: return 25
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("stats_weekly_article_title", comment: "")
        return label
    }()
    
    
    var delegate: articleHeaderDelegate?

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 70)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.delegate?.backAction()
        })
    }
}






extension ArticleHeaderView {
    private
    func setSubviews() {
        self.addSubview(backButton)
        self.addSubview(titleBlack)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.bottomAnchor.constraint(equalTo: backButton.bottomAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 13)
        ])
    }
}
