//
//  StatsView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 05.11.2020.
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
    
    let zeroLine: LineView = {
        let view = LineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleLine: LineView = {
        let view = LineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var middleLineBottom: NSLayoutConstraint?
    
    var mondayHeight: NSLayoutConstraint?
    var tuesdayHeight: NSLayoutConstraint?
    var wednesdayHeight: NSLayoutConstraint?
    var thursdayHeight: NSLayoutConstraint?
    var fridayHeight: NSLayoutConstraint?
    var saturdayHeight: NSLayoutConstraint?
    var sundayHeight: NSLayoutConstraint?
    lazy var allBarsConstants: [NSLayoutConstraint?] = [mondayHeight,
                                                        tuesdayHeight,
                                                        wednesdayHeight,
                                                        thursdayHeight,
                                                        fridayHeight,
                                                        saturdayHeight,
                                                        sundayHeight]
    lazy var allBars: [BarView] = [monday,
                                   tuesday,
                                   wednesday,
                                   thursday,
                                   friday,
                                   saturday,
                                   sunday]

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
        ServerMaterials.GetHeights(forUserID: uid, maxHeight: 300, result: { (heights, logged, weekdays) in
            guard(self.allBarsConstants.count == heights.count) else { return }
            for i in 0...(heights.count-1) {
                self.allBarsConstants[i]?.constant += heights[i]
                self.allBars[i].label.text = weekdays[i]
                self.monday.layoutIfNeeded()
            }
            let avgLogged = logged.average()
            let avgHeight = heights.average()
            self.SetAvarageLine(averageLog: Int(avgLogged), averageHeight: Int(avgHeight))
        })
    }
    
    
    func SetAvarageLine(averageLog avgLog: Int, averageHeight avgHeig: Int) {
        self.middleLine.numberLabel.text = String(avgLog)
        self.middleLineBottom?.constant -= CGFloat(avgHeig)
        self.middleLine.layoutIfNeeded()
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
        self.addSubview(middleLine)
    }
    
    func ActivateLayouts(){
        let oneTenth: CGFloat = self.frame.width/12
        NSLayoutConstraint.activate([
            monday.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            monday.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth * 1.2),
            monday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            tuesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            tuesday.leftAnchor.constraint(equalTo: monday.rightAnchor, constant: oneTenth/2),
            tuesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            wednesday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            wednesday.leftAnchor.constraint(equalTo: tuesday.rightAnchor, constant: oneTenth/2),
            wednesday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            thursday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            thursday.leftAnchor.constraint(equalTo: wednesday.rightAnchor, constant: oneTenth/2),
            thursday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            friday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            friday.leftAnchor.constraint(equalTo: thursday.rightAnchor, constant: oneTenth/2),
            friday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            saturday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            saturday.leftAnchor.constraint(equalTo: friday.rightAnchor, constant: oneTenth/2),
            saturday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            sunday.bottomAnchor.constraint(equalTo: monday.bottomAnchor),
            sunday.leftAnchor.constraint(equalTo: saturday.rightAnchor, constant: oneTenth/2),
            sunday.widthAnchor.constraint(equalToConstant: oneTenth),
            
            zeroLine.bottomAnchor.constraint(equalTo: monday.bottomAnchor, constant: -10),
            zeroLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth/2),
            zeroLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            zeroLine.heightAnchor.constraint(equalToConstant: 30),
            
            middleLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: oneTenth/2),
            middleLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            middleLine.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        middleLineBottom = middleLine.bottomAnchor.constraint(equalTo: monday.bottomAnchor, constant: -10)
        middleLineBottom?.isActive = true
        
        mondayHeight = monday.heightAnchor.constraint(equalToConstant: monday.frame.height)
        tuesdayHeight = tuesday.heightAnchor.constraint(equalToConstant: tuesday.frame.height)
        wednesdayHeight = wednesday.heightAnchor.constraint(equalToConstant: wednesday.frame.height)
        thursdayHeight = thursday.heightAnchor.constraint(equalToConstant: thursday.frame.height)
        fridayHeight = friday.heightAnchor.constraint(equalToConstant: friday.frame.height)
        saturdayHeight = saturday.heightAnchor.constraint(equalToConstant: saturday.frame.height)
        sundayHeight = sunday.heightAnchor.constraint(equalToConstant: sunday.frame.height)
        for i in allBarsConstants{
            i?.isActive = true
        }
    }
}
