//
//  MapView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 20.05.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIView {
    
    lazy var map: MKMapView = {
        let map = MKMapView()
            .with(autolayout: false)
        map.isUserInteractionEnabled = true
        
//        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
//        map.setRegion(viewRegion, animated: false)
        return map
    }()

    
    
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}






extension MapView{
    func setSubviews(){
        self.addSubview(map)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.topAnchor),
            map.leftAnchor.constraint(equalTo: self.leftAnchor),
            map.rightAnchor.constraint(equalTo: self.rightAnchor),
            map.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
