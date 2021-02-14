//
//  CustomPickerOpenView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 03.01.2021.
//
import UIKit


class CustomPickerOpenView: UIView {

    let firstLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        view.layer.cornerRadius = 1
        return view
    }()
    
    let secondLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        view.layer.cornerRadius = 1
        return view
    }()
    
    let thirdLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        view.layer.cornerRadius = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 3
        self.layer.borderColor = MainConstants.green.cgColor
        self.backgroundColor = UIColor.clear
        
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension CustomPickerOpenView{
    
    func SetSubviews(){
        self.addSubview(firstLine)
        self.addSubview(secondLine)
        self.addSubview(thirdLine)
    }
    
    func ActivateLayouts(){
        let slideConstant: CGFloat = 9
        NSLayoutConstraint.activate([
            firstLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            firstLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: slideConstant),
            firstLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -slideConstant),
            firstLine.heightAnchor.constraint(equalToConstant: 3),
            
            secondLine.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 3),
            secondLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: slideConstant),
            secondLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -slideConstant),
            secondLine.heightAnchor.constraint(equalToConstant: 3),
            
            thirdLine.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 3),
            thirdLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: slideConstant),
            thirdLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -slideConstant),
            thirdLine.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}
