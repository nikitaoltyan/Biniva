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
    
    let cellName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 0
        label.text = "Выбери место проведения"
        label.font = UIFont.init(name: "SFPro-Heavy", size: 25.0)
        return label
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 20
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
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = .lightGray
        label.text = "Зачем это нужно?"
        label.textAlignment = .center
        label.font = UIFont.init(name: "SFPro", size: 8.0)
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
    
    
    @objc func LabelAction(){
        print("Label action")
//        Add function - custome PopUp controller with explanation.
    }
    
    
    func Location(){
        mapView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("Location services enabled")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.754316, longitude: 37.619521)
            print("Location: \(location)")
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}





extension AddMapCell{
    
    func SetSubviews(){
        self.addSubview(cellName)
        self.addSubview(mapView)
        self.addSubview(choosedStreetLabel)
        self.addSubview(aboutLabel)
        
        aboutLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelAction)))
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            cellName.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            cellName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            mapView.topAnchor.constraint(equalTo: cellName.bottomAnchor, constant: 10),
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 500),
            
            choosedStreetLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 6),
            choosedStreetLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            choosedStreetLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            aboutLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            aboutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
