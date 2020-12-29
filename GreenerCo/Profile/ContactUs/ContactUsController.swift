//
//  ContactUsController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 14.11.2020.
//

import UIKit

class ContactUsController: UIViewController {
    
    var back: UIButton!
    var mainTitle: UILabel!
    var infoText: UILabel!
    var textField: UITextView!
    var button: UIButton!
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        BackButton()
        TitleLayer()
        InfoLayer()
        TextFieldLayer()
        SendButtonLayer()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DismissAction(_:))))
    }
    
    @objc func BackAction(sender: UIButton!) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    @objc func SendAction(sender: UIButton!) {
        button.setTitle("Доставлено", for: .normal)
        print("Доставлено")
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 0.5)
        SendToFirebase()
    }
    
    func SendToFirebase(){
        
    }
    
    func BackButton(){
        let backButton = UIButton()
        backButton.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        view.addSubview(backButton)
        let useImage = UIImage(systemName: "chevron.left")
        backButton.setImage(useImage, for: .normal)
        back = backButton
        back.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            back.heightAnchor.constraint(equalToConstant: 30),
            back.widthAnchor.constraint(equalToConstant: 30)
        ])
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    @objc func DismissAction(_ sender: UIPanGestureRecognizer){
        print("Dismiss action")
        let touchPoint = sender.location(in: self.view.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.x - initialTouchPoint.x > 0 {
                self.view.frame = CGRect(x: touchPoint.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled{
            if touchPoint.x - initialTouchPoint.x > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }, completion: { finished in
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func TitleLayer(){
        let title = UILabel()
        view.addSubview(title)
        mainTitle = title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 30),
            mainTitle.widthAnchor.constraint(equalToConstant: 272)
        ])
        mainTitle.text = "Связь"
        mainTitle.font = UIFont.init(name: "Palatino-Bold", size: 35.0)
        mainTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func InfoLayer(){
        let label = UILabel()
        view.addSubview(label)
        infoText = label
        infoText.numberOfLines = 0
        infoText.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        infoText.textAlignment = .left
        infoText.text = "Some custome description. \nWe can add here some custom text."
        infoText.font = UIFont.init(name: "SFPro", size: 21.0)
        infoText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 39),
            infoText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            infoText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            infoText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func TextFieldLayer(){
        let field = UITextView()
        view.addSubview(field)
        textField = field
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: infoText.bottomAnchor, constant: 30),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.layer.cornerRadius = 15
        textField.autocorrectionType = .yes
        textField.backgroundColor = MainConstants.white
        textField.textColor = .darkGray
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func SendButtonLayer(){
        let sendButton = UIButton()
        sendButton.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        view.addSubview(sendButton)
        button = sendButton
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 39),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 80),
            button.widthAnchor.constraint(equalToConstant: 240)
        ])
        button.layer.cornerRadius = 10
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFPro-Medium", size: 23)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(SendAction), for: .touchUpInside)
    }
}
