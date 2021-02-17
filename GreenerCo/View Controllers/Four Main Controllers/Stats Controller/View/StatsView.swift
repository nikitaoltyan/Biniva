//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsView: UIView {
    
    lazy var monday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var tuesday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var wednesday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var thursday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var friday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var saturday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.label.text = "Mn"
        return view
    }()
    
    lazy var sunday: BarView = {
        let view = BarView(frame: CGRect(x: 0, y: 0, width: oneTenth, height: 15))
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
    
//    lazy var allBars: [BarView] = [monday,
//                                   tuesday,
//                                   wednesday,
//                                   thursday,
//                                   friday,
//                                   saturday,
//                                   sunday]
    var mondayHeight: NSLayoutConstraint?
    var tuesdayHeight: NSLayoutConstraint?
    var wednesdayHeight: NSLayoutConstraint?
    var thursdayHeight: NSLayoutConstraint?
    var fridayHeight: NSLayoutConstraint?
    var saturdayHeight: NSLayoutConstraint?
    var sundayHeight: NSLayoutConstraint?
    lazy var allBars: [NSLayoutConstraint?] = [mondayHeight,
                                               tuesdayHeight,
                                               wednesdayHeight,
                                               thursdayHeight,
                                               fridayHeight,
                                               saturdayHeight,
                                               sundayHeight]

    lazy var maxHeight: CGFloat = self.frame.height
    lazy var oneTenth: CGFloat = self.frame.width/12
    var allHeight: Array<CGFloat> = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubviews()
        ActivateLayouts()
        GetAllHeights()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func GetAllHeights() {
        let uid: String? = UserDefaults.standard.string(forKey: "uid")
        ServerMaterials.GetHeights(forUserID: uid, maxHeight: 300, result: { result in
            guard(self.allBars.count == result.count) else { return }
            print("Heights: \(result)")
            for i in 0...(result.count-1) {
                self.allBars[i]?.constant += result[i]
                self.monday.layoutIfNeeded()
            }
        })
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
            monday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
//            monday.heightAnchor.constraint(equalToConstant: monday.frame.height),
            monday.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth * 1.2),
            monday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            tuesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            tuesday.heightAnchor.constraint(equalToConstant: tuesday.frame.height),
            tuesday.leftAnchor.constraint(equalTo: monday.rightAnchor, constant: oneTenth/2),
            tuesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            wednesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            wednesday.heightAnchor.constraint(equalToConstant: wednesday.frame.height),
            wednesday.leftAnchor.constraint(equalTo: tuesday.rightAnchor, constant: oneTenth/2),
            wednesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            thursday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            thursday.heightAnchor.constraint(equalToConstant: thursday.frame.height),
            thursday.leftAnchor.constraint(equalTo: wednesday.rightAnchor, constant: oneTenth/2),
            thursday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            friday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            friday.heightAnchor.constraint(equalToConstant: friday.frame.height),
            friday.leftAnchor.constraint(equalTo: thursday.rightAnchor, constant: oneTenth/2),
            friday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            saturday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            saturday.heightAnchor.constraint(equalToConstant: saturday.frame.height),
            saturday.leftAnchor.constraint(equalTo: friday.rightAnchor, constant: oneTenth/2),
            saturday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            sunday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
//            sunday.heightAnchor.constraint(equalToConstant: sunday.frame.height),
            sunday.leftAnchor.constraint(equalTo: saturday.rightAnchor, constant: oneTenth/2),
            sunday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            zeroLine.bottomAnchor.constraint(equalTo: monday.bottomAnchor, constant: -10),
            zeroLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth/2),
            zeroLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            zeroLine.heightAnchor.constraint(equalToConstant: 1),
            
            zeroLabel.bottomAnchor.constraint(equalTo: zeroLine.topAnchor, constant: -2),
            zeroLabel.leftAnchor.constraint(equalTo: zeroLine.leftAnchor)
        ])
        
        mondayHeight = monday.heightAnchor.constraint(equalToConstant: monday.frame.height)
        tuesdayHeight = tuesday.heightAnchor.constraint(equalToConstant: tuesday.frame.height)
        wednesdayHeight = wednesday.heightAnchor.constraint(equalToConstant: wednesday.frame.height)
        thursdayHeight = thursday.heightAnchor.constraint(equalToConstant: thursday.frame.height)
        fridayHeight = friday.heightAnchor.constraint(equalToConstant: friday.frame.height)
        saturdayHeight = saturday.heightAnchor.constraint(equalToConstant: saturday.frame.height)
        sundayHeight = sunday.heightAnchor.constraint(equalToConstant: sunday.frame.height)
        for i in allBars{
            i?.isActive = true
        }
    }
}
