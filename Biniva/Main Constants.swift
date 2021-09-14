//
//  Main Constants.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit
 
struct MainConstants {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}


struct Colors {
    static let nearBlack = UIColor(named: "nearBlack") ?? UIColor.black
    static let background = UIColor(named: "background") ?? UIColor.white
    static let grayCircle = UIColor(named: "grayCircle") ?? UIColor.lightGray
    static let sliderGray = UIColor(named: "sliderGray") ?? UIColor.lightGray
    static let darkGrayText = UIColor(named: "darkGrayText") ?? UIColor.darkGray
    static let topGradient = UIColor(named: "topGradient") ?? UIColor.green
    static let bottomGradient = UIColor(named: "bottomGradient") ?? UIColor.green
    static let arrowUpRed = UIColor(named: "arrowUpColor") ?? UIColor.red
    static let arrowDownGreen = UIColor(named: "arrowDownColor") ?? UIColor.green
    static let askForPointInWork = UIColor(named: "askForPointInWork") ?? UIColor.orange
}


class Vibration {
    
    static func soft() -> Void{
        let soft = UIImpactFeedbackGenerator(style: .soft)
        soft.impactOccurred()
    }
    
    static func light() -> Void{
        let light = UIImpactFeedbackGenerator(style: .light)
        light.impactOccurred()
    }
    
    static func medium() -> Void{
        let medium = UIImpactFeedbackGenerator(style: .medium)
        medium.impactOccurred()
    }
    
    
    static func Heavy() -> Void{
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        heavy.impactOccurred()
    }
}
