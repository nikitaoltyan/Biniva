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
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var managedContext = appDelegate!.persistentContainer.viewContext
    let request: NSFetchRequest<Model> = Model.fetchRequest()
    let pointsRequest: NSFetchRequest<Points> = Points.fetchRequest()
    
    
    /// Returns all data in model.
    /// - warning: Only for "Model" Data Model.
    /// - warning: Recreate fetch request for properly fetching updated data.
    func fetchData() -> [Model]{
        request.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Returns all data in model.
    /// - warning: Only for "Points" Data Model.
    /// - warning: Recreate fetch request for properly fetching updated data.
    func fetchData() -> [Points]{
        pointsRequest.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(pointsRequest)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Add given data in model.
    /// - warning: Only for "Model" Data Model.
    func AddDataToModel(logSize: [Int], logMaterial: [Int], date: Date?){
        guard (date != nil) else { return }
        guard (logSize.count > 0) else { return }
        guard (logMaterial.count > 0) else { return }
        let newStamp = Model(context: managedContext)
        newStamp.logSize = logSize
        newStamp.logMaterial = logMaterial
        newStamp.day = date
        try! managedContext.save()
    }
    
    
    func addPointToPoints(latitude: Double, longitude: Double, materials: [Int]?, id: String) {
        guard let materials = materials else { return }
        let newStamp = Points(context: managedContext)
        newStamp.id = id
        newStamp.materials = materials
        newStamp.latitude = latitude
        newStamp.longitude = longitude
        try! managedContext.save()
    }
    
    
    func getByDay(date: Date) -> [Model] {
        request.predicate = NSPredicate(format: "day = %@", argumentArray: [date])
        request.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    
    func getByPointID(id: String) -> [Points] {
        pointsRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        pointsRequest.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(pointsRequest)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Changind data for date that already exists in database.
    func ChangeDataForDay(date: Date, logSize: [Int]?, logMaterial: [Int]?){
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
    
    /// - warning: That function deletes all data in Points Core Data. Should be used carefully.
    func deleteAllPoints() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Points")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
           print(error)
        }
    }
}
