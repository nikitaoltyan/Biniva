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
    
    
    
    static func AddLoggedEvent(addedSize size: Int, forUserID uid: String) {
        let dateChild: String = "\(date.day)_\(date.month)_\(date.year)"
        let addRef = ref.child("users/\(uid)/data_logged/\(dateChild)")
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var loggedDict = snapshot.value as? [String: Any] ?? [:]
            loggedDict["logged"] = (loggedDict["logged"] as? Int ?? 0) + size
            loggedDict["timestamp"] = ServerValue.timestamp()
            addRef.setValue(loggedDict)
            addRef.removeAllObservers()
        })
    }
    
    
    
    static func GetUserTodayLoggedData(forUserID uid: String, alreadyLogged: @escaping (_ result: Int) -> Void)  {
        let dateChild: String = "\(date.day)_\(date.month)_\(date.year)"
        let addRef = ref.child("users/\(uid)/data_logged/\(dateChild)")
        addRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let loggedDict = snapshot.value as? [String: Any] ?? [:]
            let logged = loggedDict["logged"] as? Int ?? 0
            alreadyLogged(logged)
            addRef.removeAllObservers()
        })
    }
    
}
