//
//  SubscriptionStatsController.swift
//  Biniva
//
//  Created by Nick Oltyan on 01.09.2021.
//

import UIKit

class SubscriptionStatsController: UIViewController {
    
    let analytics = ServerAnalytics()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1050)
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let backButton: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 35 }
            else { return 27 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale-5, height: scale))
            .with(autolayout: false)
        button.tintColor = Colors.nearBlack
        button.image = UIImage(systemName: "chevron.left")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let titleBlack: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...736: return 24
            default: return 25
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = NSLocalizedString("settings_sub_stats", comment: "")
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 16)
        label.text = NSLocalizedString("sub_stats_desc", comment: "")
        return label
    }()

    let usersView: SubStatsUsersView = {
        let view = SubStatsUsersView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    let garbageView: SubStatsGarbageView = {
        let view = SubStatsGarbageView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    let desc_2: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 13)
        label.text = NSLocalizedString("paywall_description_2", comment: "Description about used numbers in Plates")
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.logOpenSubscriptionStats()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }
    
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
}







extension SubscriptionStatsController {
    private
    func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(titleBlack)
        scrollView.addSubview(desc)
        scrollView.addSubview(usersView)
        scrollView.addSubview(garbageView)
        scrollView.addSubview(desc_2)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.topAnchor.constraint(equalTo: backButton.topAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            desc.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 30),
            desc.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            usersView.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 55),
            usersView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usersView.heightAnchor.constraint(equalToConstant: usersView.frame.height),
            usersView.widthAnchor.constraint(equalToConstant: usersView.frame.width),
            
            garbageView.topAnchor.constraint(equalTo: usersView.bottomAnchor, constant: 40),
            garbageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            garbageView.heightAnchor.constraint(equalToConstant: garbageView.frame.height),
            garbageView.widthAnchor.constraint(equalToConstant: garbageView.frame.width),
            
            desc_2.topAnchor.constraint(equalTo: garbageView.bottomAnchor, constant: 45),
            desc_2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            desc_2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
        ])
    }
}
