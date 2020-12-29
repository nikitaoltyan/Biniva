//
//  Main Constants.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit
 
struct MainConstants {
    static let aboutUs = "About us information \n \nWe are ready to introduce ourselves."
    static let aboutChangingButtons = "About changing buttons information \n \nWe are ready to help you."
    static let green = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
    static let white = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    static let orange = UIColor(red: 238/255, green: 124/255, blue: 30/255, alpha: 1)
    static let nearBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static let nearWhite = UIColor(red: 0, green: 0, blue: 0, alpha: 0.03)
    static let headerColor = UIColor(red: 237/255, green: 246/255, blue: 249/255, alpha: 1)
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
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
    var name: String!
}

struct MaterialsObjectItems {
    static var color: Array<UIColor> = [MaterialsColors.waterBlue, MaterialsColors.organicGreen, MaterialsColors.paperOrange, MaterialsColors.metalBeige]
    static var image: Array<UIImage> = [MaterialsIcons.waterBottle, MaterialsIcons.organicLimone, MaterialsIcons.paper, MaterialsIcons.metal]
    static let name: Array<String> = ["Пластик", "Органика", "Бумага", "Металл"]
}


// Access Token Github: 26fd87827e28333abd795628645a73b9ea2fd0f5