//
//  MKMapView+Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.05.2021.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

extension MKMapView {
    var topLeftCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate
    }

    var topRightCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate
    }

    var bottomLeftCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate
    }

    var bottomRightCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate
    }

    /// - parameter delta: Measured in meaters.
    /// - returns: Visible radius of MapView (measured in meters)
    func currentRadius(withDelta delta: Double) -> Double {
        let topLeftLocation = CLLocation(latitude: topLeftCoordinate.latitude,
                                 longitude: topLeftCoordinate.longitude)
        let center = self.region.center
        let centerLocation = CLLocation(latitude: center.latitude,
                                        longitude: center.longitude)
        return round(centerLocation.distance(from: topLeftLocation) + delta)
    }
}
