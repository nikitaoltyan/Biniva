//
//  ThemeViewController.swift
//  Biniva
//
//  Created by Nick Oltyan on 17.09.2021.
//

import UIKit

class ThemeViewController: UIViewController {
    
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
        label.text = NSLocalizedString("change_theme_title", comment: "")
        return label
    }()
    
    let lightPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-30, height: 60))
            .with(autolayout: false)
            .with(cornerRadius: 16)
        view.layer.borderColor = Colors.topGradient.cgColor
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    lazy var lightGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.lightPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let lightTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("change_theme_light", comment: "")
        return label
    }()
    
    let darkPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-30, height: 60))
            .with(autolayout: false)
            .with(cornerRadius: 16)
        view.layer.borderColor = Colors.topGradient.cgColor
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    lazy var darkGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.darkPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let darkTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("change_theme_dark", comment: "")
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        setInitialBorder()
    }

    // Detecting changing to Dark/Light theam.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        lightPlateView.layer.borderColor = Colors.topGradient.cgColor
        darkPlateView.layer.borderColor = Colors.topGradient.cgColor
        lightGradient.colors = [Colors.background.cgColor,
                                Colors.sliderGray.cgColor]
        darkGradient.colors = [Colors.background.cgColor,
                               Colors.sliderGray.cgColor]
        view.setNeedsLayout()
    }
    
    private
    func setInitialBorder() {
        switch traitCollection.userInterfaceStyle {
        case .light: lightPlateView.layer.borderWidth = 3
        case .dark: darkPlateView.layer.borderWidth = 3
        default: break  // For some trouble events. Shouldn't be called.
        }
    }
    
    @objc
    func lightAction() {
        guard lightPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        appDelegate.changeTheme(theme: .light)
        print("lightAction")
        view.overrideUserInterfaceStyle = .light
        UIView.animate(withDuration: 0.1, animations: {
            self.lightPlateView.layer.borderWidth = 3
            self.darkPlateView.layer.borderWidth = 0
        })
    }
    
    @objc
    func darkAction() {
        guard darkPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        appDelegate.changeTheme(theme: .dark)
        print("darkAction")
        view.overrideUserInterfaceStyle = .dark
        UIView.animate(withDuration: 0.1, animations: {
            self.darkPlateView.layer.borderWidth = 3
            self.lightPlateView.layer.borderWidth = 0
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
}







extension ThemeViewController {
    private
    func setSubviews() {
        view.addSubview(backButton)
        view.addSubview(titleBlack)
        
        view.addSubview(lightPlateView)
        view.addSubview(darkPlateView)
        
        lightPlateView.layer.addSublayer(lightGradient)
        lightPlateView.addSubview(lightTitle)
        darkPlateView.layer.addSublayer(darkGradient)
        darkPlateView.addSubview(darkTitle)
        
        lightPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lightAction)))
        darkPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(darkAction)))
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.topAnchor.constraint(equalTo: backButton.topAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            lightPlateView.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 160),
            lightPlateView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            lightPlateView.widthAnchor.constraint(equalToConstant: lightPlateView.frame.width),
            lightPlateView.heightAnchor.constraint(equalToConstant: lightPlateView.frame.height),
            
            lightTitle.centerXAnchor.constraint(equalTo: lightPlateView.centerXAnchor),
            lightTitle.centerYAnchor.constraint(equalTo: lightPlateView.centerYAnchor),
            
            darkPlateView.topAnchor.constraint(equalTo: lightPlateView.topAnchor),
            darkPlateView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            darkPlateView.widthAnchor.constraint(equalToConstant: darkPlateView.frame.width),
            darkPlateView.heightAnchor.constraint(equalToConstant: darkPlateView.frame.height),
            
            darkTitle.centerXAnchor.constraint(equalTo: darkPlateView.centerXAnchor),
            darkTitle.centerYAnchor.constraint(equalTo: darkPlateView.centerYAnchor),
        ])
    }
}
