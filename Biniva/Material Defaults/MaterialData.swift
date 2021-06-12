//
//  MaterialData.swift
//  GreenerCo
//
//  Created by Никита Олтян on 26.04.2021.
//

import Foundation
import UIKit


/// Пластик - 0
/// Органика - 1
/// Стекло - 2
/// Бумага - 3
/// Металл - 4
/// Дерево - 5
/// Ткань - 6

// Make them one.
enum TrashType: Int, Decodable {
    case plastic
    case organic
    case glass
    case paper
    case metal
    case wood
    case fabric
}

enum material {
    case plastic
    case organic
    case glass
    case paper
    case metal
    case wood
    case fabric
}

struct materialImages {
    static let plastic = UIImage(named: "plastic") ?? #imageLiteral(resourceName: "Avatar")
    static let organic = UIImage(named: "organic") ?? #imageLiteral(resourceName: "Avatar")
    static let glass = UIImage(named: "glass") ?? #imageLiteral(resourceName: "Avatar")
    static let paper = UIImage(named: "paper") ?? #imageLiteral(resourceName: "Avatar")
    static let metal = UIImage(named: "metal") ?? #imageLiteral(resourceName: "Avatar")
    static let wood = UIImage(named: "wood") ?? #imageLiteral(resourceName: "Avatar")
    static let fabric = UIImage(named: "fabric") ?? #imageLiteral(resourceName: "Avatar")
}

struct materialColors {
    static let plastic = UIColor(named: "placticColor") ?? .orange
    static let organic = UIColor(named: "organicColor") ?? .green
    static let glass = UIColor(named: "glassColor") ?? .green
    static let paper = UIColor(named: "paperColor") ?? .green
    static let metal = UIColor(named: "metalColor") ?? .green
    static let wood = UIColor(named: "woodColor") ?? .green
    static let fabric = UIColor(named: "fabricColor") ?? .green
}


struct materials {
    static let name: Array<String> = ["Пластик", "Органика", "Стекло", "Бумага", "Металл", "Дерево", "Ткань"]
    static var image: Array<UIImage> = [materialImages.plastic,
                                        materialImages.organic,
                                        materialImages.glass,
                                        materialImages.paper,
                                        materialImages.metal,
                                        materialImages.wood,
                                        materialImages.fabric,]
    static let enums: Array<material> = [.plastic, .organic, .glass, .paper, .metal, .wood, .fabric]
    static let statsColors: Array<UIColor> = [materialColors.plastic,
                                              materialColors.organic,
                                              materialColors.glass,
                                              materialColors.paper,
                                              materialColors.metal,
                                              materialColors.wood,
                                              materialColors.fabric]
    static let id: Array<Int> = [0, 1, 2, 3, 4, 5, 6]
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
    static let title: Array<String> = ["Фольга", "Батарейка", "Батарейка", "Другое"]
    static let subtitle: Array<String> = ["Длина 0,5 метра", "Мизинчиковая", "Пальчиковая", "Гвозди и т.д."]
    static let weight: Array<Int> = [30, 25, 40, 50]
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
