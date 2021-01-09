//
//  BarView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 06.01.2021.
//

import UIKit

class BarView: UIView {
    
    let barView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        view.backgroundColor = MainConstants.orange
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.textAlignment = .center
        label.font = UIFont(name: "SFPro", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
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





extension BarView{
    
    func SetSubviews(){
        self.addSubview(barView)
        self.addSubview(label)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            barView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            barView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            barView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            barView.widthAnchor.constraint(equalToConstant: 25),
            
            label.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: barView.centerXAnchor)
        ])
    }
}
