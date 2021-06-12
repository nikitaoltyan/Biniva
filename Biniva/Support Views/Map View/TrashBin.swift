//
//  TrashBin.swift
//  GreenerCo
//
//  Created by Никита Олтян on 04.06.2021.
//

import MapKit

class TrashBin: NSObject, Decodable, MKAnnotation {
    
    // The same enum is in MaterialData.swift file. Should be redeveloped and simplified.
//    enum TrashType: Int, Decodable {
//        case plastic
//        case organic
//        case glass
//        case paper
//        case metal
//        case wood
//        case fabric
//    }
    
    var types: [TrashType] = [.plastic]
    
    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            // For most uses, `coordinate` can be a standard property declaration without the customized getter and setter shown here.
            // The custom getter and setter are needed in this case because of how it loads data from the `Decodable` protocol.
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}
