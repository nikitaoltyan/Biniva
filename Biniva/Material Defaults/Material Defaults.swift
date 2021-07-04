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
        case 2: return "бумаги"
        case 3: return "металла"
        case 4: return "стекла"
        case 5: return "дерева"
        case 6: return "ткани"
        default: return "батареек"
        }
    }
    
    func getMaterialData(material: material) -> (Array<String>, Array<String>, Array<Int>) {
        switch material {
        case .plastic:
            return (plastic.title, plastic.subtitle, plastic.weight)
        case .organic:
            return (organic.title, organic.subtitle, organic.weight)
        case .paper:
            return (paper.title, paper.subtitle, paper.weight)
        case .metal:
            return (metal.title, metal.subtitle, metal.weight)
        case .glass:
            return (glass.title, glass.subtitle, glass.weight)
        case .wood:
            return (wood.title, wood.subtitle, wood.weight)
        case .fabric:
            return (fabric.title, fabric.subtitle, fabric.weight)
        default:
            return (battery.title, battery.subtitle, battery.weight)
        }
    }

}
