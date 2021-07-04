//
//  Onboarding_3_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_3_Cell: UICollectionViewCell {
    
    let progressView: ProgressView = {
        let height: CGFloat = 320
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: height, height: height))
            .with(autolayout: false)
        return view
    }()
    
    let titleBlack: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Отслеживай свое потребление и"
        return label
    }()
    
    let titleGreen: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "создавай полезные привычки"
        return label
    }()
    
    let subtitleGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
        label.text = "В среднем каждый житель Земли создает 1,1 килограмм мусора в день. Давай снизим это число?"
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = "Продолжить"
        return view
    }()
    
    var delegate: OnbordingDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        progressView.update(addWeight: 995)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func buttonTap() {
        button.tap(completion: { (_) in
            self.delegate?.next(slide: 3)
        })
    }
}




extension Onboarding_3_Cell {
    func setSubviews() {
        self.addSubview(progressView)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            
            titleBlack.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 27),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 15),
            titleGreen.leftAnchor.constraint(equalTo: titleBlack.leftAnchor),
            titleGreen.rightAnchor.constraint(equalTo: titleBlack.rightAnchor),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: 30),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -58),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
        ])
    }
}
