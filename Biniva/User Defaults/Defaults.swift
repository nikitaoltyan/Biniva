//
//  Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.02.2021.
//

import Foundation
import CoreLocation
import MapKit
import Adapty


class Defaults {
    
    /// Set hasLaunched as default parameter after user finished onboarding.
    /// - parameter launched: Bool parameter for app. Always true when there's not user first launch.
    func setHasLaunched(_ launched: Bool) {
        UserDefaults.standard.setValue(launched, forKey: "hasLaunched")
    }
 
    func setLocation(topLeftCoordinate: CLLocationCoordinate2D,
                     bottomRightCoordinate: CLLocationCoordinate2D) {
        let date = Date().onlyDate
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
    
    func setSubscriptionStatus() {
//        UserDefaults.standard.setValue(true, forKey: "isSubscriptionActive")
        Adapty.getPurchaserInfo { (purchaserInfo, error) in
            guard error == nil else {
                UserDefaults.standard.setValue(false, forKey: "isSubscriptionActive")
                self.setSubscriptionStart(date: nil)
                return
            }

            // "premium" is an identifier of default access level
            if purchaserInfo?.accessLevels["premium"]?.isActive == true {
                // grant access to premium features
                UserDefaults.standard.setValue(true, forKey: "isSubscriptionActive")
                let date: Date? = purchaserInfo?.accessLevels["premium"]?.activatedAt
                self.setSubscriptionStart(date: date)
            } else {
                UserDefaults.standard.setValue(false, forKey: "isSubscriptionActive")
                self.setSubscriptionStart(date: nil)
            }

        }
    }
    
    private
    func setSubscriptionStart(date: Date?) {
        guard date != nil else {
            UserDefaults.standard.setValue(nil, forKey: "subscriptionStart")
            return
        }
        
        UserDefaults.standard.setValue(date!, forKey: "subscriptionStart")
    }
    
    static
    func getIsSubscribed() -> Bool {
        return UserDefaults.standard.bool(forKey: "isSubscriptionActive")
    }
    
    static
    func getSubscriptionStart() -> Date {
        guard let date = UserDefaults.standard.object(forKey: "subscriptionStart") as? Date else {
            return Date.today()
        }
        return date
    }
    
    // In general 0 – metric, 1 – imperial
    static
    func setWeightSystem(typeOfSystem type: Int) {
        guard type == 0 || type == 1 else { return }
        UserDefaults.standard.setValue(type, forKey: "weightType")
    }
    
    static
    func getWeightSystem() -> Int {
        let type: Int = UserDefaults.standard.integer(forKey: "weightType")
        guard type == 0 || type == 1 else {  return 0  }
        return type
    }
    
    static
    func setDateLastWeeklyReportGenerated() {
        UserDefaults.standard.setValue(Date().onlyDate, forKey: "lastWeeklyReport")
    }
    
    static
    func getDateLastWeeklyReportGenerated() -> Date {
        guard let date = UserDefaults.standard.object(forKey: "lastWeeklyReport") as? Date else {
            return Date.today()
        }
        return date
    }
    
    func setGeolocationStatus() {
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D? = locationManager.location?.coordinate
            
            if location != nil {
                print("Geolocation status: true")
                UserDefaults.standard.setValue(true, forKey: "locationServicesEnabled")
            } else {
                print("Geolocation status: false")
                UserDefaults.standard.setValue(false, forKey: "locationServicesEnabled")
            }
        }
    }
    
    
    /// - returns: returns True if geolocation enabled and False, if geolocation disabled.
    static
    func getGeolocationStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "locationServicesEnabled")
    }
}
