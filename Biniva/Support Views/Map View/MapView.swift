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
    
    var model = MapView_Model()
    let coreDatabase = DataFunction()
    let server = Server()
    let locationManager = CLLocationManager()
    
    lazy var map: MKMapView = {
        let map = MKMapView()
            .with(autolayout: false)
        map.isUserInteractionEnabled = true
        map.delegate = self
        
        // There should be user's coordinate.
        let coordinate = CLLocationCoordinate2D(latitude: 55.794698, longitude: 37.929111)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
        map.setRegion(viewRegion, animated: false)
        
        map.register(DefaultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        map.register(ClusterPin.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        return map
    }()

    let pinAnnotation: BottomPinView = {
        let view = BottomPinView()
            .with(cornerRadius: 16)
            .with(autolayout: false)
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let addPointView: AddPointButtonView = {
        let view = AddPointButtonView()
            .with(autolayout: false)
        return view
    }()
    
    var delegate: mapDelegate?
    var pinAnnotationBottomConstraint: NSLayoutConstraint?
    var centerCoordinate: CGFloat = 0
    
    var usedTopLeftCoordinate: CLLocationCoordinate2D?
    var usedBottomRightCoordinate: CLLocationCoordinate2D?
    var isFirstInteraction: Bool = true

    var trashBinsID: Set<String> = []
    
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
        setUserLocation()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func setUserLocation() {
        map.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.754316, longitude: 37.619521)
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
        }
    }
    
    /// That function adds Points from [Points] and store theit IDs in Set.
    func addAnnotation(points: [Points]) {
        for point in points {
            guard trashBinsID.contains(point.id ?? "") == false else { return }
            trashBinsID.insert(point.id ?? "")
            
            let coordinate = CLLocationCoordinate2D(latitude: point.latitude,
                                                    longitude: point.longitude)
            let bin = TrashBin()
            bin.coordinate = coordinate
            bin.pointID = point.id
            
            guard let materials = point.materials else { return }
            for type in materials {
                // This force unwrap is not good.
                bin.types.append(TrashType(rawValue: type)!)
            }
            
            DispatchQueue.main.async {
                self.map.addAnnotation(bin)
            }
        }
    }
    
    
    @objc
    func draggedView(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(pinAnnotation)
        let translation = sender.translation(in: self)
//        centerCoordinate = MainConstants.screenHeight + pinAnnotation.frame.height/2
        let condition_1 = pinAnnotation.center.y <= centerCoordinate - 190
        let condition_2 = pinAnnotation.center.y >= centerCoordinate - 700
        if condition_1 && condition_2 {
            pinAnnotation.center = CGPoint(x: pinAnnotation.center.x,
                                           y: pinAnnotation.center.y + translation.y)
        } else {
            setRightPosition()
        }
        sender.setTranslation(CGPoint.zero, in: self)
        
        if (sender.state == .ended) {
            setRightPosition()
        }
    }
    
    @objc
    func addPoint() {
        Vibration.light()
        delegate?.openAddNewPoint()
    }
    
    func setRightPosition(){
        let middle: CGFloat = (190.0 + 500.0)/2.0
        print("setRightPosition")
        print(self.pinAnnotation.center.y)
        print(centerCoordinate-pinAnnotation.center.y)
        switch centerCoordinate-pinAnnotation.center.y {
        case 0...180:
            setClosedPosition()
        case 180...middle:
            setBottomPosition()
        default:
            setTopPosition()
        }
    }
    
    func setClosedPosition() {
        print("setClosedPosition")
        addPointView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate)
            self.addPointView.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func setBottomPosition() {
        self.layoutIfNeeded()
        print("setBottomPosition")
        UIView.animate(withDuration: 0.2, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate-190)
            self.addPointView.transform = CGAffineTransform(translationX: -100, y: 0)
        }, completion: { (_) in
            self.addPointView.isHidden = true
            Vibration.soft()
            print(self.pinAnnotation.center.y)
        })
    }
    
    func setTopPosition() {
        UIView.animate(withDuration: 0.25, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate-500)
        }, completion: { (_) in
            Vibration.soft()
            self.pinAnnotation.loadImages()
        })
    }
    
    
    
    func isLoadingDataNecessary() -> Bool {
        // Setting initial coordinate after first map movement.
        guard (isFirstInteraction == false) else {
            usedTopLeftCoordinate = map.topLeftCoordinate
            usedBottomRightCoordinate = map.bottomRightCoordinate
            isFirstInteraction = false
            getGeoPoints()
            return false
        }
        
        if (usedTopLeftCoordinate?.longitude ?? 90 > map.topLeftCoordinate.longitude) ||
            (usedBottomRightCoordinate?.longitude ?? -90 < map.topRightCoordinate.longitude) ||
            (usedTopLeftCoordinate?.latitude ?? -90 < map.topLeftCoordinate.latitude) ||
            (usedBottomRightCoordinate?.latitude ?? 90 > map.bottomRightCoordinate.latitude) {
            
            if map.topLeftCoordinate.longitude < usedTopLeftCoordinate?.longitude ?? 90 {
                usedTopLeftCoordinate?.longitude = map.topLeftCoordinate.longitude
            }
            
            if map.topRightCoordinate.longitude > usedBottomRightCoordinate?.longitude ?? -90 {
                usedBottomRightCoordinate?.longitude = map.topRightCoordinate.longitude
            }
            
            if map.topLeftCoordinate.latitude > usedTopLeftCoordinate?.latitude ?? -90 {
                usedTopLeftCoordinate?.latitude = map.topLeftCoordinate.latitude
            }
            
            if map.bottomRightCoordinate.latitude < usedBottomRightCoordinate?.latitude ?? 90 {
                usedBottomRightCoordinate?.latitude = map.bottomRightCoordinate.latitude
            }
            
            return true
        } else {
            return false
        }
    }
    
    
    func getGeoPoints() {
        guard isLoadingDataNecessary() else { return }
        
        coreDatabase.getPointsInArea(topLeftX: map.topLeftCoordinate.longitude,
                                     topRightX: map.topRightCoordinate.longitude,
                                     topLeftY: map.topLeftCoordinate.latitude,
                                     bottomLeftY: map.bottomLeftCoordinate.latitude,
                                     result: { (points) in
                                        
            self.addAnnotation(points: points)
                                        
            DispatchQueue.main.async {
                self.server.getGeoPoints(centerCoordinate: self.map.region.center,
                                         radius: self.map.currentRadius(withDelta: 0),
                                         notItPoints: points, result: { (serverPoint) in
                                            self.addAnnotation(points: serverPoint)
                })
            }
        })
    }

}






extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? TrashBin else { return nil }
        let view = DefaultAnnotationView(annotation: annotation, reuseIdentifier: DefaultAnnotationView.ReuseID)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let view = view as? DefaultAnnotationView else { return }
        guard let annotation = view.annotation as? TrashBin else { return }
        setBottomPosition()
        pinAnnotation.pointID = annotation.pointID
        pinAnnotation.setUp(trashTypes: annotation.types, coordinate: annotation.coordinate)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // That function is called only when map movement is complited.
        getGeoPoints()
    }
}






extension MapView{
    func setSubviews(){
        self.addSubview(map)
        self.addSubview(pinAnnotation)
        self.addSubview(addPointView)
        
        pinAnnotation.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
        addPointView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPoint)))
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.topAnchor),
            map.leftAnchor.constraint(equalTo: self.leftAnchor),
            map.rightAnchor.constraint(equalTo: self.rightAnchor),
            map.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pinAnnotation.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            pinAnnotation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pinAnnotation.widthAnchor.constraint(equalToConstant: pinAnnotation.frame.width),
            pinAnnotation.heightAnchor.constraint(equalToConstant: pinAnnotation.frame.height),
            
            addPointView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            addPointView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            addPointView.widthAnchor.constraint(equalToConstant: addPointView.frame.width),
            addPointView.heightAnchor.constraint(equalToConstant: addPointView.frame.height),
        ])
        
        centerCoordinate = MainConstants.screenHeight + pinAnnotation.frame.height/2
    }
}



class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
    
}
