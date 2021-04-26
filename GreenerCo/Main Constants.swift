//
//  Main Constants.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit
 
struct MainConstants {
    static let green = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
    static let white = UIColor(named: "customWhiteColor")
        ?? UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    static let orange = UIColor(red: 238/255, green: 124/255, blue: 30/255, alpha: 1)
    static let yellow = UIColor(red: 237/255, green: 193/255, blue: 53/255, alpha: 1)
    static let pink = UIColor(red: 242/255, green: 132/255, blue: 130/255, alpha: 1)
    static let nearBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static let nearWhite = UIColor(named: "customNearWhiteColor")
        ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
    static let headerColor = UIColor(named: "customHeaderColor")
        ?? UIColor(red: 245/255, green: 248/255, blue: 253/255, alpha: 1)
    static let cellColor = UIColor(named: "customCellColor")
        ?? UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}


struct Colors {
    static let nearBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8) // Redevelop into Color Set
    static let background = UIColor(named: "background") ?? UIColor.white
    static let grayCircle = UIColor(named: "grayCircle") ?? UIColor.lightGray
    static let sliderGray = UIColor(named: "sliderGray") ?? UIColor.lightGray
    static let darkGrayText = UIColor(named: "darkGrayText") ?? UIColor.darkGray
    static let topGradient = UIColor(named: "topGradient") ?? UIColor.green
    static let bottomGradient = UIColor(named: "bottomGradient") ?? UIColor.green
}


class Vibration {
    
    static func Soft() -> Void{
        let soft = UIImpactFeedbackGenerator(style: .soft)
        soft.impactOccurred()
    }
    
    static func Light() -> Void{
        let light = UIImpactFeedbackGenerator(style: .light)
        light.impactOccurred()
    }
    
    static func Medium() -> Void{
        let medium = UIImpactFeedbackGenerator(style: .medium)
        medium.impactOccurred()
    }
    
    
    static func Heavy() -> Void{
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        heavy.impactOccurred()
    }
}

// Access Token Github: 35de02dcdd611aa154bf75fe929cf047a770a9d3
