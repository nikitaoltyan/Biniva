//
//  LogInController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 10.02.2021.
//

import UIKit

class LogInController: UIViewController {
    
    let back: UIButton = {
        let scale: CGFloat = 30
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Bold", size: 30)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    
    let emailField: UITextField = {
        let view = UITextField()
            .with(bgColor: .clear)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(color: MainConstants.nearBlack)
            .with(keybordType: .emailAddress)
            .with(placeholder: "Email")
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
        view.tag = 0
        return view
    }()
    
    let emailLine: UIView = {
        let view = UIView()
            .with(bgColor: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Bold", size: 30)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        return label
    }()
    
    let passwordField: UITextField = {
        let view = UITextField()
            .with(bgColor: .clear)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(color: MainConstants.nearBlack)
            .with(keybordType: .default)
            .with(placeholder: "Password")
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
        view.tag = 1
        return view
    }()
    
    let passwordLine: UIView = {
        let view = UIView()
            .with(bgColor: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    var emailReady: Bool = false
    var passwordReady: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    

    @objc func textFieldDidChange(textField: UITextField) {
        let tag = textField.tag
        switch tag {
        case 0:
            if ((textField.text?.contains("@")) == true) &&
                ((textField.text?.contains(".")) == true) &&
                ((textField.text?.contains(" ")) == false) &&
                ((textField.text?.count ?? 0) > 7) {
                emailReady = true
                ActivateButton()
            } else {
                emailReady = false
                DisactivateButton()
            }
        default:
            if ((textField.text?.count ?? 0) > 7) &&
                ((textField.text?.contains(" ")) == false) &&
                ((textField.text?.contains("@")) == false) {
                passwordReady = true
                ActivateButton()
            } else {
                passwordReady = false
                DisactivateButton()
            }
        }
    }
    
    
    func ActivateButton() {
        guard (emailReady && passwordReady) else { return }
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
    
    
    @objc func LogIn() {
        guard (nextButton.isActive) else { return }
        Vibration.Medium()
        Server.AuthUser(withEmail: emailField.text!, password: passwordField.text!)
        print("User was logged in")
        tabBarController?.selectedIndex = 0
        DispatchQueue.main.async { self.ShowAfterLogInPopUp() }
    }

    
    @objc func Back() {
        Vibration.Soft()
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    func ShowAfterLogInPopUp() {
        sleep(1)
        let newVC = PopUpController()
        newVC.modalPresentationStyle = .overFullScreen
        self.present(newVC, animated: false, completion: nil)
    }
}



extension LogInController {
    
    func SetSubviews(){
        view.addSubview(back)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(emailLine)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordLine)
        view.addSubview(nextButton)
        
        emailField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LogIn)))
        back.addTarget(self, action: #selector(Back), for: .touchUpInside)
    }
    
    
    func ActivateLayouts() {
        let emailTop: CGFloat = {if MainConstants.screenHeight>700 { return 95 } else { return 80 }}()
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: emailTop),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40),
            emailField.leftAnchor.constraint(equalTo: emailLabel.leftAnchor),
            emailField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            
            emailLine.topAnchor.constraint(equalTo: emailField.bottomAnchor),
            emailLine.leftAnchor.constraint(equalTo: emailField.leftAnchor),
            emailLine.rightAnchor.constraint(equalTo: emailField.rightAnchor),
            emailLine.heightAnchor.constraint(equalToConstant: 0.7),
            
            passwordLabel.topAnchor.constraint(equalTo: emailLine.bottomAnchor, constant: 60),
            passwordLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor),
            
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 40),
            passwordField.leftAnchor.constraint(equalTo: passwordLabel.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: emailField.rightAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLine.topAnchor.constraint(equalTo: passwordField.bottomAnchor),
            passwordLine.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
            passwordLine.rightAnchor.constraint(equalTo: passwordField.rightAnchor),
            passwordLine.heightAnchor.constraint(equalToConstant: 0.7),
            
            nextButton.topAnchor.constraint(equalTo: passwordLine.bottomAnchor, constant: 45),
            nextButton.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
            nextButton.rightAnchor.constraint(equalTo: passwordField.rightAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height),
            
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            back.rightAnchor.constraint(equalTo: emailLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width)
        ])
    }
}
