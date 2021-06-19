//
//  TrashBin.swift
//  GreenerCo
//
//  Created by Никита Олтян on 04.06.2021.
//

import MapKit

class TrashBin: NSObject, Decodable, MKAnnotation {
    
    var types: [TrashType] = []
    var pointID: String?
    
    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0
    
    @objc dynamic
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}
