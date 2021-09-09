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

struct materialDesc {
    static let plastic = NSLocalizedString("plastic_info_desc", comment: "Desc for plastic for Info Controller.")
    static let organic = NSLocalizedString("organic_info_desc", comment: "Desc for organic for Info Controller.")
    static let paper = NSLocalizedString("paper_info_desc", comment: "Desc for paper for Info Controller.")
    static let metal = NSLocalizedString("metal_info_desc", comment: "Desc for metal for Info Controller.")
    static let glass = NSLocalizedString("glass_info_desc", comment: "Desc for glass for Info Controller")
    static let wood = NSLocalizedString("wood_info_desc", comment: "Desc for wood for Info Controller")
    static let fabric = NSLocalizedString("fabric_info_desc", comment: "Desc for fabric for Info Controller")
    static let battery = NSLocalizedString("battery_info_desc", comment: "Desc for battery for Info Controller")
    static let lamp = NSLocalizedString("lamp_info_desc", comment: "Desc for lamp for Info Controller")
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
    static let subtitleMetric: [String] = [
        NSLocalizedString("plastic_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_2_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_3_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_4_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_5_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_6", comment: "localized subtitle for quick add"),
    ]
    static let subtitleImperial: [String] = [
        NSLocalizedString("plastic_subtitle_1", comment: "localized subtitle for quick add"),
        NSLocalizedString("plactic_subtitle_2_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("plactic_subtitle_3_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("plactic_subtitle_4_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("plactic_subtitle_5_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("plastic_subtitle_6", comment: "localized subtitle for quick add"),
    ]
    static let weight: [Int] = [7, 25, 35, 40, 45, 50] // In gramms
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
    static let weight: [Int] = [20, 60, 60, 50] // in gramms
}



struct glass {
    static let title: [String] = [
        NSLocalizedString("glass_title_1", comment: "localized title for quick add"),
        NSLocalizedString("glass_title_2", comment: "localized title for quick add"),
        NSLocalizedString("glass_title_3", comment: "localized title for quick add"),
    ]
    static let subtitleMetric: [String] = [
        NSLocalizedString("glass_subtitle_1_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_2_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_3", comment: "localized subtitle for quick add")
    ]
    static let subtitleImperial: [String] = [
        NSLocalizedString("glass_subtitle_1_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_2_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("glass_subtitle_3", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [250, 350, 60] // in gramms
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
    static let weight: Array<Int> = [5,  25, 40, 50, 100, 5] // in gramms
}



struct metal {
    static let title: [String] = [
        NSLocalizedString("metal_title_1", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_2", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_3", comment: "localized title for quick add"),
        NSLocalizedString("metal_title_4", comment: "localized title for quick add"),
    ]
    static let subtitleMetric: [String] = [
        NSLocalizedString("metal_subtitle_1_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_3_metric", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_4", comment: "localized subtitle for quick add"),
    ]
    static let subtitleImperial: [String] = [
        NSLocalizedString("metal_subtitle_1_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_2", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_3_imperial", comment: "localized subtitle for quick add"),
        NSLocalizedString("metal_subtitle_4", comment: "localized subtitle for quick add"),
    ]
    static let weight: [Int] = [30, 3, 17, 50] // in gramms
}



struct wood {
    static let title: [String] = [
        NSLocalizedString("wood_title_1", comment: "localized title for quick add")
    ]
    static let subtitle: [String] = [
        NSLocalizedString("wood_subtitle_1", comment: "localized subtitle for quick add")
    ]
    static let weight: [Int] = [500]
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
    static let weight: [Int] = [200, 50]
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
    static let weight: [Int] = [25, 40, 50] // in gramms
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
    static let weight: [Int] = [105, 100] // in gramms
}
