//
//  LeaveCommentController.swift
//  Biniva
//
//  Created by Nick Oltyan on 14.08.2021.
//

import UIKit

class LeaveCommentController: UIViewController {
    
    let server = Server()
    
    let backButton: UIImageView = {
        let scale: CGFloat = {
            if MainConstants.screenHeight > 700 { return 35 }
            else { return 27 }
        }()
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale-5, height: scale))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
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
        label.text = NSLocalizedString("leave_comment_title", comment: "Title for that controller")
        return label
    }()
    
    lazy var titleText: UITextField = {
        let view = UITextField()
            .with(autolayout: false)
            .with(keybordType: .default)
            .with(placeholder: NSLocalizedString("leave_comment_title_placeholder", comment: ""))
            .with(fontName: "SFPro-Semibold", size: 18)
        view.textColor = Colors.nearBlack
        return view
    }()
    
    let graySeparator: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-50, height: 2))
            .with(autolayout: false)
            .with(bgColor: Colors.grayCircle)
            .with(cornerRadius: 1)
        return view
    }()
    
    lazy var commentText: UITextView = {
        let view = UITextView()
            .with(autolayout: false)
            .with(fontName: "SFPro-Regular", size: 16)
            .with(bgColor: .clear)
            .with(keybordType: .default)
            .with(textContainerInset: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        view.delegate = self
        view.text = NSLocalizedString("leave_comment_text_placeholder", comment: "")
        view.textColor = Colors.grayCircle
        return view
    }()
    
    let graySeparator_2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-50, height: 2))
            .with(autolayout: false)
            .with(bgColor: Colors.grayCircle)
            .with(cornerRadius: 1)
        return view
    }()
    
    lazy var emailText: UITextField = {
        let view = UITextField()
            .with(autolayout: false)
            .with(keybordType: .emailAddress)
            .with(placeholder: NSLocalizedString("leave_comment_email_placeholder", comment: ""))
            .with(fontName: "SFPro-Regular", size: 16)
        view.textColor = Colors.nearBlack
        view.delegate = self
        return view
    }()
    
    let sendButton: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("leave_comment_button", comment: "the Send label")
        return view
    }()
    
    var currentTextField: UITextField?
    var buttonBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        hideKeyboardWhenTappedAround()
        setSubviews()
        activateLayouts()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        guard currentTextField == emailText else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
                self.buttonBottomConstraint?.constant = -keyboardSize.height
                UIView.animate(withDuration: 0.4, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            
        }
        
//        let buttonBottomConstant: CGFloat = {
//            switch MainConstants.screenHeight {
//            case ...700: return -150
//            case 736: return -150
//            default: return -200
//            }
//        }()
        
//        buttonBottomConstraint?.constant = buttonBottomConstant
//        UIView.animate(withDuration: 0.4, animations: {
//            self.view.layoutIfNeeded()
//        })
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        guard currentTextField == emailText else { return }
        
        let buttonBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -24
            case 736: return -35
            default: return -58
            }
        }()
        
        buttonBottomConstraint?.constant = buttonBottomConstant
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        
        currentTextField = nil
    }
    
    @objc
    func closeKeyboard(sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc
    func backAction() {
        backButton.tap(completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc
    func sendAction() {
        sendButton.tap(completion: { _ in
            // TODO:
            // Implement cending message to the server
            guard !(self.titleText.text?.isEmpty ?? true) else {
                self.showAlert(withTitle: NSLocalizedString("leave_comment_title_error_title", comment: ""),
                          andSubtitle: NSLocalizedString("leave_comment_title_error_subtitle", comment: ""))
                return
            }
            
            guard !(self.commentText.textColor == Colors.grayCircle)
                || !(self.titleText.text?.isEmpty ?? true) else {
                self.showAlert(withTitle: NSLocalizedString("leave_comment_comment_error_title", comment: ""),
                          andSubtitle: NSLocalizedString("leave_comment_comment_error_subtitle", comment: ""))
                return
            }
            
            
            DispatchQueue.main.async {
                self.server.createNewComment(withTitle: self.titleText.text ?? "",
                                             text: self.commentText.text ?? "",
                                             andEmail: self.emailText.text ?? "")
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    private
    func showAlert(withTitle title: String, andSubtitle subtitle: String) {
        let alert = prepareAlert(withTitle: title,
                                 andSubtitle: subtitle,
                                 closeAction: NSLocalizedString("leave_comment_error_close", comment: ""))
        present(alert, animated: true, completion: nil)
    }
}





extension LeaveCommentController: UITextViewDelegate, UITextFieldDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.grayCircle {
            commentText.text = nil
            commentText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            commentText.text = NSLocalizedString("leave_comment_text_placeholder", comment: "")
            commentText.textColor = Colors.grayCircle
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
}






extension LeaveCommentController {
    private
    func setSubviews() {
        view.addSubview(backButton)
        view.addSubview(titleBlack)
        view.addSubview(titleText)
        view.addSubview(graySeparator)
        view.addSubview(commentText)
        view.addSubview(graySeparator_2)
        view.addSubview(emailText)
        
        view.addSubview(sendButton)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
        sendButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendAction)))
        titleText.addDoneButton(title: NSLocalizedString("leave_comment_done_button", comment: ""),
                                target: self, selector: #selector(closeKeyboard))
        commentText.addDoneButton(title: NSLocalizedString("leave_comment_done_button", comment: ""),
                                  target: self, selector: #selector(closeKeyboard))
        emailText.addDoneButton(title: NSLocalizedString("leave_comment_done_button", comment: ""),
                                target: self, selector: #selector(closeKeyboard))
    }
    
    private
    func activateLayouts() {
        let topBackButtonConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 45
            default: return 70
            }
        }()
        
        let topTitleTextConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 20
            default: return 30
            }
        }()
        
        let buttonBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -24
            case 736: return -35
            default: return -58
            }
        }()
        
        let emailTextBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -20
            case 736: return -30
            default: return -40
            }
        }()
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topBackButtonConstant),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            titleBlack.topAnchor.constraint(equalTo: backButton.topAnchor),
            titleBlack.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            titleText.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: topTitleTextConstant),
            titleText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            titleText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            titleText.heightAnchor.constraint(equalToConstant: 40),
            
            graySeparator.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 1),
            graySeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            graySeparator.widthAnchor.constraint(equalToConstant: graySeparator.frame.width),
            graySeparator.heightAnchor.constraint(equalToConstant: graySeparator.frame.height),
            
//            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonBottomConstant),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: sendButton.frame.width),
            sendButton.heightAnchor.constraint(equalToConstant: sendButton.frame.height),
            
            emailText.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: emailTextBottomConstant),
            emailText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            emailText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            emailText.heightAnchor.constraint(equalToConstant: 40),
            
            graySeparator_2.bottomAnchor.constraint(equalTo: emailText.topAnchor, constant: -6),
            graySeparator_2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            graySeparator_2.widthAnchor.constraint(equalToConstant: graySeparator_2.frame.width),
            graySeparator_2.heightAnchor.constraint(equalToConstant: graySeparator_2.frame.height),
            
            commentText.topAnchor.constraint(equalTo: graySeparator.bottomAnchor, constant: 6),
            commentText.leftAnchor.constraint(equalTo: view.leftAnchor),
            commentText.rightAnchor.constraint(equalTo: view.rightAnchor),
            commentText.bottomAnchor.constraint(equalTo: graySeparator_2.topAnchor, constant: -6),
        ])
        
        buttonBottomConstraint = sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonBottomConstant)
        buttonBottomConstraint?.isActive = true
    }
}
