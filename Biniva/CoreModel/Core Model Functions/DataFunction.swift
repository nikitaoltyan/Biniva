//
//  DataFunction.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 15.04.2021.
//

import Foundation
import UIKit


class DataFunction {
    
    let database = CoreDataFunction()
    
    
    func addData(loggedSize: Int, material: Int, date: Date?) {
        guard (date != nil) else { return }
        let data = database.getByDay(date: date!)
        if data.count == 1 {
            var logSize = data[0].logSize
            var logMaterial = data[0].logMaterial
            logSize?.append(loggedSize)
            logMaterial?.append(material)
            database.ChangeDataForDay(date: date!, logSize: logSize, logMaterial: logMaterial)
        } else {
            database.AddDataToModel(logSize: [loggedSize], logMaterial: [material], date: date)
        }
    }
    
    /// - warning: Only for specific date.
    func getTotalLogged(forDate date: Date?, result: @escaping(_ result: Int) -> Void){
        guard let date = date else {
            result(0)
            return}
        let data = database.getByDay(date: date)
        guard data.count > 0 else {
            result(0)
            return}
        let logSize = data[0].logSize
        let sum = logSize?.reduce(0, +)
        result(sum ?? 0)
    }
    
    /// - warning: For all data.
    func getTotalLogged(result: @escaping(_ result: Int) -> Void) {
        let data: [Model] = database.fetchData()
        guard data.count > 0 else {
            result(0)
            return}
        
        var cummulatedSum: Int = 0
        
        for row in data {
            let logSize = row.logSize
            let sum = logSize?.reduce(0, +)
            cummulatedSum += sum ?? 0
        }
        
        result(cummulatedSum)
    }
    
    /// - warning: Fetchs all data that exists.
    func fetchData() -> [Model] {
        let data: [Model] = database.fetchData()
        return data
    }
    
    func fetchData() -> [Points] {
        let data: [Points] = database.fetchData()
        return data
    }
    
    func addPoint(latitude: Double, longitude: Double, materials: [Int]?, id: String) {
        let data = database.getByPointID(id: id)
        guard data.count == 0 else { return }
        database.addPointToPoints(latitude: latitude,
                                  longitude: longitude,
                                  materials: materials,
                                  id: id)
    }
    
    /// - warning: That function deletes all data in Points Core Data. Should be used carefully.
    func deleteAllPoints() {
        database.deleteAllPoints()
    }
}
