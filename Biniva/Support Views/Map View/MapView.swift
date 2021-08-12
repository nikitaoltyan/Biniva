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
    let userDefaults = Defaults()
    let server = Server()
    let analytics = ServerAnalytics()
    let locationManager = CLLocationManager()
    let mapPreparation = MapPreparation()
    
    lazy var map: MKMapView = {
        let map = MKMapView()
            .with(autolayout: false)
        map.isUserInteractionEnabled = true
        map.showsTraffic = false
        map.delegate = self
        
        // There should be user's coordinate.
        let coordinate = CLLocationCoordinate2D(latitude: 55.794698, longitude: 37.929111)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800,
                                            longitudinalMeters: 800)
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
    
    let returnToPositionView: ReturnToPositionView = {
        let view = ReturnToPositionView()
            .with(autolayout: false)
        view.isHidden = true
        return view
    }()
    
    let paywallView: PaywallButton = {
        let view = PaywallButton()
            .with(autolayout: false)
        print("paywallView getSubscriptionStatus: \(Defaults.getSubscriptionStatus())")
        view.isHidden = Defaults.getSubscriptionStatus()
        return view
    }()
    
    var delegate: mapDelegate?
    var pinAnnotationTopConstraint: NSLayoutConstraint?
    var centerCoordinate: CGFloat = 0
    
    var usedTopLeftCoordinate: CLLocationCoordinate2D?
    var usedBottomRightCoordinate: CLLocationCoordinate2D?
    var userLocation: CLLocationCoordinate2D?
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
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.754316, longitude: 37.619521)
            userLocation = location
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
        }
    }
    
    /// That function adds Points from [Points] and store theit IDs in Set.
    func addAnnotation(points: [Points]) {
        for point in points {
            guard trashBinsID.contains(point.id ?? "") == false else { continue }
            trashBinsID.insert(point.id ?? "")
            
            let coordinate = CLLocationCoordinate2D(latitude: point.latitude,
                                                    longitude: point.longitude)
            let bin = TrashBin()
            bin.coordinate = coordinate
            bin.pointID = point.id
            
            guard let materials = point.materials else { return }
            for type in materials {
                bin.types.append(type)
            }
            
            self.map.addAnnotation(bin)
        }
    }
    
    
    @objc
    func draggedView(_ sender: UIPanGestureRecognizer){
        self.bringSubviewToFront(pinAnnotation)
        let translation = sender.translation(in: self)
        let condition_1 = pinAnnotation.center.y <= centerCoordinate - 170
        let condition_2 = pinAnnotation.center.y >= centerCoordinate - 700
        
        // Removing some glitch with pinAnnotation.center position for a while.
        if (pinAnnotation.isTouchedAlready == false) && (pinAnnotation.center.y == centerCoordinate) {
            setBottomPosition()
            pinAnnotation.isTouchedAlready = true
        }
        
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
        addPointView.tap(completion: { _ in
            self.delegate?.openAddNewPoint()
        })
    }
    
    @objc
    func returnToPositionAction() {
        Vibration.light()
        returnToPositionView.tap(completion: { _ in
            self.setUserLocation()
        })
    }
    
    @objc
    func openPaywallAction() {
        Vibration.light()
        paywallView.tap(completion: { _ in
            self.delegate?.showPaywall()
        })
    }
    
    
    func setRightPosition(){
        let middle: CGFloat = (190.0 + 500.0)/2.0
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
        addPointView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate)
            self.addPointView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { (_) in
            self.map.selectedAnnotations.removeAll()
        })
    }
    
    func setBottomPosition() {
        self.addPointView.layoutIfNeeded()
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
    
    
    func getGeoPoints() {
        guard isLoadingDataNecessary() else { return }
        print("isLoadingDataNecessary guard pass")
        
        coreDatabase.getPointsInArea(topLeftX: usedTopLeftCoordinate?.longitude ?? 0,
                                     topRightX: usedBottomRightCoordinate?.longitude ?? 0,
                                     topLeftY: usedTopLeftCoordinate?.latitude ?? 0,
                                     bottomLeftY: usedBottomRightCoordinate?.latitude ?? 0,
                                     result: { (points) in
                                        
            self.addAnnotation(points: points)
            guard self.isLoadingDataFromServerNecessary() else { return }
            print("isLoadingDataFromServerNecessary guard pass")
                                        
//          Now data is loading for all map visible region. But in the future it should be downloaded only for new extended region.
            DispatchQueue.main.async {
                self.server.getGeoPoints(centerCoordinate: self.map.region.center,
                                         radius: self.map.currentRadius(withDelta: 0),
                                         result: { (serverPoint) in
                    self.addAnnotation(points: serverPoint)
                })
            }
        })
    }
    
    
    private
    func checkReturnLocation() {
        guard userLocation != nil else {
            returnToPositionView.isHidden = false
            return
        }
        guard map.currentRadius(withDelta: 0) < 1000 else {
            print("Too far!")
            returnToPositionView.isHidden = false
            return
        }

        let latitudeDelta = fabs(userLocation!.latitude - map.region.center.latitude)
        let longitudeDelta = fabs(userLocation!.longitude - map.region.center.longitude)

        guard latitudeDelta < 0.01 && longitudeDelta < 0.01 else {
            returnToPositionView.isHidden = false
            return
        }
        returnToPositionView.isHidden = true
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
        analytics.logPointTap()
        setBottomPosition()
        pinAnnotation.pointID = annotation.pointID
        pinAnnotation.setUp(trashTypes: annotation.types, coordinate: annotation.coordinate)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // That function is called only when map movement is complited.
        // If user zoomed out in area with more than 17km radius it will zoom in it back.
        if map.currentRadius(withDelta: 0) > 17000 {
            let viewRegion = MKCoordinateRegion(center: self.map.region.center, latitudinalMeters: 15800,
                                                longitudinalMeters: 15800)
            map.setRegion(viewRegion, animated: true)
        }
        
        // Updateing geoPoints only in the allowed area.
        if map.currentRadius(withDelta: 0) < 17000 {
            getGeoPoints()
            checkReturnLocation()
        }
    }
}






