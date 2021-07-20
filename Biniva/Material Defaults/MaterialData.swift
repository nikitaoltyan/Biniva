//
//  MaterialData.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 26.04.2021.
//

import Foundation
import UIKit


/// Пластик - 0
/// Органика - 1
/// Бумага - 2
/// Металл - 3
/// Стекло - 4
/// Дерево - 5
/// Ткань - 6
/// Батарейки - 7

// Make them one.
enum TrashType: Int, Decodable {
    case plastic
    case organic
    case paper
    case metal
    case glass
    case wood
    case fabric
    case battery
    case lamp
}

enum material {
    case plastic
    case organic
    case paper
    case metal
    case glass
    case wood
    case fabric
    case battery
    case lamp
}

struct materialImages {
    static let plastic = UIImage(named: "plastic") ?? #imageLiteral(resourceName: "glass")
    static let organic = UIImage(named: "organic") ?? #imageLiteral(resourceName: "glass")
    static let paper = UIImage(named: "paper") ?? #imageLiteral(resourceName: "glass")
    static let metal = UIImage(named: "metal") ?? #imageLiteral(resourceName: "glass")
    static let glass = UIImage(named: "glass") ?? #imageLiteral(resourceName: "glass")
    static let wood = UIImage(named: "wood") ?? #imageLiteral(resourceName: "glass")
    static let fabric = UIImage(named: "fabric") ?? #imageLiteral(resourceName: "glass")
    static let battery = UIImage(named: "battery") ?? #imageLiteral(resourceName: "glass")
    static let lamp = UIImage(named: "lamp") ?? #imageLiteral(resourceName: "glass")
}

