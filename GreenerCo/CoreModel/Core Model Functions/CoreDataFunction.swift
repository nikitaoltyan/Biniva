//
//  CoewDataFunction.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 14.04.2021.
//

import Foundation
import UIKit
import CoreData


class CoreDataFunction {
    
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let managedContext = appDelegate!.persistentContainer.viewContext
    static let request: NSFetchRequest<Model> = Model.fetchRequest()
    
    /// Returns all data in model.
    /// - warning: Only for "Model" Data Model.
    /// - warning: Recreate fetch request for properly fetching updated data.
    static func fetchData() -> [Model]{
        let request: NSFetchRequest<Model> = Model.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Add given data in model.
    /// - warning: Only for "Model" Data Model.
    static func AddDataToModel(logSize: [Int], logMaterial: [Int], date: Date?){
        guard (date != nil) else { return }
        guard (logSize.count > 0) else { return }
        guard (logMaterial.count > 0) else { return }
        let newStamp = Model(context: managedContext)
        newStamp.logSize = logSize
        newStamp.logMaterial = logMaterial
        newStamp.day = date
        try! managedContext.save()
    }
    
    static func GetByDay(date: Date) -> [Model]{
        request.predicate = NSPredicate(format: "day = %@", argumentArray: [date])
        request.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Changind data for date that already exists in database.
    static func ChangeDataForDay(date: Date, logSize: [Int]?, logMaterial: [Int]?){
        guard (logSize != nil) else { return }
        guard (logMaterial != nil) else { return }
        request.predicate = NSPredicate(format: "day = %@", argumentArray: [date])
        request.returnsObjectsAsFaults = false
        do {
            let data = try managedContext.fetch(request)
            data[0].setValue(logMaterial, forKey: "logMaterial")
            data[0].setValue(logSize, forKey: "logSize")
            try! managedContext.save()
        } catch {
            print(error)
        }
    }
}
