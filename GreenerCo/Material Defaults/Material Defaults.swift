//
//  Material Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 13.02.2021.
//

import Foundation
import UIKit

class MaterialDefaults {
    
    
    func getMaterialName(id: Int) -> String {
        switch id {
        case 0: return "пластика"
        case 1: return "органики"
        case 2: return "стекла"
        case 3: return "бумаги"
        case 4: return "металла"
        case 5: return "дерева"
        default: return "ткани"
        }
    }
    
    func getMaterialData(material: material) -> (Array<String>, Array<String>, Array<Int>) {
        switch material {
        case .plastic:
            return (plastic.title, plastic.subtitle, plastic.weight)
        case .organic:
            return (organic.title, organic.subtitle, organic.weight)
        case .glass:
            return (glass.title, glass.subtitle, glass.weight)
        case .paper:
            return (paper.title, paper.subtitle, paper.weight)
        case .metal:
            return (metal.title, metal.subtitle, metal.weight)
        case .wood:
            return (wood.title, wood.subtitle, wood.weight)
        default:
            return (fabric.title, fabric.subtitle, fabric.weight)
        }
    }
    
    static func LinearFunction(viewSize size: CGFloat, addedSize add: Int) -> CGFloat {
        switch size {
        case 400:
            return CGFloat(add) * 0.26
        default:
            return CGFloat(add) * 0.24
        }
    }
    
    
    static func GetTextColor(alreadyLogged logged: Int) -> UIColor {
        switch logged {
        case 0...180:
            return MainConstants.nearBlack
        default:
            return MainConstants.white
        }
    }
    
    
    static func YForDashedLine(dailyNorm norm: Int) -> CGFloat {
        switch MainConstants.screenHeight {
        case 700...:
            let lineBottom: CGFloat = LinearFunction(viewSize: 400, addedSize: norm)
            return 400 - lineBottom
        default:
            let lineBottom: CGFloat = LinearFunction(viewSize: 360, addedSize: norm)
            return 360 - lineBottom
        }
    }
    
    
    
    static func CreateFunction(maxX x: CGFloat, maxY y: CGFloat) -> (CGFloat) -> (CGFloat) {
        guard (x != 0) else {
            let resultFunction = ResultFunction(a: 0, b: 0)
            return resultFunction
        }
        let a = y/x
        let b = y-a*x
        let resultFunction = ResultFunction(a: a, b: b)
        return resultFunction
    }
    
    
    static func ResultFunction(a: CGFloat, b: CGFloat)  -> (CGFloat) -> (CGFloat) {
        return { x in (a*x + b)}
    }
}
