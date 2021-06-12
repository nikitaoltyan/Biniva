//
//  Material Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 13.02.2021.
//

import Foundation
import UIKit

class MaterialDefaults {
    
    /// - warning: Only for Stats table because of wrong spelling
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

}
