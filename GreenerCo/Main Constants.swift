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


struct Materials {
    static let paper = [""]
    static let plastic = [""]
    static let metal = [""]
    static let organic = [""]
}


struct MaterialsColors {
    static let waterBlue = UIColor(red: 168/255, green: 217/255, blue: 219/255, alpha: 1)
    static let organicBeige = UIColor(red: 242/255, green: 196/255, blue: 124/255, alpha: 1)
    static let organicGreen = UIColor(red: 41/255, green: 155/255, blue: 141/255, alpha: 1)
    static let metalBeige = UIColor(red: 255/255, green: 237/255, blue: 220/255, alpha: 1)
    static let paperOrange = UIColor(red: 210/255, green: 127/255, blue: 101/255, alpha: 1)
}


struct MaterialsIcons {
    static let waterBottle = #imageLiteral(resourceName: "Water")
    static let paper = #imageLiteral(resourceName: "Paper")
    static let organicLimone = #imageLiteral(resourceName: "Organic-1")
    static let organicTomato = #imageLiteral(resourceName: "Organic-2")
    static let metal = #imageLiteral(resourceName: "Metal")
}


class MaterialsObject: NSObject{
    var color: UIColor!
    var image: UIImage!
    var name: Int!
}


enum material {
    case plastic
    case organic
    case paper
    case matal
    case wood
    case fabric
}

struct materials {
    static var name: Array<String> = ["Пластик", "Органика", "Бумага", "Металл", "Дерево", "Ткань"]
//    static var image: Array<UIImage> = [MaterialsIcons.waterBottle, MaterialsIcons.organicLimone, MaterialsIcons.paper, MaterialsIcons.metal]
    static let id: Array<Int> = [0, 1, 2, 3, 4, 5]
}

/// Пластик - 0
/// Органика - 1
/// Бумага - 2
/// Металл - 3
/// Дерево - 4
/// Ткань - 5

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
