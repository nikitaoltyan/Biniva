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
    
    
    static func SetZeroDayData(forUserID uid: String, andDate date: String) {
        let addDict: Dictionary<String,Any> = ["logged": 0, "timestamp": ServerValue.timestamp()]
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
    
}