extension MapView {
    private
    func setSubviews() {
        self.addSubview(map)
        self.addSubview(pinAnnotation)
        self.addSubview(addPointView)
        self.addSubview(returnToPositionView)
        self.addSubview(paywallView)
        
        pinAnnotation.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
        addPointView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPoint)))
        returnToPositionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnToPositionAction)))
        paywallView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPaywallAction)))
    }
    
    private
    func activateLayouts() {
        let addPointBottomConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return -35
            case 736: return -50
            default: return -60
            }
        }()
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.topAnchor),
            map.leftAnchor.constraint(equalTo: self.leftAnchor),
            map.rightAnchor.constraint(equalTo: self.rightAnchor),
            map.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pinAnnotation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pinAnnotation.widthAnchor.constraint(equalToConstant: pinAnnotation.frame.width),
            pinAnnotation.heightAnchor.constraint(equalToConstant: pinAnnotation.frame.height),
            
            addPointView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            addPointView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: addPointBottomConstant),
            addPointView.widthAnchor.constraint(equalToConstant: addPointView.frame.width),
            addPointView.heightAnchor.constraint(equalToConstant: addPointView.frame.height),
            
            returnToPositionView.leftAnchor.constraint(equalTo: addPointView.leftAnchor),
            returnToPositionView.bottomAnchor.constraint(equalTo: addPointView.topAnchor, constant: -14),
            returnToPositionView.widthAnchor.constraint(equalToConstant: returnToPositionView.frame.width),
            returnToPositionView.heightAnchor.constraint(equalToConstant: returnToPositionView.frame.height),
            
            paywallView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
            paywallView.bottomAnchor.constraint(equalTo: addPointView.bottomAnchor),
            paywallView.widthAnchor.constraint(equalToConstant: paywallView.frame.width),
            paywallView.heightAnchor.constraint(equalToConstant: paywallView.frame.height),
        ])
        
        pinAnnotationTopConstraint = pinAnnotation.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        pinAnnotationTopConstraint?.isActive = true
        
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



extension MapView {
    
