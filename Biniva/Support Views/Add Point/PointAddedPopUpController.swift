//
//  PointAddedPopUpController.swift
//  Biniva
//
//  Created by Nick Oltyan on 30.06.2021.
//

import UIKit

class PointAddedPopUpController: UIViewController {
    
    let popUpView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 315, height: 410))
            .with(autolayout: false)
            .with(bgColor: Colors.background)
            .with(cornerRadius: 16)
        
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    let mainTitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 20)
            .with(autolayout: false)
        label.text = "Добавлено!"
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 130))
            .with(autolayout: false)
        image.image = UIImage(named: "moderation")
        return image
    }()
    
    let desc: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
            .with(autolayout: false)
        label.text = "Контейнер для мусора отправлен на модерацию. В ближайшее время он появится на карте. Спасибо!"
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 210, height: 40))
            .with(autolayout: false)
            .with(bgColor: .lightGray)
            .with(cornerRadius: 12)
        
        button.setTitle("Отлично!", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFPro", size: 18)
        button.setTitleColor(Colors.background, for: .normal)
        
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.backgroundColor = Colors.nearBlack.withAlphaComponent(0.2)
        })
    }

    @objc
    func close() {
        Vibration.soft()
        addButton.tap(completion: { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.view.backgroundColor = .clear
            }, completion: { (_) in
                self.dismiss(animated: true, completion: nil)
            })
        })
    }
}






extension PointAddedPopUpController {
    func setSubviews() {
        view.addSubview(popUpView)
        popUpView.addSubview(mainTitle)
        popUpView.addSubview(image)
        popUpView.addSubview(desc)
        popUpView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.widthAnchor.constraint(equalToConstant: popUpView.frame.width),
            popUpView.heightAnchor.constraint(equalToConstant: popUpView.frame.height),
            
            mainTitle.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 15),
            mainTitle.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor),
            
            image.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 17),
            image.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: image.frame.width),
            image.heightAnchor.constraint(equalToConstant: image.frame.height),
            
            addButton.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: addButton.frame.width),
            addButton.heightAnchor.constraint(equalToConstant: addButton.frame.height),
            
            desc.leftAnchor.constraint(equalTo: popUpView.leftAnchor, constant: 23),
            desc.rightAnchor.constraint(equalTo: popUpView.rightAnchor, constant: -23),
            desc.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -39),
        ])
    }
}
