//
//  EnableLocationCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 28.01.2021.
//

import UIKit
import CoreLocation

class EnableLocationCell: UICollectionViewCell {
    
    let back: UIButton = {
        let scale: CGFloat = 30
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Bold", size: 35)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
            .with(color: .lightGray)
            .with(fontName: "SFPro", size: 13)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enableLocation: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-90, height: 53))
            .with(bgColor: MainConstants.orange)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "ВКЛЮЧИТЬ ГЕОЛОКАЦИЮ"
        view.label.font = UIFont(name: "SFPro-Medium", size: 16)
        view.label.textColor = MainConstants.white
        view.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.isActive = true
        return view
    }()
    
    let nextButton: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-90, height: 53))
            .with(borderWidth: 1.2, color: UIColor.lightGray.cgColor)
            .with(bgColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "ПРОДОЛЖИТЬ"
        view.label.font = UIFont(name: "SFPro-Medium", size: 16)
        view.label.textColor = .lightGray
        view.isActive = false
        return view
    }()
    
    var cellNumber: Int?
    var delegate: RegistrationDelegate?
    let locationManager = CLLocationManager()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    @objc func EnableLocation(){
        guard (enableLocation.isActive) else { return }
//        locationManager.requestAlwaysAuthorization()
        print("Request when in use")
        locationManager.requestWhenInUseAuthorization()
        print("Request always")
        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            print("Location available")
//            nextButton.isActive = true
//            ActivateButton()
//        }
    }
    
    func ActivateButton(){
        guard (nextButton.isActive) else { return }
        UIView.animate(withDuration: 0.19, delay: 0.9, options: .curveEaseOut, animations: {
            self.nextButton.backgroundColor = MainConstants.orange
            self.nextButton.layer.borderWidth = 0
            self.nextButton.label.textColor = MainConstants.white
            self.nextButton.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in })
    }
    
    
    @objc func NextSlide(){
        guard (nextButton.isActive) else { return }
        delegate?.Scroll(slide: (cellNumber ?? 4) + 1)
    }
    
    
    @objc func ScrollBack() {
        delegate?.Scroll(slide: (cellNumber ?? 3) - 1)
    }
}





extension EnableLocationCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager function")
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            print("Status changed to \(status)")
            nextButton.isActive = true
            ActivateButton()
        }
    }
}




extension EnableLocationCell {
    
    func SetSubviews(){
        locationManager.delegate = self
        
        self.addSubview(mainLabel)
        self.addSubview(back)
        self.addSubview(explainLabel)
        self.addSubview(enableLocation)
        self.addSubview(nextButton)
        
        back.addTarget(self, action: #selector(ScrollBack), for: .touchUpInside)
        enableLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EnableLocation)))
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlide)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 95),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            mainLabel.widthAnchor.constraint(equalToConstant: 250),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            back.rightAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width),
            
            explainLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 12),
            explainLabel.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
            explainLabel.widthAnchor.constraint(equalToConstant: 320),
            
            enableLocation.topAnchor.constraint(equalTo: explainLabel.bottomAnchor, constant: 180),
            enableLocation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            enableLocation.heightAnchor.constraint(equalToConstant: enableLocation.frame.height),
            enableLocation.widthAnchor.constraint(equalToConstant: enableLocation.frame.width),
            
            nextButton.topAnchor.constraint(equalTo: enableLocation.bottomAnchor, constant: 30),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height),
            nextButton.widthAnchor.constraint(equalToConstant: nextButton.frame.width)
        ])
    }
}
