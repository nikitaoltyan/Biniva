//
//  Points+CoreDataProperties.swift
//  Biniva
//
//  Created by Никита Олтян on 16.06.2021.
//
//

import Foundation
import CoreData


extension Points {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Points> {
        return NSFetchRequest<Points>(entityName: "Points")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var materials: [Int]?
    @NSManaged public var id: String?

}

extension Points : Identifiable {

}
