//
//  Location.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.07.2021.
//

import CoreLocation

class Location {
    
    let locationManager = CLLocationManager()
    
    
    func requestUserLocation(completion: @escaping(_ success:  Bool) -> Void) {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    completion(false)
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    completion(true)
            @unknown default:
                completion(false)
            }
        } else {
            completion(false)
        }
    }
}
