//
//  MapPreparation.swift
//  Biniva
//
//  Created by Nick Oltyan on 10.07.2021.
//

import CoreLocation
import GeoFire


class MapPreparation {
    // latitude - Y-axis
    // longitude - X-axis
    
    
    // As return here should be 4 lenth array with (centerCoordinate, radius)
    func separateIntoFour(topLeftCoordinate topLeft: CLLocationCoordinate2D,
                          bottomRightCoordinate bottomRight: CLLocationCoordinate2D) {
        
        print("separateIntoFour")
        print("Got array: \(definePosition(topLeftCoordinate: topLeft, bottomRightCoordinate: bottomRight))")
    }
    
    
    private
    func definePosition(topLeftCoordinate topLeft: CLLocationCoordinate2D,
                        bottomRightCoordinate bottomRight: CLLocationCoordinate2D) -> [(CLLocationCoordinate2D, CLLocationCoordinate2D)] {
        
        let latitudeDelta = fabs(topLeft.latitude - bottomRight.latitude)
        let longitudeDelta = fabs(topLeft.longitude - bottomRight.longitude)
        
        if latitudeDelta > longitudeDelta {
            print("Vertical")
            return divideIntoFourVerical(topLeftCoordinate: topLeft, bottomRightCoordinate: bottomRight)
        } else {
            print("Horizontal")
            return divideIntoFourHorizontal(topLeftCoordinate: topLeft, bottomRightCoordinate: bottomRight)
        }
    }
    
    
    // For Verical
    private
    func divideIntoFourVerical(topLeftCoordinate topLeft: CLLocationCoordinate2D,
                        bottomRightCoordinate bottomRight: CLLocationCoordinate2D) -> [(CLLocationCoordinate2D, CLLocationCoordinate2D)] {
        
        var returnArray: Array<(CLLocationCoordinate2D, CLLocationCoordinate2D)> = []
        
        let bottomLongitude: CLLocationDegrees = bottomRight.longitude
        let topLongitude: CLLocationDegrees = bottomRight.latitude
        let topLatitude: CLLocationDegrees = bottomRight.latitude
        let latitudeStep = fabs(topLeft.latitude - bottomRight.latitude)/4
        
        for step in 0...3 {
            let top: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: topLatitude + Double(step)*latitudeStep,
                                                                     longitude: topLongitude)
            let bottom: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: topLatitude + Double(step+1)*latitudeStep,
                                                                        longitude: bottomLongitude)
            returnArray.append((top, bottom))
        }
        
        return returnArray
    }
    
    
    // For Horizontal
    private
    func divideIntoFourHorizontal(topLeftCoordinate topLeft: CLLocationCoordinate2D,
                                  bottomRightCoordinate bottomRight: CLLocationCoordinate2D) -> [(CLLocationCoordinate2D, CLLocationCoordinate2D)] {
        
        var returnArray: Array<(CLLocationCoordinate2D, CLLocationCoordinate2D)> = []
        
        let topLatitude: CLLocationDegrees = bottomRight.longitude
        let bottomLatitude: CLLocationDegrees = bottomRight.latitude
        let bottomLongitude: CLLocationDegrees = bottomRight.latitude
        let longitudeStep = fabs(topLeft.longitude - bottomRight.longitude)/4
        
        for step in 0...3 {
            let top: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: topLatitude,
                                                                     longitude: bottomLongitude - Double(4-step) * longitudeStep)
            let bottom: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: bottomLatitude,
                                                                        longitude: bottomLongitude - Double(3-step) * longitudeStep)
            returnArray.append((top, bottom))
        }
        
        return returnArray
    }
    
    
    /// Finding center CLLocation for given square and defines the radius of square from topLeftCoordinate to Center.
    private
    func getCenterAndRadius(topLeftCoordinate topLeft: CLLocationCoordinate2D,
                            bottomRightCoordinate bottomRight: CLLocationCoordinate2D) -> (CLLocation, Double) {
        
        let latitudeDelta = fabs(topLeft.latitude - bottomRight.latitude)
        let longitudeDelta = fabs(topLeft.longitude - bottomRight.longitude)
        
        let center: CLLocation = CLLocation(latitude: topLeft.latitude + latitudeDelta/2,
                                            longitude: topLeft.longitude + longitudeDelta/2)
        let topLeftLocation = CLLocation(latitude: topLeft.latitude,
                                         longitude: topLeft.longitude)
        
        let radius = round(center.distance(from: topLeftLocation))
        
        return (center, radius)
    }
}
