//
//  LineView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 17.02.2021.
//

import UIKit

class LineView: UIView {

    let line: UIView = {
        let view = UIView()
            .with(bgColor: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
            .with(color: .lightGray)
            .with(fontName: "SFPro", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}







extension LineView {
    
    func SetSubviews(){
        self.addSubview(line)
        self.addSubview(numberLabel)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            line.leftAnchor.constraint(equalTo: self.leftAnchor),
            line.rightAnchor.constraint(equalTo: self.rightAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            numberLabel.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -2),
            numberLabel.leftAnchor.constraint(equalTo: line.leftAnchor)
        ])
    }
}
