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
}


struct materials {
    static let name: Array<String> = ["Пластик", "Органика", "Бумага", "Металл", "Стекло", "Дерево", "Ткань", "Батарейки"]
    static var image: Array<UIImage> = [materialImages.plastic,
                                        materialImages.organic,
                                        materialImages.paper,
                                        materialImages.metal,
                                        materialImages.glass,
                                        materialImages.wood,
                                        materialImages.fabric,
                                        materialImages.battery]
    static let enums: Array<material> = [.plastic, .organic, .paper, .metal, .glass, .wood, .fabric, .battery]
    static let statsColors: Array<UIColor> = [materialColors.plastic,
                                              materialColors.organic,
                                              materialColors.paper,
                                              materialColors.metal,
                                              materialColors.glass,
                                              materialColors.wood,
                                              materialColors.fabric,
                                              materialColors.battery]
    static let id: Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7]
}



struct plastic {
    static let title: Array<String> = ["Пакет", "Бутылка", "Бутылка", "Бутылка", "Бутылка", "Другое"]
    static let subtitle: Array<String> = ["Майка", "Объем 0.5 литра", "Объем 1 литр", "Объем 1.5 литра", "Объем 2 литра", "Обертка и т.д."]
    static let weight: Array<Int> = [7, 25, 35, 40, 45, 50]
}

struct organic {
    static let title: Array<String> = ["Огрызок", "Кожура", "Отчистки", "Другое"]
    static let subtitle: Array<String> = ["Яблоко или груша", "Банановая", "Картофель", "Органика"]
    static let weight: Array<Int> = [20, 60, 60, 50]
}

struct glass {
    static let title: Array<String> = ["Стакан", "Бутылка", "Другое"]
    static let subtitle: Array<String> = ["Объем 0,2 литра", "Объем 0.5 литра", "Стекло"]
    static let weight: Array<Int> = [250, 350, 50]
}

struct paper {
    static let title: Array<String> = ["Лист", "Обертка", "Обертка", "Коробка", "Коробка", "Другое"]
    static let subtitle: Array<String> = ["А4", "Небольшая", "Большая", "Картонная маленькая", "Картонная большая", "Салфетка и т.д."]
    static let weight: Array<Int> = [5, 20, 40, 50, 100, 5]
}

struct metal {
    static let title: Array<String> = ["Фольга", "Фантик", "Другое"]
    static let subtitle: Array<String> = ["Длина 0,5 метра", "От конфеты", "Гвозди и т.д."]
    static let weight: Array<Int> = [30, 3, 50]
}

struct wood {
    static let title: Array<String> = ["Другое"]
    static let subtitle: Array<String> = ["Стулья и т.д."]
    static let weight: Array<Int> = [500]
}

struct fabric {
    static let title: Array<String> = ["Футболка", "Другое"]
    static let subtitle: Array<String> = ["Взрослая", "Ткань"]
    static let weight: Array<Int> = [200, 50]
}

struct battery {
    static let title: Array<String> = ["Батарейка", "Батарейка"]
    static let subtitle: Array<String> = ["Мизинчиковая", "Пальчиковая"]
    static let weight: Array<Int> = [25, 40]
}
