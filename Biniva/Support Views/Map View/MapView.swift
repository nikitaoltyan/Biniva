//
//  MapView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 20.05.2021.
//

import UIKit
import MapKit
import CoreLocation

protocol bottomPinDelegate {
    func showImageShower(withImages images: [String], open: Int)
    func showActivityController()
}

protocol askForPointsDelegate {
    func askForPoints(showAgain show: Bool)
    func close()
}


class MapView: UIView {
    
//    var model = MapView_Model()
    let coreDatabase = DataFunction()
    let userDefaults = Defaults()
    let server = Server()
    let analytics = ServerAnalytics()
    let locationManager = CLLocationManager()
//    let mapPreparation = MapPreparation()
    
    lazy var map: MKMapView = {
        let map = MKMapView()
            .with(autolayout: false)
        map.isUserInteractionEnabled = true
        map.showsTraffic = false
        map.delegate = self
        
        map.register(DefaultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        map.register(ClusterPin.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        return map
    }()

    lazy var pinAnnotation: BottomPinView = {
        let view = BottomPinView()
            .with(cornerRadius: 16)
            .with(autolayout: false)
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.isUserInteractionEnabled = true
        view.delegate = self
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
        view.isHidden = Defaults.getIsSubscribed()
        return view
    }()
    
    let disabledGeolocationView: DisabledGeolocationView = {
        let view = DisabledGeolocationView()
            .with(autolayout: false)
        view.isHidden = Defaults.getGeolocationStatus()
        return view
    }()
    
    lazy var askForPointsView: AskForPointsView = {
        let view = AskForPointsView()
            .with(autolayout: false)
        view.alpha = 0
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    
    weak var delegate: mapDelegate?
    var pinAnnotationTopConstraint: NSLayoutConstraint?
    var centerCoordinate: CGFloat = 0
    
    var usedTopLeftCoordinate: CLLocationCoordinate2D?
    var usedBottomRightCoordinate: CLLocationCoordinate2D?
    var userLocation: CLLocationCoordinate2D?
    var isFirstInteraction: Bool = true
    var isAskForPointsTapped: Bool = false

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

    func updatePaywallButton() {
        paywallView.isHidden = Defaults.getIsSubscribed()
    }
    
    func setUserLocation() {
        map.showsUserLocation = true
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D = locationManager.location?.coordinate
                ?? CLLocationCoordinate2D(latitude: 51.499724, longitude: -0.141420) // London Buckingham Palace
            userLocation = location
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            
            // Diasabling map movement when geolocation disabled.
            if Defaults.getGeolocationStatus() {
                self.map.isUserInteractionEnabled = true
                self.disabledGeolocationView.isHidden = true
                self.map.alpha = 1
            } else {
                self.map.isUserInteractionEnabled = false
                self.disabledGeolocationView.isHidden = false
                self.map.alpha = 0.8
            }
        }
    }
    
    /// That function adds Points from [Points] and store theit IDs in Set.
//    func addAnnotation(points: [Points]) {
//        for point in points {
//            guard trashBinsID.contains(point.id ?? "") == false else { continue }
//            trashBinsID.insert(point.id ?? "")
//
//            let coordinate = CLLocationCoordinate2D(latitude: point.latitude,
//                                                    longitude: point.longitude)
//            let bin = TrashBin()
//            bin.coordinate = coordinate
//            bin.pointID = point.id
//
//            guard let materials = point.materials else { return }
//            for type in materials {
//                bin.types.append(type)
//            }
//
//            self.map.addAnnotation(bin)
//        }
//    }
    
    private
    func addAnnotation(points: [Point]) {
        print("addAnnotation")
        for point in points {
            guard trashBinsID.contains(point.id ?? "") == false else { continue }
            trashBinsID.insert(point.id ?? "")
            
            let coordinate = CLLocationCoordinate2D(latitude: point.lat ?? 0.0,
                                                    longitude: point.lng ?? 0.0)
            let bin = TrashBin()
            bin.coordinate = coordinate
            bin.pointID = point.id
            
            guard let materials = point.materials else { return }
            for type in materials {
                bin.types.append(type)
            }
            
            self.map.addAnnotation(bin)
        }
        
        showAskForPointsView()
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
    
    @objc private
    func openPaywallAction() {
        Vibration.light()
        paywallView.tap(completion: { _ in
            self.delegate?.showPaywall()
        })
    }
    
    private
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
    
    private
    func setClosedPosition() {
        addPointView.isHidden = false
        paywallView.isHidden = Defaults.getIsSubscribed()
        UIView.animate(withDuration: 0.1, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate)
            self.addPointView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.paywallView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { (_) in
            self.map.selectedAnnotations.removeAll()
        })
    }
    
    private
    func setBottomPosition() {
        self.addPointView.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate-190)
            self.addPointView.transform = CGAffineTransform(translationX: -100, y: 0)
            self.paywallView.transform = CGAffineTransform(translationX: 100, y: 0)
        }, completion: { (_) in
            self.addPointView.isHidden = true
            self.paywallView.isHidden = true
            self.pinAnnotation.update(set: .hide)
            Vibration.soft()
        })
    }
    
    private
    func setTopPosition() {
        UIView.animate(withDuration: 0.25, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate-500)
        }, completion: { (_) in
            Vibration.soft()
            self.pinAnnotation.update(set: .show)
            self.pinAnnotation.loadImages()
        })
    }
 
    
    private
    func getGeoPoints() {
        print("getGeoPoints")
        server.getGeoPoints(centerCoordinate: self.map.region.center, radius: self.map.currentRadius(withDelta: 0), result: { [weak self] points in
            guard let strongSelf = self else { return }
            print("getGeoPoints: \(points)")
            strongSelf.addAnnotation(points: points)
        })
    }
    
    
    private
    func removeGeoPoints() {
        removeAllUnvisibleAnnotations()
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

    private
    func showAskForPointsView() {
        print("showAskForPointsView")
        guard !isAskForPointsTapped else { return }
        print("guard !isAskForPointsTapped passed")
        guard map.visibleAnnotations().count == 0 else {
            close()
            return
        }
        print("guard map.visibleAnnotations().count == 0 passed")
        guard askForPointsView.alpha != 1 else { return }
        print("guard askForPointsView.alpha != 1 passed")
        guard disabledGeolocationView.isHidden == true else { return }
        print("disabledGeolocationView.isHidden == true passed")
        
        askForPointsView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.askForPointsView.alpha = 1
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
        analytics.logPointTap()
        setBottomPosition()
        pinAnnotation.pointID = annotation.pointID
        pinAnnotation.setUp(trashTypes: annotation.types, coordinate: annotation.coordinate)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // That function is called only when map movement is complited.
        // If user zoomed out in area with more than 37km radius it will zoom in it back. (Depriciated)
        
        // Checking currentRadius was depriciated to allow people to zoom-out and make sure, that map is in working condition.
        if map.currentRadius(withDelta: 0) > 2000000 {
            let viewRegion = MKCoordinateRegion(center: self.map.region.center,
                                                latitudinalMeters: 1700000,
                                                longitudinalMeters: 1700000)
            map.setRegion(viewRegion, animated: true)
        } else {
//             Updateing geoPoints only in the allowed area.
        
            getGeoPoints()
            removeGeoPoints()
            checkReturnLocation()
        
        }
    }
    
}







