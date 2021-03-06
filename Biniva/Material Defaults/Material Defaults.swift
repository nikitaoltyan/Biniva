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
        case 0: return NSLocalizedString("plastic_for_stats", comment: "Title for stats table")
        case 1: return NSLocalizedString("organic_for_stats", comment: "Title for stats table")
        case 2: return NSLocalizedString("paper_for_stats", comment: "Title for stats table")
        case 3: return NSLocalizedString("metal_for_stats", comment: "Title for stats table")
        case 4: return NSLocalizedString("glass_for_stats", comment: "Title for stats table")
        case 5: return NSLocalizedString("wood_for_stats", comment: "Title for stats table")
        case 6: return NSLocalizedString("fabric_for_stats", comment: "Title for stats table")
        case 7: return NSLocalizedString("battery_for_stats", comment: "Title for stats table")
        default: return NSLocalizedString("lamp_for_stats", comment: "Title for stats table")
        }
    }
    
    func getMaterialData(material: material) -> (Array<String>, Array<String>, Array<Int>) {
        switch material {
        case .plastic:
            switch Defaults.getWeightSystem() {
            case 0: // Metric
                return (plastic.title, plastic.subtitleMetric, plastic.weight)
            default: // Imperial
                return (plastic.title, plastic.subtitleImperial, plastic.weight)
            }
            
        case .organic:
            return (organic.title, organic.subtitle, organic.weight)
            
        case .paper:
            return (paper.title, paper.subtitle, paper.weight)
            
        case .metal:
            switch Defaults.getWeightSystem() {
            case 0: // Metric
                return (metal.title, metal.subtitleMetric, metal.weight)
            default: // Imperial
                return (metal.title, metal.subtitleImperial, metal.weight)
            }
            
        case .glass:
            switch Defaults.getWeightSystem() {
            case 0: // Metric
                return (glass.title, glass.subtitleMetric, glass.weight)
            default: // Imperial
                return (glass.title, glass.subtitleImperial, glass.weight)
            }
            
        case .wood:
            return (wood.title, wood.subtitle, wood.weight)
            
        case .fabric:
            return (fabric.title, fabric.subtitle, fabric.weight)
            
        case .battery:
            return (battery.title, battery.subtitle, battery.weight)
            
        default:
            return (lamp.title, lamp.subtitle, lamp.weight)
        }
    }

}
