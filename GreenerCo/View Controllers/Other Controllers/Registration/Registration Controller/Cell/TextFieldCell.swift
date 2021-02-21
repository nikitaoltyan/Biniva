//
//  TextFieldCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class TextFieldCell: UICollectionViewCell {
    
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
    
    let textField: UITextField = {
        let view = UITextField()
            .with(bgColor: .clear)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(color: MainConstants.nearBlack)
            .with(keybordType: .default)
            .with(placeholder: "Email")
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
            .with(bgColor: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
            .with(color: .lightGray)
            .with(fontName: "SFPro", size: 13)
            .with(alignment: .center)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    func ActivateButton() {
        print("Button was activated")
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.backgroundColor = MainConstants.orange
            self.nextButton.layer.borderWidth = 0
            self.nextButton.label.textColor = MainConstants.white
            self.nextButton.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            self.nextButton.isActive = true
        })
    }
    
    
    func DisactivateButton() {
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.backgroundColor = .clear
            self.nextButton.layer.borderWidth = 1.2
            self.nextButton.label.textColor = .lightGray
            self.nextButton.label.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in
            self.nextButton.isActive = false
        })
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        switch cellNumber {
        case 0:
            if ((self.textField.text?.contains("@")) == true) &&
                ((self.textField.text?.contains(".")) == true) &&
                ((self.textField.text?.contains(" ")) == false) &&
                ((self.textField.text?.count ?? 0) > 7) {
                ActivateButton()
            } else {
                DisactivateButton()
            }
        case 1:
            if ((self.textField.text?.count ?? 0) > 7) &&
            ((self.textField.text?.contains(" ")) == false) &&
            ((self.textField.text?.contains("@")) == false){
                ActivateButton()
            } else {
                DisactivateButton()
            }
        default:
            if ((self.textField.text?.count ?? 0) > 5) &&
                ((self.textField.text?.contains(" ")) == false) &&
                ((self.textField.text?.contains("@")) == false) {
                ActivateButton()
            } else {
                DisactivateButton()
            }
        }
    }
    
    
    @objc func NextSlide(){
        guard (nextButton.isActive) else { return }
        delegate?.Scroll(slide: (cellNumber ?? -1) + 1)
        let text: String = textField.text!.lowercased()
        switch cellNumber {
        case 0:
            delegate?.PassEmail(email: ["email": text])
        case 1:
            delegate?.PassPassword(password: ["password": text])
        default:
            self.textField.endEditing(true)
            delegate?.PassUsername(username: ["username": text])
        }
    }
    
    
    @objc func ScrollBack() {
        guard ((cellNumber ?? 0) > 0) else {
            delegate?.Back()
            return
        }
        delegate?.Scroll(slide: (cellNumber ?? 1) - 1)
    }

}





extension TextFieldCell {
    
    func SetSubviews(){
        self.addSubview(mainLabel)
        self.addSubview(textField)
        self.addSubview(lineView)
        self.addSubview(explainLabel)
        self.addSubview(nextButton)
        self.addSubview(back)
        
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlide)))
        back.addTarget(self, action: #selector(ScrollBack), for: .touchUpInside)
    }
    
    func ActivateLayouts(){
        let mainLabelTop: CGFloat = {
            if MainConstants.screenHeight == 736 { return 70 }
            else if MainConstants.screenHeight > 700 { return 95 }
            else { return 80 }}()
        let backTop: CGFloat = {
            if MainConstants.screenHeight == 736 { return 13 }
            else { return 20 }}()
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: mainLabelTop),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            mainLabel.widthAnchor.constraint(equalToConstant: 250),
            
            textField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 55),
            textField.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            lineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            lineView.leftAnchor.constraint(equalTo: textField.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: textField.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.7),
            
            explainLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 6),
            explainLabel.leftAnchor.constraint(equalTo: textField.leftAnchor),
            explainLabel.rightAnchor.constraint(equalTo: textField.rightAnchor),
            
            nextButton.topAnchor.constraint(equalTo: explainLabel.bottomAnchor, constant: 45),
            nextButton.leftAnchor.constraint(equalTo: textField.leftAnchor),
            nextButton.rightAnchor.constraint(equalTo: textField.rightAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: backTop),
            back.rightAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width)
        ])
    }
}
