//
//  Model+CoreDataProperties.swift
//  GreenerCo
//
//  Created by Никита Олтян on 14.04.2021.
//
//

import Foundation
import CoreData


extension Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model> {
        return NSFetchRequest<Model>(entityName: "Model")
    }

    @NSManaged public var day: Date?
    @NSManaged public var logSize: [Int]?
    @NSManaged public var logMaterial: [Int]?

}

extension Model : Identifiable {

}
