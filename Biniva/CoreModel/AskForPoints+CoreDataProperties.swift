//
//  AskForPoints+CoreDataProperties.swift
//  Biniva
//
//  Created by Никита Олтян on 01.09.2021.
//
//

import Foundation
import CoreData


extension AskForPoints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AskForPoints> {
        return NSFetchRequest<AskForPoints>(entityName: "AskForPoints")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var status: Bool
    @NSManaged public var date: Date?

}

extension AskForPoints : Identifiable {

}