    fileprivate
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
            (usedBottomRightCoordinate?.longitude ?? -90 < map.bottomRightCoordinate.longitude) ||
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
    
    
    fileprivate
    func isLoadingDataFromServerNecessary() -> Bool {
        let (mainTopLeft, mainBottomRight, updateDate) = userDefaults.getLocation()
        
        guard (updateDate != nil) else {
            print("The updateDate is nil")
            DispatchQueue.main.async {
                self.updatePoints()
            }
            return false
        }
        
        let date = Date().onlyDate
        
        guard (mainTopLeft.latitude != 0) && (mainTopLeft.longitude != 0) else {
            print("The Coordinates probably were not setted")
            DispatchQueue.main.async {
                self.updatePoints()
            }
            return false
        }
        
        guard (updateDate == date) else {
            print("The Date not equals Today's Date")
            DispatchQueue.main.async {
                self.updatePoints()
            }
            return false
        }
        
        if (mainTopLeft.longitude > usedTopLeftCoordinate?.longitude ?? 90) ||
            (mainBottomRight.longitude < usedBottomRightCoordinate?.longitude ?? -90) ||
            (mainTopLeft.latitude < usedTopLeftCoordinate?.latitude ?? -90) ||
            (mainBottomRight.latitude > usedBottomRightCoordinate?.latitude ?? 90) {
            
            prepareForFutureExtraction(mainTopLeft: mainTopLeft, mainBottomRight: mainBottomRight)
            
            if (mainTopLeft.longitude > usedTopLeftCoordinate?.longitude ?? 90) {
                userDefaults.updateTopLeftLocationLongitude(withLongitude: usedTopLeftCoordinate?.longitude ?? 90)
            }

            if (mainBottomRight.longitude < usedBottomRightCoordinate?.longitude ?? -90) {
                userDefaults.updateBottomRightLocationLongitude(withLongitude: usedBottomRightCoordinate?.longitude ?? -90)
            }

            if (mainTopLeft.latitude < usedTopLeftCoordinate?.latitude ?? -90) {
                userDefaults.updateTopLeftLocationLatitude(withLatitude: usedTopLeftCoordinate?.latitude ?? -90)
            }

            if (mainBottomRight.latitude > usedBottomRightCoordinate?.latitude ?? 90) {
                userDefaults.updateBottomRightLocationLatitude(withLatitude: usedBottomRightCoordinate?.latitude ?? 90)
            }
            
            print("Default area was extended")
            
            // Return false to depriciate server activity while testing.
//            return false
            return true
        } else {
            return false
        }
        
    }
    
    
    fileprivate
    func updatePoints() {
        print("updatePoints")
        // 0.01 = 1.11 km.
        let delta: Double = 0.04 // Around 4.44 km. So the searching area is around 16 km^2
        let setTopLeftCoordinate = CLLocationCoordinate2D(latitude: self.map.region.center.latitude + delta,
                                                          longitude: self.map.region.center.longitude - delta)
        let setBottomRightCoordinate = CLLocationCoordinate2D(latitude: self.map.region.center.latitude - delta,
                                                              longitude: self.map.region.center.longitude + delta)
        
        userDefaults.setLocation(topLeftCoordinate: setTopLeftCoordinate,
                                 bottomRightCoordinate: setBottomRightCoordinate)
        
        coreDatabase.getPointsInArea(topLeftX: setTopLeftCoordinate.longitude,
                                     topRightX: setBottomRightCoordinate.longitude,
                                     topLeftY: setTopLeftCoordinate.latitude,
                                     bottomLeftY: setBottomRightCoordinate.latitude,
                                     result: { (points) in
                                        
            self.addAnnotation(points: points)
                                        
            DispatchQueue.main.async {
                self.server.getGeoPoints(centerCoordinate: self.map.region.center,
                                         radius: self.map.currentRadius(withDelta: 4440),
                                         result: { (serverPoint) in
                    self.addAnnotation(points: serverPoint)
                })
            }
        })
    }
    
    
    fileprivate
    func prepareForFutureExtraction(mainTopLeft: CLLocationCoordinate2D, mainBottomRight: CLLocationCoordinate2D) {
        print("prepareForFutureExtraction")

        let topLeftLongitudeDelta = usedTopLeftCoordinate!.longitude - mainTopLeft.longitude // If used area inside, then >0
        let topLeftLatitudeDelta = usedTopLeftCoordinate!.latitude - mainTopLeft.latitude // If used area inside, then <0
        let bottomRightLongitudeDelta = usedBottomRightCoordinate!.longitude - mainBottomRight.longitude // If used area inside, then <0
        let bottomRightLatitudeDelta = usedBottomRightCoordinate!.latitude - mainBottomRight.latitude // If used area inside, then >0
        
        let conditions: [Bool] = [
            isTopLeftLongitudeInside(delta: topLeftLongitudeDelta),
            isTopLeftLatitudeInside(delta: topLeftLatitudeDelta),
            isBottomRightLongitudeInside(delta: bottomRightLongitudeDelta),
            isBottomRightLatitudeInside(delta: bottomRightLatitudeDelta)
        ]
        
        var rectangles: [(CLLocationCoordinate2D, CLLocationCoordinate2D)] = []
        
        for (item, condition) in conditions.enumerated() {
            print(condition)
            
            switch item {
            case 0:
                if (condition) {
                    rectangles.append((CLLocationCoordinate2D(latitude: mainTopLeft.latitude, longitude: mainTopLeft.longitude),
                                       CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: mainTopLeft.longitude)))
                } else {
                    rectangles.append((CLLocationCoordinate2D(latitude: mainTopLeft.latitude, longitude: usedTopLeftCoordinate!.longitude),
                                       CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: mainTopLeft.longitude)))
                }
                
            case 1:
                let (lastTopLeft, _) = rectangles[0]
                if (condition) {
                    rectangles.append((CLLocationCoordinate2D(latitude: mainTopLeft.latitude, longitude: lastTopLeft.longitude),
                                       CLLocationCoordinate2D(latitude: mainTopLeft.latitude, longitude: mainBottomRight.longitude)))
                } else {
                    rectangles.append((CLLocationCoordinate2D(latitude: usedTopLeftCoordinate!.latitude, longitude: lastTopLeft.longitude),
                                       CLLocationCoordinate2D(latitude: mainTopLeft.latitude, longitude: mainBottomRight.longitude)))
                }
                
            case 2:
                let (lastTopLeft, _) = rectangles[1]
                if (condition) {
                    rectangles.append((CLLocationCoordinate2D(latitude: lastTopLeft.latitude, longitude: mainBottomRight.longitude),
                                       CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: mainBottomRight.longitude)))
                } else {
                    rectangles.append((CLLocationCoordinate2D(latitude: lastTopLeft.latitude, longitude: mainBottomRight.longitude),
                                       CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: usedBottomRightCoordinate!.longitude)))
                }
                
            default:
                let (lastTopLeft, _) = rectangles[0]
                let (_, lastBottomRight) = rectangles[2]
                if (condition) {
                    rectangles.append((CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: lastTopLeft.longitude),
                                       CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: lastBottomRight.longitude)))
                } else {
                    rectangles.append((CLLocationCoordinate2D(latitude: mainBottomRight.latitude, longitude: lastTopLeft.longitude),
                                       CLLocationCoordinate2D(latitude: usedBottomRightCoordinate!.latitude, longitude: lastBottomRight.longitude)))
                }
            }
        }
        
        var resultArray: [(CLLocationCoordinate2D, CLLocationCoordinate2D)] = []
        for (item, rectangle) in rectangles.enumerated() {
            switch item {
            case 0, 2:
                let (topLeft, bottomRight) = rectangle
                if topLeft.longitude != bottomRight.longitude {
                    resultArray.append(rectangle)
                }
                
            default:
                let (topLeft, bottomRight) = rectangle
                if topLeft.latitude != bottomRight.latitude {
                    resultArray.append(rectangle)
                }
            }
        }
        rectangles.removeAll()
        
        print("Got rectangles:")
        for rect in resultArray {
            print(rect)
        }
    }
    
    
    func isTopLeftLongitudeInside(delta: Double) -> Bool {
        switch delta {
            case 0...: return true
            default: return false
        }
    }
    
    func isTopLeftLatitudeInside(delta: Double) -> Bool {
        switch delta {
        case ...0: return true
            default: return false
        }
    }
    
    func isBottomRightLongitudeInside(delta: Double) -> Bool {
        switch delta {
            case ...0: return true
            default: return false
        }
    }
    
    func isBottomRightLatitudeInside(delta: Double) -> Bool {
        switch delta {
            case 0...: return true
            default: return false
        }
    }
    
}
