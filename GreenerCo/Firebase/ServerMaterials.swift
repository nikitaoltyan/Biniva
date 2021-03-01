//
//  ServerMaterials.swift
//  GreenerCo
//
//  Created by Никита Олтян on 31.01.2021.
//

import Foundation
import Firebase

class ServerMaterials {

    /// Database reference
    static var ref: DatabaseReference {
           return Database.database(url: "https://greener-964fe-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    }
    /// Current date.
    static let date = Date()
    
    /// Function for adding Today Logged Size into User Defaults (for fast declaration in each session) and adding that data into server for future Statistic and other purposes.
    /// - parameter uid: User ID
    static func AddLoggedEvent(addedSize size: Int, forUserID uid: String, material: String) {
        Defaults.AddLoggedEvent(addedSize: size)
        let dateChild: String = "\(date.day)_\(date.month)_\(date.year)"
        let addRef = ref.child("users/\(uid)/data_logged/\(dateChild)")
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var loggedDict = snapshot.value as? [String: Any] ?? [:]
            loggedDict["logged"] = (loggedDict["logged"] as? Int ?? 0) + size
            addRef.setValue(loggedDict)
            addRef.removeAllObservers()
        })
        let addDict: Dictionary<String,Any> = ["logged": size, "material": material]
        addRef.child("logged_materials").childByAutoId().setValue(addDict)
    }
    
    
    static func SetZeroDayData(forUserID uid: String, andDate date: String, textDate: String) {
        let addDict: Dictionary<String,Any> = ["logged": 0, "timestamp": ServerValue.timestamp(), "day": textDate]
        ref.child("users/\(uid)/data_logged/\(date)").setValue(addDict)
    }
    
    
    /// Function for getting user logged data for today.
    /// - warning: Function for delating. Don't call it. Defaults.CheckLastLogged replaced that function.
    static func GetUserTodayLoggedData(forUserID uid: String?, alreadyLogged: @escaping (_ result: Int) -> Void)  {
        guard (uid != nil) else {
            alreadyLogged(0)
            return
        }
        let dateChild: String = "\(date.day)_\(date.month)_\(date.year)"
        let addRef = ref.child("users/\(uid!)/data_logged/\(dateChild)")
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let loggedDict = snapshot.value as? [String: Any] ?? [:]
            let logged = loggedDict["logged"] as? Int ?? 0
            alreadyLogged(logged)
            addRef.removeAllObservers()
        })
    }
    
    
    
    static func GetHeights(forUserID uid: String?, maxHeight max: CGFloat, result: @escaping (_ heights: Array<CGFloat>,  _ logged: Array<Int>, _ weekdays: Array<String>) -> Void) {
        guard (uid != nil) else {
            let heights = [CGFloat](repeating: 0, count: 7)
            let logged = [Int](repeating: 0, count: 7)
            let weekdays = [String](repeating: "NaN", count: 7)
            result(heights, logged, weekdays)
            return
        }
        GetSevenDaysLoggedSize(forUserID: uid, result: { arr in
            guard (arr.count == 7) else { return }
            let maxX: Int = arr.values.max()!
            let function = MaterialDefaults.CreateFunction(maxX: CGFloat(maxX), maxY: max)
            let sortedKeys = Array(arr.keys).sorted(by: <)
            var heights: Array<CGFloat> = []
            var logged: Array<Int> = []
            var weekdays: Array<String> = []
            for key in sortedKeys {
                let height: CGFloat = function(CGFloat(arr[key]!))
                heights.append(height)
                logged.append(arr[key]!)
                weekdays.append(Date.stringWeekdayName(day: key))
                result(heights, logged, weekdays)
            }
        })
    }
    
    
    private static func GetSevenDaysLoggedSize(forUserID uid: String?, result: @escaping (_ result: Dictionary<Int, Int>) -> Void) {
        guard (uid != nil) else {
            let emptyDict: Dictionary<Int, Int> = [0:0, 0:0, 0:0, 0:0, 0:0, 0:0, 0:0]
            result(emptyDict)
            return
        }
        let useRef = ref.child("users/\(uid!)/data_logged/")
        let useDict = Date().sevenDaysDict
        var resDict: Dictionary<Int, Int> = [:]
        let keys = useDict.keys
        for key in keys {
            let day = Date.stringDayName(day: key)
            useRef.child(day).observe(.value, with: { (snapshot) in
                let loggedDict = snapshot.value as? [String: Any] ?? [:]
                print(loggedDict)
                let logged = loggedDict["logged"] as? Int ?? 0
                resDict[key] = logged
                result(resDict)
            })
        }
    }
}
