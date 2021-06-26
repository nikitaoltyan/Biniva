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
    
    var pinAnnotationBottomConstraint: NSLayoutConstraint?
    var centerCoordinate: CGFloat = 0
    
//    var trashBins: [TrashBin] = []
    var trashBinsID: Set<String> = []
    
    
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

    
    /// That function randoms position and adds annotation in the given area.
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

            // Why should I store them?
//            trashBins.append(bin)
            
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
        UIView.animate(withDuration: 0.1, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate)
        })
    }
    
    func setBottomPosition() {
        print("Set bottom position: \(centerCoordinate)")
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: self.centerCoordinate-190)
        }, completion: { (_) in
            Vibration.soft()
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
    
    @objc
    func annotationTapped(_ sender: UITapGestureRecognizer) {
        setBottomPosition()
    }
    
    func getGeoPoints(){

        
        coreDatabase.getPointsInArea(topLeftX: map.topLeftCoordinate.longitude,
                                     topRightX: map.topRightCoordinate.longitude,
                                     topLeftY: map.topLeftCoordinate.latitude,
                                     bottomLeftY: map.bottomLeftCoordinate.latitude,
                                     result: { (points) in
                                        
            self.addAnnotation(points: points)
                                        
            print("Dispatch async queue.")
            DispatchQueue.main.async {
                self.server.getGeoPoints(centerCoordinate: self.map.region.center,
                                         radius: self.map.currentRadius(withDelta: 0),
                                         notItPoints: points, result: { (serverPoint) in
                    
                })
            }
        })
        
//        server.getGeoPoints(centerCoordinate: map.region.center,
//                            radius: map.currentRadius(withDelta: 0), result: { result in
//            guard (result) else { return }
//            let points: [Points] = self.coreDatabase.fetchData()
//            self.addAnnotation(points: points)
//        })
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(annotationTapped(_:)))
        view.addGestureRecognizer(gesture)
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
        
        pinAnnotation.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
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
            pinAnnotation.heightAnchor.constraint(equalToConstant: pinAnnotation.frame.height)
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
