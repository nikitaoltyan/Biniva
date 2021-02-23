//
//  Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.02.2021.
//

import Foundation


class Defaults {
    
    static let userDefault = UserDefaults.standard
    static let date = Date()
    
    
    /// Function for adding into UserDefaults user's ID and DailyNorm.
    /// - parameter uid: User ID got from Firebase server.
    /// - parameter norm: How much user plans to log.
    static func RegistrateUser(withID uid: String, andDailyNorm norm: Int) {
        SetUserId(userId: uid)
        SetUserDailyNorm(userNorm: norm)
        userDefault.set(true, forKey: "hasLaunched")
    }
    
    
    /// Set user id as default parameter after user registration or log in.
    /// - parameter uid: User ID got from Firebase server.
    static func SetUserId(userId uid: String?) {
        UserDefaults.standard.setValue(uid ?? nil, forKey: "uid")
    }
    
    static func GetUserId() -> String? {
        return UserDefaults.standard.string(forKey: "uid")
    }
    
    /// Set hasLaunched as default parameter after user registration or log in.
    /// - parameter launched: Bool parameter for app. Always true when there's not user firct launch.
    static func SetHasLaunched(launched: Bool) {
        UserDefaults.standard.setValue(launched, forKey: "hasLaunched")
    }
    
    
    /// Function to set user Daily norm for logging.
    /// - parameter norm: How much user plans to log.
    static func SetUserDailyNorm(userNorm norm: Int) {
        print("Set user Daily Norm")
        userDefault.setValue(norm, forKey: "dailyNorm")
    }
    
    
    static func GetUserDailyNorm(userId uid: String?) -> Int {
        guard (uid != nil) else { return 1100 }
        let userDN: Int = userDefault.integer(forKey: "dailyNorm")
        print("User DN from defaults: \(userDN)")
        guard (userDN != 0) else { return 1100 }
        return userDN
    }
    
    
    /// Checking Last Logged data for that day. Also calls ServerMaterial function, that mark logged day on server.
    /// - parameter alreadyLogged: Function return
    /// - returns: Int result. How much gramms was logged today.
    static func CheckLastLogged(alreadyLogged: @escaping (_ result: Int) -> Void){
        let lastLoggedDate = userDefault.string(forKey: "lastLogged") ?? "No data"
        let uid = userDefault.string(forKey: "uid") ?? "NaN"
        let todayDate: String = "\(date.day)_\(date.month)_\(date.year)"
        if lastLoggedDate != todayDate {
            ServerMaterials.SetZeroDayData(forUserID: uid, andDate: todayDate)
            userDefault.setValue(todayDate, forKey: "lastLogged")
            userDefault.setValue(0, forKey: "loggedData")
            alreadyLogged(0)
        } else {
            alreadyLogged(userDefault.integer(forKey: "loggedData"))
        }
    }
    
    
    /// Function for adding Last Logged Date and Today Logged Size into User Defaults.
    /// - warning: Should be called automatically from ServerMaterials.AddLoggedEvent
    /// - warning: Doesn't susceptible to material
    /// - parameter size: The size of added value.
    static func AddLoggedEvent(addedSize size: Int) {
        let todayDate: String = "\(date.day)_\(date.month)_\(date.year)"
        let loggedSize = userDefault.integer(forKey: "loggedData")
        userDefault.setValue(todayDate, forKey: "lastLogged")
        userDefault.setValue(loggedSize+size, forKey: "loggedData")
    }
    
    
    static func GetUserTodayLoggedData(forUserID uid: String, alreadyLogged: @escaping (_ result: Int) -> Void)  {
        let logged = 0
        alreadyLogged(logged)
    }
}