extension MapView: bottomPinDelegate, askForPointsDelegate {
    func showImageShower(withImages images: [String], open: Int) {
        delegate?.showImageShower(withImages: images, open: open)
    }
    
    func showActivityController() {
        delegate?.showActivityController()
    }
    
    /// Close AskForPoints view
    func close() {
        print("close")
        guard askForPointsView.alpha != 0 else { return }
        UIView.animate(withDuration: 0.26, animations: {
            self.askForPointsView.alpha = 0
        }, completion: { _ in
            self.askForPointsView.isHidden = true
        })
    }
    
    func askForPoints(showAgain show: Bool) {
        isAskForPointsTapped = !show
        coreDatabase.addAskForPointStatus(latitude: map.centerCoordinate.latitude, longitude: map.centerCoordinate.longitude)
        server.createNewAskForPoints(coordinate: map.centerCoordinate, radius: map.currentRadius(withDelta: 0))
        analytics.logAskForPoints()
        close()
    }
}






extension MapView {
    private
    func setSubviews() {
        self.addSubview(map)
        self.addSubview(addPointView)
        self.addSubview(returnToPositionView)
        self.addSubview(paywallView)
        self.addSubview(pinAnnotation)
        self.addSubview(disabledGeolocationView)
        self.addSubview(askForPointsView)
        
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
        let askForPointsTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 82
            default: return 110
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
            
            disabledGeolocationView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            disabledGeolocationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            disabledGeolocationView.widthAnchor.constraint(equalToConstant: disabledGeolocationView.frame.width),
            disabledGeolocationView.heightAnchor.constraint(equalToConstant: disabledGeolocationView.frame.height),
            
            askForPointsView.topAnchor.constraint(equalTo: self.topAnchor, constant: askForPointsTopConstant),
            askForPointsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            askForPointsView.widthAnchor.constraint(equalToConstant: askForPointsView.frame.width),
            askForPointsView.heightAnchor.constraint(equalToConstant: askForPointsView.frame.height),
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
    
    private
    func removeAllUnvisibleAnnotations() {
        let visibleRect = map.visibleMapRect
        let inRectAnnotations = map.annotations(in: visibleRect)
        print("inRectAnnotations count: \(inRectAnnotations.count)")
        for annotation: MKAnnotation in map.annotations {
            if !(inRectAnnotations.contains(annotation as! AnyHashable)) {
                print("self.removeAnnotation(annotation): \(annotation)")
                map.removeAnnotation(annotation)
                
                if let annotation = annotation as? TrashBin {
                    self.trashBinsID.subtract([annotation.pointID ?? ""])
                }
            }
        }
    }
    
}
