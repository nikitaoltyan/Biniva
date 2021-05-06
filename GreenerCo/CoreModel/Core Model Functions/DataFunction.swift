//
//  DataFunction.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 15.04.2021.
//

import Foundation
import UIKit


class DataFunction {
    
    let database = CoreDataFunction.self
    
    
    func addData(loggedSize: Int, material: Int, date: Date?) {
        guard (date != nil) else { return }
        let data = database.GetByDay(date: date!)
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
        let data = database.GetByDay(date: date)
        guard data.count > 0 else {
            result(0)
            return}
        let logSize = data[0].logSize
        let sum = logSize?.reduce(0, +)
        result(sum ?? 0)
    }
    
    /// - warning: Fetchs all data that exists.
    func fetchData() -> [Model] {
        let data = database.FetchData()
        return data
    }
}
