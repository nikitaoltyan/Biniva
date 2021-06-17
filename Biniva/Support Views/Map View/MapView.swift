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
        view.isHidden = false // pinAnnotation is hidden due to development of clusterization.
        return view
    }()
    
    var pinAnnotationBottomConstraint: NSLayoutConstraint?
    
    var trashBins: [TrashBin] = []
    
    
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
    
    /// That function shows cordinates of all corners of the visible view.
    /// - returns: (topLeft, topRight, bottomLeft, bottomRight)
    func visibleMapBounds(forMap map: MKMapView) -> (CLLocationCoordinate2D,
                                                     CLLocationCoordinate2D,
                                                     CLLocationCoordinate2D,
                                                     CLLocationCoordinate2D) {
    
        // Just adding random annotations in the given area.
//        for i in 0...5 {
//            addAnnotation(minXminYlat: map.topLeftCoordinate.latitude,
//                          minXminYlong: map.topLeftCoordinate.longitude,
//                          maxXminYlong: map.topRightCoordinate.longitude,
//                          minXmaxYlat: map.bottomLeftCoordinate.latitude,
//                          type: i)
//        }

        return (map.topLeftCoordinate,
                map.topRightCoordinate,
                map.bottomLeftCoordinate,
                map.bottomRightCoordinate)
    }

    
    /// That function randoms position and adds annotation in the given area.
    func addAnnotation(minXminYlat: CLLocationDegrees,
                       minXminYlong: CLLocationDegrees,
                       maxXminYlong: CLLocationDegrees,
                       minXmaxYlat: CLLocationDegrees,
                       type: Int){
        
        // Add here checking for proper longitude-latitude direction – from lower to upper.
        let latitude = CLLocationDegrees.random(in: minXmaxYlat...minXminYlat)
        let longitude = CLLocationDegrees.random(in: minXminYlong...maxXminYlong)
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                longitude: longitude)
        
        let bin = TrashBin()
        bin.coordinate = coordinate
        
        switch type {
        case 0,2,4,6:
            bin.types.append(.paper)
        case 3,7,8,9:
            bin.types.append(.organic)
        default:
            bin.types.append(.glass)
        }
        
        self.trashBins.append(bin)
        
        DispatchQueue.main.async {
            self.map.addAnnotation(bin)
        }
    }
    
    
    @objc
    func draggedView(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(pinAnnotation)
        let translation = sender.translation(in: self)
        let centerCoordinate: CGFloat = MainConstants.screenHeight + pinAnnotation.frame.height/2
        let condition_1 = pinAnnotation.center.y <= centerCoordinate - 190
        let condition_2 = pinAnnotation.center.y >= centerCoordinate - 700
        if condition_1 && condition_2 {
            pinAnnotation.center = CGPoint(x: pinAnnotation.center.x,
                                           y: pinAnnotation.center.y + translation.y)
        } else {
            setRightPosition(centerCoordinate)
        }
        sender.setTranslation(CGPoint.zero, in: self)
        
        if (sender.state == .ended) {
            setRightPosition(centerCoordinate)
        }
    }
    
    func setRightPosition(_ centerCoordinate: CGFloat){
        let middle: CGFloat = (190.0 + 500.0)/2.0
        switch centerCoordinate-pinAnnotation.center.y {
        case 0...middle:
            setBottomPosition(centerCoordinate)
        default:
            setTopPosition(centerCoordinate)
        }
    }
    
    func setBottomPosition(_ centerCoordinate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: centerCoordinate-190)
        })
    }
    
    func setTopPosition(_ centerCoordinate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: centerCoordinate-500)
        })
    }
    
    @objc
    func annotationTapped(_ sender: UITapGestureRecognizer) {
        print("Annotation Tapped")
        let _ = visibleMapBounds(forMap: map)
    }
    
    @objc
    func test(){
        print(map.region.center)
//        let _ = visibleMapBounds(forMap: map)
//        map.removeAnnotations(self.trashBins)
//        server.getGeoPoints(centerCoordinate: CLLocationCoordinate2D(latitude: 55.794, longitude: 37.929), radius: 30000)
    }
    
    func loadPoints() {
        print("Load points")
//        print(self.window)
//        guard (self.window != nil) else { return }
//        let (topLeftCoordinate, topRightCoordinate,
//             bottomLeftCoordinate, _) = visibleMapBounds(forMap: map)
//        server.loadPoints(minXminYlat: topLeftCoordinate.latitude,
//                          minXminYlong: topLeftCoordinate.longitude,
//                          maxXminYlong: topRightCoordinate.longitude,
//                          minXmaxYlat: bottomLeftCoordinate.latitude)
    }
}






extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? TrashBin else { return nil }
        let view = DefaultAnnotationView(annotation: annotation, reuseIdentifier: DefaultAnnotationView.ReuseID)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(annotationTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
}






extension MapView{
    func setSubviews(){
        self.addSubview(map)
        self.addSubview(pinAnnotation)
        
        pinAnnotation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(test)))
//        pinAnnotation.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:))))
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.topAnchor),
            map.leftAnchor.constraint(equalTo: self.leftAnchor),
            map.rightAnchor.constraint(equalTo: self.rightAnchor),
            map.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pinAnnotation.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -190),
            pinAnnotation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pinAnnotation.widthAnchor.constraint(equalToConstant: pinAnnotation.frame.width),
            pinAnnotation.heightAnchor.constraint(equalToConstant: pinAnnotation.frame.height)
        ])
//        pinAnnotationBottomConstraint = pinAnnotation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 330)
//        pinAnnotationBottomConstraint?.isActive = true
    }
}



class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
    
}