struct materialIcons {
    static let plastic = UIImage(named: "plastic-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let organic = UIImage(named: "organic-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let paper = UIImage(named: "paper-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let metal = UIImage(named: "metal-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let glass = UIImage(named: "glass-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let wood = UIImage(named: "wood-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let fabric = UIImage(named: "fabric-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let battery = UIImage(named: "battery-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
    static let lamp = UIImage(named: "lamp-icon") ?? #imageLiteral(resourceName: "StatsEmtyState")
}

struct materialColors {
    static let plastic = UIColor(named: "placticColor") ?? .orange
    static let organic = UIColor(named: "organicColor") ?? .green
    static let paper = UIColor(named: "paperColor") ?? .green
    static let metal = UIColor(named: "metalColor") ?? .green
    static let glass = UIColor(named: "glassColor") ?? .green
    static let wood = UIColor(named: "woodColor") ?? .green
    static let fabric = UIColor(named: "fabricColor") ?? .green
    static let battery = UIColor(named: "batteryColor") ?? .green
    static let lamp = UIColor(named: "lampColor") ?? .systemPink
}


struct materials {
    static let name: Array<String> = [
        NSLocalizedString("plastic", comment: "msterial name for Add Material View"),
        NSLocalizedString("organic", comment: "msterial name for Add Material View"),
        NSLocalizedString("paper", comment: "msterial name for Add Material View"),
        NSLocalizedString("metal", comment: "msterial name for Add Material View"),
        NSLocalizedString("glass", comment: "msterial name for Add Material View"),
        NSLocalizedString("wood", comment: "msterial name for Add Material View"),
        NSLocalizedString("fabric", comment: "msterial name for Add Material View"),
        NSLocalizedString("battery", comment: "msterial name for Add Material View"),
        NSLocalizedString("lamp", comment: "msterial name for Add Material View")
    ]
    static var image: Array<UIImage> = [materialImages.plastic,
                                        materialImages.organic,
                                        materialImages.paper,
                                        materialImages.metal,
                                        materialImages.glass,
                                        materialImages.wood,
                                        materialImages.fabric,
                                        materialImages.battery,
                                        materialImages.lamp]
    static let enums: Array<material> = [.plastic, .organic, .paper, .metal, .glass, .wood, .fabric, .battery, .lamp]
    static let statsColors: Array<UIColor> = [materialColors.plastic,
                                              materialColors.organic,
                                              materialColors.paper,
                                              materialColors.metal,
                                              materialColors.glass,
                                              materialColors.wood,
                                              materialColors.fabric,
                                              materialColors.battery,
                                              materialColors.lamp]
    static let id: Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8]
}



struct plastic {
    static let title: [String] = [
        NSLocalizedString("plastic_title_1", comment: "localized title for quick add"),
        NSLocalizedString("plastic_title_2", comment: "localized title for quick add"),
        NSLocalizedString("plastic_title_3", comment: "localized title for quick add"),
        NSLocalizedString("plastic_title_4", comment: "localized title for quick add"),
        NSLocalizedString("plastic_title_5", comment: "localized title for quick add"),
        NSLocalizedString("plastic_title_6", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("plastic_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_3", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_4", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_5", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_6", comment: "localized subtitle for quick add"),
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("plastic_weight_1", comment: "weight")) ?? 7,
        Int(NSLocalizedString("plastic_weight_2", comment: "weight")) ?? 25,
        Int(NSLocalizedString("plastic_weight_3", comment: "weight")) ?? 35,
        Int(NSLocalizedString("plastic_weight_4", comment: "weight")) ?? 40,
        Int(NSLocalizedString("plastic_weight_5", comment: "weight")) ?? 45,
        Int(NSLocalizedString("plastic_weight_6", comment: "weight")) ?? 50,
    ] // ?? in gramms
}



struct organic {
    static let title: [String] = [
        NSLocalizedString("organic_title_1", comment: "localized title for quick add"),
        NSLocalizedString("organic_title_2", comment: "localized title for quick add"),
        NSLocalizedString("organic_title_3", comment: "localized title for quick add"),
        NSLocalizedString("organic_title_4", comment: "localized title for quick add"),
    ]
    static let subtitle: [String] = [
        NSLocalizedString("organic_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("organic_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("organic_subtitle_3", comment: "localized subtitle for quick add"),
        NSLocalizedString("organic_subtitle_4", comment: "localized subtitle for quick add"),
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("organic_weight_1", comment: "weight")) ?? 20,
        Int(NSLocalizedString("organic_weight_2", comment: "weight")) ?? 60,
        Int(NSLocalizedString("organic_weight_3", comment: "weight")) ?? 60,
        Int(NSLocalizedString("organic_weight_4", comment: "weight")) ?? 50,
    ] // ?? in gramms
}



struct glass {
    static let title: [String] = [
        NSLocalizedString("glass_title_1", comment: "localized title for quick add"),
        NSLocalizedString("glass_title_2", comment: "localized title for quick add"),
        NSLocalizedString("glass_title_3", comment: "localized title for quick add"),
    ]
    static let subtitle: [String] = [
        NSLocalizedString("glass_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_3", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("glass_weight_1", comment: "weight")) ?? 250,
        Int(NSLocalizedString("glass_weight_2", comment: "weight")) ?? 350,
        Int(NSLocalizedString("glass_weight_3", comment: "weight")) ?? 60
    ] // ?? in gramms
}



struct paper {
    static let title: [String] = [
        NSLocalizedString("paper_title_1", comment: "localized title for quick add"),
        NSLocalizedString("paper_title_2", comment: "localized title for quick add"),
        NSLocalizedString("paper_title_3", comment: "localized title for quick add"),
        NSLocalizedString("paper_title_4", comment: "localized title for quick add"),
        NSLocalizedString("paper_title_5", comment: "localized title for quick add"),
        NSLocalizedString("paper_title_6", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("paper_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("paper_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("paper_subtitle_3", comment: "localized subtitle for quick add"),
        NSLocalizedString("paper_subtitle_4", comment: "localized subtitle for quick add"),
        NSLocalizedString("paper_subtitle_5", comment: "localized subtitle for quick add"),
        NSLocalizedString("paper_subtitle_6", comment: "localized subtitle for quick add"),
    ]
    static let weight: Array<Int> = [
        Int(NSLocalizedString("paper_weight_1", comment: "weight")) ?? 5,
        Int(NSLocalizedString("paper_weight_2", comment: "weight")) ?? 25,
        Int(NSLocalizedString("paper_weight_3", comment: "weight")) ?? 40,
        Int(NSLocalizedString("paper_weight_4", comment: "weight")) ?? 50,
        Int(NSLocalizedString("paper_weight_5", comment: "weight")) ?? 100,
        Int(NSLocalizedString("paper_weight_6", comment: "weight")) ?? 5,
    ] // ?? in gramms
}



struct metal {
    static let title: [String] = [
        NSLocalizedString("metal_title_1", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_2", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_3", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_4", comment: "localized title for quick add"),
    ]
    static let subtitle: [String] = [
        NSLocalizedString("metal_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_3", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_4", comment: "localized subtitle for quick add"),
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("metal_weight_1", comment: "weight")) ?? 30,
        Int(NSLocalizedString("metal_weight_2", comment: "weight")) ?? 3,
        Int(NSLocalizedString("metal_weight_3", comment: "weight")) ?? 17,
        Int(NSLocalizedString("metal_weight_4", comment: "weight")) ?? 50,
    ] // ?? in gramms
}



struct wood {
    static let title: [String] = [
        NSLocalizedString("wood_title_1", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("wood_subtitle_1", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("wood_weight_1", comment: "weight")) ?? 30
    ]
}



struct fabric {
    static let title: [String] = [
        NSLocalizedString("fabric_title_1", comment: "localized title for quick add"),
        NSLocalizedString("fabric_title_2", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("fabric_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("fabric_subtitle_2", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("fabric_weight_1", comment: "weight")) ?? 200,
        Int(NSLocalizedString("fabric_weight_2", comment: "weight")) ?? 50
    ]
}



struct battery {
    static let title: [String] = [
        NSLocalizedString("battery_title_1", comment: "localized title for quick add"),
        NSLocalizedString("battery_title_2", comment: "localized title for quick add"),
        NSLocalizedString("battery_title_3", comment: "localized title for quick add"),
    ]
    static let subtitle: [String] = [
        NSLocalizedString("battery_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("battery_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("battery_subtitle_3", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("battery_weight_1", comment: "weight")) ?? 25,
        Int(NSLocalizedString("battery_weight_2", comment: "weight")) ?? 40,
        Int(NSLocalizedString("battery_weight_3", comment: "weight")) ?? 50
    ] // ?? in gramms
}


struct lamp {
    static let title: [String] = [
        NSLocalizedString("lamp_title_1", comment: "localized title for quick add"),
        NSLocalizedString("lamp_title_2", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("lamp_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("lamp_subtitle_2", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [
        Int(NSLocalizedString("lamp_weight_1", comment: "weight")) ?? 105,
        Int(NSLocalizedString("lamp_weight_2", comment: "weight")) ?? 100
    ] // ?? in gramms
}
