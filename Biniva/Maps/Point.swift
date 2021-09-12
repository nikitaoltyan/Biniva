//
//  Point.swift
//  Biniva
//
//  Created by Nick Oltyan on 12.09.2021.
//

import Foundation

class Point {
    var lat: Double?
    var lng: Double?
    var materials: [Int]?
    var geohash: String?
    var id: String?
    
    init(latitude: Double, longitude: Double, materials: [Int], geohash: String, id: String) {
        lat = latitude
        lng = longitude
        self.materials = materials
        self.geohash = geohash
        self.id = id
    }
}

