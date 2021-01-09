//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsView: UIView {
    
    let monday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let tuesday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let wednesday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let thursday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let friday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let saturday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let sunday: BarView = {
        let view = BarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    let zeroLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let zeroLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "0"
        label.font = UIFont(name: "SFPro", size: 14)
        return label
    }()
    
    var maxHeight = 215 as CGFloat

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = MainConstants.orange.cgColor
        self.layer.cornerRadius = 25
        
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension StatsView{
    
    func SetSubviews(){
        self.addSubview(monday)
        self.addSubview(tuesday)
        self.addSubview(wednesday)
        self.addSubview(thursday)
        self.addSubview(friday)
        self.addSubview(saturday)
        self.addSubview(sunday)
        
        self.addSubview(zeroLine)
        self.addSubview(zeroLabel)
    }
    
    func ActivateLayouts(){
        let oneTenth: CGFloat = self.frame.width/12
        NSLayoutConstraint.activate([
            monday.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            monday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            monday.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth * 1.2),
            monday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            tuesday.topAnchor.constraint(equalTo: monday.topAnchor),
            tuesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            tuesday.leftAnchor.constraint(equalTo: monday.rightAnchor, constant: oneTenth/2),
            tuesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            wednesday.topAnchor.constraint(equalTo: monday.topAnchor),
            wednesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            wednesday.leftAnchor.constraint(equalTo: tuesday.rightAnchor, constant: oneTenth/2),
            wednesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            thursday.topAnchor.constraint(equalTo: monday.topAnchor),
            thursday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            thursday.leftAnchor.constraint(equalTo: wednesday.rightAnchor, constant: oneTenth/2),
            thursday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            friday.topAnchor.constraint(equalTo: monday.topAnchor),
            friday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            friday.leftAnchor.constraint(equalTo: thursday.rightAnchor, constant: oneTenth/2),
            friday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            saturday.topAnchor.constraint(equalTo: monday.topAnchor),
            saturday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            saturday.leftAnchor.constraint(equalTo: friday.rightAnchor, constant: oneTenth/2),
            saturday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            sunday.topAnchor.constraint(equalTo: monday.topAnchor),
            sunday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            sunday.leftAnchor.constraint(equalTo: saturday.rightAnchor, constant: oneTenth/2),
            sunday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            zeroLine.bottomAnchor.constraint(equalTo: monday.bottomAnchor, constant: -10),
            zeroLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth/2),
            zeroLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            zeroLine.heightAnchor.constraint(equalToConstant: 1),
            
            zeroLabel.bottomAnchor.constraint(equalTo: zeroLine.topAnchor, constant: -2),
            zeroLabel.leftAnchor.constraint(equalTo: zeroLine.leftAnchor)
        ])
    }
}
