//
//  Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.02.2021.
//

import Foundation
import CoreLocation


class Defaults {
    
    /// Set hasLaunched as default parameter after user finished onboarding.
    /// - parameter launched: Bool parameter for app. Always true when there's not user first launch.
    func setHasLaunched(_ launched: Bool) {
        UserDefaults.standard.setValue(launched, forKey: "hasLaunched")
    }
 
    func setLocation(topLeftCoordinate: CLLocationCoordinate2D,
                     bottomRightCoordinate: CLLocationCoordinate2D) {
        guard let date = Date().onlyDate else { return }
        print("setLocation fore date: \(date)")
        let topLeft: [String: Double] = ["latitude": topLeftCoordinate.latitude,
                                         "longitude": topLeftCoordinate.longitude]
        let bottomRight: [String: Double] = ["latitude": bottomRightCoordinate.latitude,
                                         "longitude": bottomRightCoordinate.longitude]
        UserDefaults.standard.setValue(topLeft, forKey: "topLeftCoordinate")
        UserDefaults.standard.setValue(bottomRight, forKey: "bottomRightCoordinate")
        UserDefaults.standard.setValue(date, forKey: "lastUpdateDate")
    }
    
    /// - returns: (topLeftCoordinate, bottomRightCoordinate, Date)
    func getLocation() -> (CLLocationCoordinate2D, CLLocationCoordinate2D, Date?) {
        let topLeft: [String: Double] = UserDefaults.standard.dictionary(forKey: "topLeftCoordinate") as? [String: Double] ?? [:]
        let bottomRight: [String: Double] = UserDefaults.standard.dictionary(forKey: "bottomRightCoordinate") as? [String: Double] ?? [:]
        
        let topLeftCoordinate = CLLocationCoordinate2D(latitude: topLeft["latitude"] ?? 0, longitude: topLeft["longitude"] ?? 0)
        let bottomRightCoordinate = CLLocationCoordinate2D(latitude: bottomRight["latitude"] ?? 0, longitude: bottomRight["longitude"] ?? 0)
        let date: Date? = UserDefaults.standard.object(forKey: "lastUpdateDate") as? Date
        return(topLeftCoordinate, bottomRightCoordinate, date)
    }
    
    
    func updateTopLeftLocationLatitude(withLatitude latitude: Double) {
        var topLeft: [String: Double] = UserDefaults.standard.dictionary(forKey: "topLeftCoordinate") as? [String: Double] ?? [:]
        topLeft["latitude"] = latitude
        UserDefaults.standard.setValue(topLeft, forKey: "topLeftCoordinate")
    }
    
    
    func updateTopLeftLocationLongitude(withLongitude longitude: Double) {
        var topLeft: [String: Double] = UserDefaults.standard.dictionary(forKey: "topLeftCoordinate") as? [String: Double] ?? [:]
        topLeft["longitude"] = longitude
        UserDefaults.standard.setValue(topLeft, forKey: "topLeftCoordinate")
    }
    
    
    func updateBottomRightLocationLatitude(withLatitude latitude: Double) {
        var bottomRight: [String: Double] = UserDefaults.standard.dictionary(forKey: "bottomRightCoordinate") as? [String: Double] ?? [:]
        bottomRight["latitude"] = latitude
        UserDefaults.standard.setValue(bottomRight, forKey: "bottomRightCoordinate")
    }
    
    
    func updateBottomRightLocationLongitude(withLongitude longitude: Double) {
        var bottomRight: [String: Double] = UserDefaults.standard.dictionary(forKey: "bottomRightCoordinate") as? [String: Double] ?? [:]
        bottomRight["longitude"] = longitude
        UserDefaults.standard.setValue(bottomRight, forKey: "bottomRightCoordinate")
    }
    
    func setIsCameraUsed(_ set: Bool) {
        UserDefaults.standard.setValue(set, forKey: "isCameraUsed")
    }
    
    func getIsCameraUsed() -> Bool {
       return UserDefaults.standard.bool(forKey: "isCameraUsed")
    }
}
