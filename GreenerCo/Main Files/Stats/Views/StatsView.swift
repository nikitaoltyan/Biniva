//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsView: UIView {
    
    var sunday: UIView!
    var monday: UIView!
    var tuesday: UIView!
    var wednesday: UIView!
    var thursday: UIView!
    var friday: UIView!
    var saturday: UIView!
    
    var maxHeight = 215 as CGFloat
    let orange = MainConstants.orange

    override func awakeFromNib() {
        SelfLayer()
        AverageLabel()
        SundayView()
        MondayView()
        TuesdayView()
        WednesdayView()
        ThursdayView()
        FridayView()
        SaturdayView()
        ZeroLine()
    }
    
    func SelfLayer(){
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = orange.cgColor
        self.layer.cornerRadius = 25
    }
    
    func AverageLabel(){
        let label = UILabel()
        self.addSubview(label)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        label.text = "Среднее\n0.5 кг"
        label.textAlignment = .left
        label.font = UIFont.init(name: "Palatino", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func SundayView(){
        let view = UIView()
        self.addSubview(view)
        sunday = view
        sunday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            sunday.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            sunday.widthAnchor.constraint(equalToConstant: 28),
            sunday.heightAnchor.constraint(equalToConstant: maxHeight * 0.7)
        ])
        sunday.layer.cornerRadius = 2
        sunday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Вс"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: sunday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: sunday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func MondayView(){
        let view = UIView()
        self.addSubview(view)
        monday = view
        monday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            monday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            monday.leftAnchor.constraint(equalTo: sunday.rightAnchor, constant: 18),
            monday.widthAnchor.constraint(equalToConstant: 28),
            monday.heightAnchor.constraint(equalToConstant: maxHeight * 0.3)
        ])
        monday.layer.cornerRadius = 2
        monday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Пн"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: monday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: monday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func TuesdayView(){
        let view = UIView()
        self.addSubview(view)
        tuesday = view
        tuesday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tuesday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            tuesday.leftAnchor.constraint(equalTo: monday.rightAnchor, constant: 18),
            tuesday.widthAnchor.constraint(equalToConstant: 28),
            tuesday.heightAnchor.constraint(equalToConstant: maxHeight * 0.4)
        ])
        tuesday.layer.cornerRadius = 2
        tuesday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Вт"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tuesday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: tuesday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func WednesdayView(){
        let view = UIView()
        self.addSubview(view)
        wednesday = view
        wednesday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wednesday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            wednesday.leftAnchor.constraint(equalTo: tuesday.rightAnchor, constant: 18),
            wednesday.widthAnchor.constraint(equalToConstant: 28),
            wednesday.heightAnchor.constraint(equalToConstant: maxHeight * 1)
        ])
        wednesday.layer.cornerRadius = 2
        wednesday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Ср"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: wednesday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: wednesday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func ThursdayView(){
        let view = UIView()
        self.addSubview(view)
        thursday = view
        thursday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thursday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            thursday.leftAnchor.constraint(equalTo: wednesday.rightAnchor, constant: 18),
            thursday.widthAnchor.constraint(equalToConstant: 28),
            thursday.heightAnchor.constraint(equalToConstant: maxHeight * 0.1)
        ])
        thursday.layer.cornerRadius = 2
        thursday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Чт"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: thursday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: thursday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func FridayView(){
        let view = UIView()
        self.addSubview(view)
        friday = view
        friday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            friday.leftAnchor.constraint(equalTo: thursday.rightAnchor, constant: 18),
            friday.widthAnchor.constraint(equalToConstant: 28),
            friday.heightAnchor.constraint(equalToConstant: maxHeight * 0.8)
        ])
        friday.layer.cornerRadius = 2
        friday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.text = "Пт"
        label.textAlignment = .center
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: friday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: friday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func SaturdayView(){
        let view = UIView()
        self.addSubview(view)
        saturday = view
        saturday.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saturday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            saturday.leftAnchor.constraint(equalTo: friday.rightAnchor, constant: 18),
            saturday.widthAnchor.constraint(equalToConstant: 28),
            saturday.heightAnchor.constraint(equalToConstant: maxHeight * 0.9)
        ])
        saturday.layer.cornerRadius = 2
        saturday.backgroundColor = orange
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Сб"
        label.font = UIFont.init(name: "Palatino", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: saturday.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: saturday.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func ZeroLine(){
        let view = UIView()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 13),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        view.backgroundColor = .lightGray
        
        let label = UILabel()
        self.addSubview(label)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "0"
        label.font = UIFont.init(name: "Palatino", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -2),
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.heightAnchor.constraint(equalToConstant: 15),
            label.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
}
