//
//  CoordinateAnnotation.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.06.2021.
//

import MapKit
import CoreLocation

class CoordinateAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
