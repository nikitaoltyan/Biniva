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
    static let id: Array<Int> = [0, 1, 2, 3, 4, 5, 6]
}



struct plastic {
    static let title: Array<String> = ["Бутылка", "Бутылка", "Бутылка", "Бутылка", "Канистра", "Другое"]
    static let subtitle: Array<String> = ["Объем 0.33 литра", "Объем 0.5 литра", "Объем 1 литр", "Объем 1.5 литра", "Объем 5 литров", "Обертка и т.д."]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct organic {
    static let title: Array<String> = ["organic 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct glass {
    static let title: Array<String> = ["glass 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct paper {
    static let title: Array<String> = ["paper 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct metal {
    static let title: Array<String> = ["metal 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct wood {
    static let title: Array<String> = ["wood 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}

struct fabric {
    static let title: Array<String> = ["fabric 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
    static let subtitle: Array<String> = ["Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle", "Subtitle"]
    static let weight: Array<Int> = [30, 40, 60, 80, 160, 50] // Weights are incorrect. Should be checked out.
}
