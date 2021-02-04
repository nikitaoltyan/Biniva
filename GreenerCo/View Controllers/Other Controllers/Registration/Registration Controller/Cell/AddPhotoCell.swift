//
//  AddPhotoCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {
    
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
    
    let avatar: UIImageView = {
        let scale: CGFloat = 250
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(borderWidth: 1.2, color: UIColor.lightGray.cgColor)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Avatar")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        image.isUserInteractionEnabled = true
        return image
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
        _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(ActivateButton), userInfo: nil, repeats: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    @objc func ActivateButton(){
        guard (nextButton.isActive) else { return }
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.backgroundColor = MainConstants.orange
            self.nextButton.layer.borderWidth = 0
            self.nextButton.label.textColor = MainConstants.white
            self.nextButton.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in })
    }
    
    
    @objc func NextSlide(){
        guard (nextButton.isActive) else { return }
        delegate?.Scroll(slide: (cellNumber ?? 3) + 1)
    }
    
    
    @objc func ScrollBack() {
        delegate?.Scroll(slide: (cellNumber ?? 3) - 1)
    }
    
    
    @objc func ChangeImage() {
        delegate?.PickerController()
    }
}

    




extension AddPhotoCell {
    
    func SetSubviews(){
        self.addSubview(mainLabel)
        self.addSubview(avatar)
        self.addSubview(back)
        self.addSubview(nextButton)
        
        back.addTarget(self, action: #selector(ScrollBack), for: .touchUpInside)
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlide)))
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeImage)))
    }
    
    func ActivateLayouts(){
        let mainLabelTop: CGFloat = {if MainConstants.screenHeight>700 { return 95 } else { return 80 }}()
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: mainLabelTop),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            mainLabel.widthAnchor.constraint(equalToConstant: 250),
            
            avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 45),
            avatar.heightAnchor.constraint(equalToConstant: avatar.frame.height),
            avatar.widthAnchor.constraint(equalToConstant: avatar.frame.width),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            back.rightAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width),
            
            nextButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 80),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height),
            nextButton.widthAnchor.constraint(equalToConstant: nextButton.frame.width)
        ])
    }
}




protocol AddPhotoDelegate {
    func SetPhoto(image: UIImage)
}
