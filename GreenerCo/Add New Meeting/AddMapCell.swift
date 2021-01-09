//
//  AddMapCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.12.2020.
//

import UIKit
import MapKit
import CoreLocation

class AddMapCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 20
        map.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return map
    }()
    
    let choosedStreetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 0
        label.font = UIFont.init(name: "SFPro-Medium", size: 22.0)
        return label
    }()
    
    let locationManager = CLLocationManager()
    var currentAnnotation: MKPointAnnotation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubviews()
        ActivateLayouts()
        Location()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        print("Handle tap")
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Add annotation:
        if mapView.annotations.count < 2 {
            print("New annotation")
            currentAnnotation = MKPointAnnotation()
            currentAnnotation?.coordinate = coordinate
            mapView.addAnnotation(currentAnnotation!)
        } else {
            print("Set new annotation")
            mapView.removeAnnotation(currentAnnotation!)
            currentAnnotation = MKPointAnnotation()
            currentAnnotation?.coordinate = coordinate
            mapView.addAnnotation(currentAnnotation!)
        }
        
        let usedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let geocoder = CLGeocoder()
                    
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(usedLocation, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self.currentAnnotation?.title = firstLocation?.name
                self.choosedStreetLabel.text = firstLocation?.name
            } else {
                // An error occurred during geocoding.
                self.currentAnnotation?.title = "Location is not available"
                self.choosedStreetLabel.text = "Location is not available"
            }
        })
        
        
    }
    
    func Location(){
        mapView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("Location services enabled")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
//              Extend for users with internet (location) unavailablement.
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}





extension AddMapCell{
    
    func SetSubviews(){
        self.addSubview(mapView)
        self.addSubview(choosedStreetLabel)
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 500),
            
            choosedStreetLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 6),
            choosedStreetLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            choosedStreetLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
}
