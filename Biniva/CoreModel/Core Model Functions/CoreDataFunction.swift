//
//  CoewDataFunction.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 14.04.2021.
//

import Foundation
import UIKit
import CoreData


class CoreDataFunction {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var managedContext = appDelegate!.persistentContainer.viewContext
    let request: NSFetchRequest<Model> = Model.fetchRequest()
    let pointsRequest: NSFetchRequest<Points> = Points.fetchRequest()
    let askForPointsRequest: NSFetchRequest<AskForPoints> = AskForPoints.fetchRequest()
    
    
    /// Returns all data in model.
    /// - warning: Only for "Model" Data Model.
    /// - warning: Recreate fetch request for properly fetching updated data.
    func fetchData() -> [Model] {
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
    func fetchData() -> [Points] {
        pointsRequest.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(pointsRequest)
        } catch {
            print(error)
        }
        return []
    }
    
    /// Returns all data in model.
    /// - warning: Only for "AskForPoints" Data Model.
    /// - warning: Recreate fetch request for properly fetching updated data.
    func fetchData() -> [AskForPoints] {
        askForPointsRequest.returnsObjectsAsFaults = false
        do {
            return try managedContext.fetch(askForPointsRequest)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Add given data in model.
    /// - warning: Only for "Model" Data Model.
    func AddDataToModel(logSize: [Int], logMaterial: [Int], date: Date?) {
        guard (date != nil) else { return }
        guard (logSize.count > 0) else { return }
        guard (logMaterial.count > 0) else { return }
        let newStamp = Model(context: managedContext)
        newStamp.logSize = logSize
        newStamp.logMaterial = logMaterial
        newStamp.day = date
        try! managedContext.save()
    }
    
    
    func addPointToPoints(latitude: Double, longitude: Double, materials: [Int]?, geohash: String, id: String,
                          result: @escaping(_ point: Points) -> Void ) {
        guard let materials = materials else { return }
        let newStamp = Points(context: managedContext)
        newStamp.geohash = geohash
        newStamp.id = id
        newStamp.materials = materials
        newStamp.latitude = latitude
        newStamp.longitude = longitude
        try! managedContext.save()
        
        // Returning Point to the called function for future passing to map.
        result(newStamp)
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
    func ChangeDataForDay(date: Date, logSize: [Int]?, logMaterial: [Int]?) {
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
    
    
    /// - parameter result: [Points] in given area.
    func getPoitsInArea(xMin: Double, xMax: Double, yMin: Double, yMax: Double, result: @escaping(_ result: [Points]) -> Void) {
        // latitude - y
        // longitude - x
        let predicate1 = NSPredicate(format: "longitude > %@", argumentArray: [xMin])
        let predicate2 = NSPredicate(format: "longitude < %@", argumentArray: [xMax])
        let predicate3 = NSPredicate(format: "latitude > %@", argumentArray: [yMin])
        let predicate4 = NSPredicate(format: "latitude < %@", argumentArray: [yMax])
        
        let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3, predicate4])
        
        pointsRequest.predicate = finalPredicate
        pointsRequest.returnsObjectsAsFaults = false
        
        do {
            let data: [Points] = try managedContext.fetch(pointsRequest)
            result(data)
            return
        } catch {
            print(error)
        }
        result([])
        return
    }
    
    
    func getWeeklyData(start: Date?, end: Date?) -> [Model] {
        let predicate1 = NSPredicate(format: "day > %@", argumentArray: [start!])
        let predicate2 = NSPredicate(format: "day < %@", argumentArray: [end!])
        
        let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        request.predicate = finalPredicate
        do {
            let data: [Model] = try managedContext.fetch(request)
            return data
        } catch {
            print(error)
            return []
        }
    }
    
    
    func addAskForPoint(latitude: Double, longitude: Double) {
        let newStamp = AskForPoints(context: managedContext)
        newStamp.latitude = latitude
        newStamp.longitude = longitude
        newStamp.date = Date.today()
        newStamp.status = false
        try! managedContext.save()
    }
    
    /// Change status into True and date for Today when points that were requested were added.
    /// - warning: date is needed for deleting this entiti after a week.
    func changeAskForPointStatus(latitude: Double, setStatus status: Bool) {
        askForPointsRequest.predicate = NSPredicate(format: "latitude = %@", argumentArray: [latitude])
        askForPointsRequest.returnsObjectsAsFaults = false

        do {
            let data = try managedContext.fetch(askForPointsRequest)
            data[0].setValue(status, forKey: "status")
            data[0].setValue(Date.today(), forKey: "date")
            try! managedContext.save()
        } catch {
            print(error)
        }
    }
    
    /// Delete one specific row from the AskForPoints Model.
    func deleteAskForPoint(latitude: Double) {
        askForPointsRequest.predicate = NSPredicate(format: "latitude = %@", argumentArray: [latitude])
        askForPointsRequest.returnsObjectsAsFaults = false
        
        do {
            let data = try managedContext.fetch(askForPointsRequest)
            
            for item in data {
                managedContext.delete(item)
            }
            
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}
