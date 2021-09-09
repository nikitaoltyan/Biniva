//
//  RecyclingView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 19.04.2021.
//

import UIKit

protocol recyclingProgressDelegate {
    func update(addWeight weight: Int)
}

protocol recyclingButtonDelegate {
    func add()
    func openCamera()
}


class RecyclingView: UIView {
    
    let progressView: ProgressView = {
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 400 }
            else { return 380 }
        }()
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: height, height: height))
            .with(autolayout: false)
        return view
    }()
    
    let materialInfoButton: MaterialInfoButton = {
        let view = MaterialInfoButton()
            .with(autolayout: false)
        return view
    }()
    
    lazy var button: AddButtonWithPhotoView = {
        let view = AddButtonWithPhotoView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.delegate = self
        return view
    }()
    
    var delegate: RecyclingDelegate?

    
    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc private
    func openMaterialInfo() {
        materialInfoButton.tap(completion: { _ in
            self.delegate?.openMaterialInfo()
        })
    }
}





extension RecyclingView: recyclingProgressDelegate {
    func update(addWeight weight: Int) {
        progressView.update(addWeight: weight)
        AppStoreReviewManager.requestReview()
    }
}






extension RecyclingView: recyclingButtonDelegate {
    func openCamera() {
        self.delegate?.openCamera()
    }
    
    func add() {
        self.delegate?.add()
    }
}





extension RecyclingView {
    private
    func setSubviews(){
        self.addSubview(progressView)
        self.addSubview(materialInfoButton)
        self.addSubview(button)
        
        materialInfoButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMaterialInfo)))
    }
    
    private
    func activateLayouts(){
        let buttonBottomConst: CGFloat = {
            if MainConstants.screenHeight == 736 { return -40 }
            else if MainConstants.screenHeight > 700 { return -66 }
            else { return -30 }
        }()
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            
            materialInfoButton.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 25),
            materialInfoButton.leftAnchor.constraint(equalTo: progressView.leftAnchor, constant: 40),
            materialInfoButton.widthAnchor.constraint(equalToConstant: materialInfoButton.frame.width),
            materialInfoButton.heightAnchor.constraint(equalToConstant: materialInfoButton.frame.height),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonBottomConst),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width)
        ])
    }
}
