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
        label.numberOfLines = 1
        label.text = "Выбери место проведения"
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 25} else {return 22}}()
        label.font = UIFont.init(name: "SFPro-Heavy", size: fontSize)
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
        let fontSize: CGFloat = {if MainConstants.screenHeight > 700 {return 22} else {return 19}}()
        label.font = UIFont.init(name: "SFPro-Medium", size: fontSize)
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
    
    var delegate: PassDataDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Add map cell")
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
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Add annotation:
        if mapView.annotations.count < 2 {
            currentAnnotation = MKPointAnnotation()
            currentAnnotation?.coordinate = coordinate
            mapView.addAnnotation(currentAnnotation!)
        } else {
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
                self.delegate?.PassPlace(place: firstLocation?.name ?? "No data")
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
        let mapWidth: CGFloat = {if MainConstants.screenHeight > 700 {return 500} else {return 390}}()
        let cellTop: CGFloat = {if MainConstants.screenHeight > 700 {return 110} else {return 85}}()
        NSLayoutConstraint.activate([
            cellName.topAnchor.constraint(equalTo: self.topAnchor, constant: cellTop),
            cellName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),

            mapView.topAnchor.constraint(equalTo: cellName.bottomAnchor, constant: 10),
            mapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapWidth),

            choosedStreetLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 6),
            choosedStreetLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            choosedStreetLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),

            aboutLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            aboutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
