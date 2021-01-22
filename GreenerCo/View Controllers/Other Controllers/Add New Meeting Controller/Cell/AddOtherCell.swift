//
//  AddOtherCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 28.12.2020.
//

import UIKit
import AudioToolbox

class AddOtherCell: UICollectionViewCell {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1050)
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let pickDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 1
        label.text = "Выбери время проведения"
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 25} else {return 22}}()
        label.font = UIFont.init(name: "SFPro-Heavy", size: fontSize)
        return label
    }()
    
    let picker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.locale = .current
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
            if #available(iOS 13.4, *) {
                picker.preferredDatePickerStyle = .automatic
            } else {
                // Fallback on earlier versions
                print("Then fuck off")
            }
        }
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    let writeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 1
        label.text = "Назови свою встречу"
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 25} else {return 22}}()
        label.font = UIFont.init(name: "SFPro-Heavy", size: fontSize)
        return label
    }()
    
    lazy var commentField: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "SFPro-medium", size: 23)
        view.keyboardType = .default
        view.autocorrectionType = .yes
        view.isScrollEnabled = false
        view.delegate = self
        view.tag = 0
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        view.backgroundColor = MainConstants.nearWhite
        view.textColor = MainConstants.nearBlack
        view.textContainerInset = UIEdgeInsets(top: 6, left: 5, bottom: 6, right: 5)
        return view
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.text = "Используй не больше 6 символов"
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 10} else {return 8}}()
        label.font = UIFont.init(name: "SFPro", size: fontSize)
        return label
    }()
    
    let writeDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 1
        label.text = "Опиши свою встречу"
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 25} else {return 22}}()
        label.font = UIFont.init(name: "SFPro-Heavy", size: fontSize)
        return label
    }()
    
    lazy var descField: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        view.keyboardType = .default
        view.autocorrectionType = .yes
        view.isScrollEnabled = true
        view.delegate = self
        view.tag = 1
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        view.backgroundColor = MainConstants.nearWhite
        view.textColor = MainConstants.nearBlack
        view.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 6, right: 5)
        return view
    }()
    
    let sendButton: ButtonView = {
        let view = ButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = MainConstants.orange.cgColor
        return view
    }()
    
    var delegate: PassDataDelegate?
    var sendDelegate: AddMeetingSendDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    
    @objc func handler(sender: UIDatePicker) {
        let time = DateFormatter()
        let date = DateFormatter()
        time.timeStyle = DateFormatter.Style.medium
        date.dateStyle = DateFormatter.Style.medium
        delegate?.PassDate(date: date.string(from:  picker.date))
        delegate?.PassTime(time: time.string(from:  picker.date))
    }
    
    
    @objc func Send() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        sendDelegate?.Send()
    }
    
    
    func AnimateTextField(numberOfIterations count: Int){
        guard count<2 else {return}
        warningLabel.isHidden = false
        UIView.animate(withDuration: 0.07, delay: 0, options: .curveEaseOut, animations: {
            self.commentField.transform = CGAffineTransform(rotationAngle: .pi/70)
            let pink = UIColor(red: 242/255, green: 132/255, blue: 130/255, alpha: 1)
            self.commentField.layer.borderColor = pink.cgColor
        }, completion: {finished in
            print("Animated - 1")
            UIView.animate(withDuration: 0.07, delay: 0, options: .curveEaseOut, animations: {
                self.commentField.transform = CGAffineTransform(rotationAngle: -.pi/70)
            }, completion: {finished in
                print("Animated - 2")
                UIView.animate(withDuration: 0.07, delay: 0, options: .curveEaseOut, animations: {
                    self.commentField.transform = CGAffineTransform.identity
                }, completion: { finished in
                    print("Animated - 3")
                    self.AnimateTextField(numberOfIterations: count+1)
                    let _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in
                        self.warningLabel.isHidden = true
                        self.commentField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
                        print("Timer fired!")
                        return
                    }
                })
            })
        })
    }
}





extension AddOtherCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.tag == 0 else {return true}
        let allowCharacters: Int = 6
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if updatedText.count >= allowCharacters {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            AnimateTextField(numberOfIterations: 0)
        }
        delegate?.PassHeader(header: updatedText)
        return updatedText.count <= allowCharacters
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.tag == 1 else {return}
        delegate?.PassDesc(desc: textView.text)
    }
}





extension AddOtherCell {
    
    func SetSubviews(){
        self.addSubview(scrollView)
        scrollView.addSubview(pickDateLabel)
        scrollView.addSubview(picker)
        scrollView.addSubview(writeName)
        scrollView.addSubview(commentField)
        scrollView.addSubview(warningLabel)
        scrollView.addSubview(writeDesc)
        scrollView.addSubview(descField)
        scrollView.addSubview(sendButton)
        
        picker.addTarget(self, action: #selector(AddOtherCell.handler(sender:)), for: UIControl.Event.valueChanged)
        sendButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Send)))
    }
    
    
    func ActivateLayouts(){
        let cellTop: CGFloat = {if MainConstants.screenHeight > 700 {return 110} else {return 85}}()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            pickDateLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: cellTop),
            pickDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            picker.topAnchor.constraint(equalTo: pickDateLabel.bottomAnchor, constant: 19),
            picker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            picker.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-40),
            
            writeName.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 43),
            writeName.leftAnchor.constraint(equalTo: pickDateLabel.leftAnchor),
            
            commentField.topAnchor.constraint(equalTo: writeName.bottomAnchor, constant: 14),
            commentField.leftAnchor.constraint(equalTo: writeName.leftAnchor),
            commentField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            commentField.heightAnchor.constraint(equalToConstant: 39),
            
            warningLabel.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 5),
            warningLabel.leftAnchor.constraint(equalTo: pickDateLabel.leftAnchor),
            
            writeDesc.topAnchor.constraint(equalTo: commentField.bottomAnchor, constant: 43),
            writeDesc.leftAnchor.constraint(equalTo: pickDateLabel.leftAnchor),
            
            descField.topAnchor.constraint(equalTo: writeDesc.bottomAnchor, constant: 14),
            descField.leftAnchor.constraint(equalTo: writeName.leftAnchor),
            descField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            descField.heightAnchor.constraint(equalToConstant: 170),
            
            sendButton.topAnchor.constraint(equalTo: descField.bottomAnchor, constant: 50),
            sendButton.leftAnchor.constraint(equalTo: descField.leftAnchor),
            sendButton.rightAnchor.constraint(equalTo: descField.rightAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}

