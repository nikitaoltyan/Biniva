//
//  WeightViewImperial.swift
//  Biniva
//
//  Created by Никита Олтян on 09.08.2021.
//

import UIKit


class WeightViewImperial: UIView {
    
    lazy var textView: UITextView = {
        let view = UITextView(frame: CGRect(x: 0, y: 0, width: self.frame.width/2.2, height: self.frame.height-4))
            .with(bgColor: .clear)
            .with(fontName: "SFPro-Medium", size: 20)
            .with(autolayout: false)
        view.textColor = Colors.background
        view.keyboardType = .decimalPad
        view.textAlignment = .center
        view.delegate = self
        view.text = "10.0 \(weightSymbol)"
        return view
    }()
    
    lazy var minusView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height-4))
            .with(bgColor: Colors.background)
            .with(cornerRadius: (self.frame.height-4)/2)
            .with(autolayout: false)
        return view
    }()
    
    lazy var plusView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height-4))
            .with(bgColor: Colors.background)
            .with(cornerRadius: (self.frame.height-4)/2)
            .with(autolayout: false)
        return view
    }()
    
    let minusLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro", size: 21)
            .with(autolayout: false)
        label.text = "-"
        return label
    }()
    
    let plusLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro", size: 21)
            .with(autolayout: false)
        label.text = "+"
        return label
    }()

    let weightSymbol: String = NSLocalizedString("weight_measurement_ounces", comment: "localized ounces (oz) symbol")
    var currentNumber: Double = 10.0
    
    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: 215, height: 50)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.topGradient
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func addAction(){
        Vibration.soft()
        
        let currentTextArray = textView.text.split(separator: " ")
        if currentTextArray.count > 0 {
            let number = Double(currentTextArray[0]) ?? 0.0
            guard (number < 9999) else { return }
            currentNumber += 0.1
            currentNumber = currentNumber.rounded(toPlaces: 1)
            textView.text = "\(currentNumber) \(weightSymbol)"
        } else {
            textView.text = "10.0 \(weightSymbol)"
        }
    }
    
    @objc
    func reduceAction(){
        Vibration.soft()
        
        let currentTextArray = textView.text.split(separator: " ")
        if currentTextArray.count > 0 {
            let number = Double(currentTextArray[0]) ?? 0.0
            guard (number >= 0.1) else { return }
            currentNumber -= 0.1
            currentNumber = currentNumber.rounded(toPlaces: 1)
            textView.text = "\(currentNumber) \(weightSymbol)"
        } else {
            textView.text = "0 \(weightSymbol)"
        }
    }
}




extension WeightViewImperial: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("replacementText: \(text)")
        if text == "," {
            textView.text += "."
            return false
        }
        if textView.text.count >= 4 {
            self.textView.endEditing(true)
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard (textView.text.count > 0) else {
            self.currentNumber = 0
            self.textView.text = "\(currentNumber) \(weightSymbol)"
            return
        }
        guard (textView.text.contains(weightSymbol) == false) else {
            let currentTextArray = self.textView.text.split(separator: " ")
            let weight = Double(currentTextArray[0]) ?? 0.0
            self.textView.text = "\(weight) \(weightSymbol)"
            return
        }
        
        let currentTextArray = self.textView.text.split(separator: " ")
        let weight = Double(currentTextArray[0]) ?? 0.0
        self.currentNumber = weight
        self.textView.text = "\(weight) \(weightSymbol)"
    }
}





extension WeightViewImperial {
    private
    func setSubviews(){
        self.addSubview(textView)
        self.addSubview(minusView)
        self.addSubview(plusView)
        
        minusView.addSubview(minusLabel)
        plusView.addSubview(plusLabel)
        
        minusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reduceAction)))
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
    }
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: textView.frame.height),
            textView.widthAnchor.constraint(equalToConstant: textView.frame.width),
            
            minusView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2),
            minusView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minusView.heightAnchor.constraint(equalToConstant: minusView.frame.height),
            minusView.widthAnchor.constraint(equalToConstant: minusView.frame.width),
            
            minusLabel.centerXAnchor.constraint(equalTo: minusView.centerXAnchor),
            minusLabel.centerYAnchor.constraint(equalTo: minusView.centerYAnchor, constant: -1),
            
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2),
            plusView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),

            plusLabel.centerXAnchor.constraint(equalTo: plusView.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: plusView.centerYAnchor, constant: -1)
        ])
    }
}
