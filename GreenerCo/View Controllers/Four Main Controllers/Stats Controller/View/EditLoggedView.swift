//
//  EditLoggedView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.03.2021.
//

import UIKit

class EditLoggedView: UIView {
    
    let currentValueLabel: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 22)
            .with(numberOfLines: 1)
        label.text = "200 гр Пластик"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 5
        slider.maximumValue = 1000
        slider.value = 200
        slider.tintColor = MainConstants.nearBlack
        return slider
    }()
    
    let plusView: CompletePlusView = {
        let scale: CGFloat = 28
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(bgColor: MainConstants.green)
            .with(cornerRadius: scale/2)
        view.horizontalView.backgroundColor = MainConstants.white
        view.verticalView.backgroundColor = MainConstants.white
        return view
    }()
    
    let minusView: CompletePlusView = {
        let scale: CGFloat = 28
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(bgColor: MainConstants.green)
            .with(cornerRadius: scale/2)
        view.horizontalView.backgroundColor = MainConstants.white
        view.verticalView.isHidden = true
        return view
    }()
    
    let picker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.calendar = .current
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.pink
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}





extension EditLoggedView {
    
    func SetSubviews(){
        self.addSubview(currentValueLabel)
        self.addSubview(slider)
        self.addSubview(plusView)
        self.addSubview(minusView)
        self.addSubview(picker)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            minusView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            minusView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            minusView.heightAnchor.constraint(equalToConstant: minusView.frame.height),
            minusView.widthAnchor.constraint(equalToConstant: minusView.frame.width),
            
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            plusView.centerYAnchor.constraint(equalTo: minusView.centerYAnchor),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            
            slider.centerYAnchor.constraint(equalTo: plusView.centerYAnchor),
            slider.leftAnchor.constraint(equalTo: minusView.rightAnchor, constant: 5),
            slider.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: -5),
            slider.heightAnchor.constraint(equalToConstant: 40),
            
            currentValueLabel.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            currentValueLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -3),
            
            picker.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 15),
            picker.centerXAnchor.constraint(equalTo: slider.centerXAnchor)
        ])
    }
}
