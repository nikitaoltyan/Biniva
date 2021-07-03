//
//  Location.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.07.2021.
//

import CoreLocation

class Location {
    
    let locationManager = CLLocationManager()
    
    func requestUserLocation(completion: @escaping(_ success: Bool) -> Void) {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            completion(true)
        } else {
            completion(false)
        }
    }
}
