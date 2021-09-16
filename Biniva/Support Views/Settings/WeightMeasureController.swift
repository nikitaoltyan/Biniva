//
//  WeightMeasureController.swift
//  Biniva
//
//  Created by Nick Oltyan on 08.08.2021.
//

import UIKit

class WeightMeasureController: UIViewController {
    
    let measure = Measure()
    
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
        label.text = NSLocalizedString("onboarding_6_title", comment: "Title for that cell")
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 40
            default: return 48
            }
        }()
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: textSize)
            .with(autolayout: false)
        label.text = measure.getMeasurementString(weight: 1100, forNeededType: .kilogramm)
        return label
    }()
    
    let metricPlateView: UIView = {
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
    
    lazy var metricGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.metricPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let metricTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("onboarding_6_metric_title", comment: "name of metric system")
        return label
    }()
    
    let imperialPlateView: UIView = {
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
    
    lazy var imperialGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.metricPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let imperialTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 17)
        label.text = NSLocalizedString("onboarding_6_imperial_title", comment: "name of imperial system")
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setInitialBorder()
        setSubviews()
        activateLayouts()
    }
    
    // Detecting changing to Dark/Light theam.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        metricPlateView.layer.borderColor = Colors.topGradient.cgColor
        imperialPlateView.layer.borderColor = Colors.topGradient.cgColor
        metricGradient.colors = [Colors.background.cgColor,
                                 Colors.sliderGray.cgColor]
        imperialGradient.colors = [Colors.background.cgColor,
                                   Colors.sliderGray.cgColor]
        view.setNeedsLayout()
    }
    
    
    private
    func setInitialBorder() {
        switch Defaults.getWeightSystem() {
        case 0: metricPlateView.layer.borderWidth = 3
        case 1: imperialPlateView.layer.borderWidth = 3
        default: break  // For some trouble events. Shouldn't be called.
        }
    }
    
    @objc
    func metricAction() {
        guard metricPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        Defaults.setWeightSystem(typeOfSystem: 0) // Metric
        weightLabel.text = measure.getMeasurementString(weight: 1100, forNeededType: .kilogramm)
        UIView.animate(withDuration: 0.1, animations: {
            self.metricPlateView.layer.borderWidth = 3
            self.imperialPlateView.layer.borderWidth = 0
        })
    }
    
    @objc
    func imperialAction() {
        guard imperialPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        Defaults.setWeightSystem(typeOfSystem: 1) // Imperial
        weightLabel.text = measure.getMeasurementString(weight: 1100, forNeededType: .kilogramm)
        UIView.animate(withDuration: 0.1, animations: {
            self.imperialPlateView.layer.borderWidth = 3
            self.metricPlateView.layer.borderWidth = 0
        })
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
}







extension WeightMeasureController {
    private
    func setSubviews() {
        view.addSubview(backButton)
        view.addSubview(titleBlack)
        
        view.addSubview(weightLabel)
        view.addSubview(metricPlateView)
        view.addSubview(imperialPlateView)
        
        metricPlateView.layer.addSublayer(metricGradient)
        metricPlateView.addSubview(metricTitle)
        imperialPlateView.layer.addSublayer(imperialGradient)
        imperialPlateView.addSubview(imperialTitle)
        
        metricPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(metricAction)))
        imperialPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imperialAction)))
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
            
            weightLabel.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 90),
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            metricPlateView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 40),
            metricPlateView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            metricPlateView.widthAnchor.constraint(equalToConstant: metricPlateView.frame.width),
            metricPlateView.heightAnchor.constraint(equalToConstant: metricPlateView.frame.height),
            
            metricTitle.centerXAnchor.constraint(equalTo: metricPlateView.centerXAnchor),
            metricTitle.centerYAnchor.constraint(equalTo: metricPlateView.centerYAnchor),
            
            imperialPlateView.topAnchor.constraint(equalTo: metricPlateView.topAnchor),
            imperialPlateView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            imperialPlateView.widthAnchor.constraint(equalToConstant: imperialPlateView.frame.width),
            imperialPlateView.heightAnchor.constraint(equalToConstant: imperialPlateView.frame.height),
            
            imperialTitle.centerXAnchor.constraint(equalTo: imperialPlateView.centerXAnchor),
            imperialTitle.centerYAnchor.constraint(equalTo: imperialPlateView.centerYAnchor),
        ])
    }
}
