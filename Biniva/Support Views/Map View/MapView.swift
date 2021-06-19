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

    
    /// That function randoms position and adds annotation in the given area.
    func addAnnotation(points: [Points]) {
        for point in points {
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
            
            self.trashBins.append(bin)
            
            DispatchQueue.main.async {
                self.map.addAnnotation(bin)
            }
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
    }
    
    @objc
    func test(){
        server.getGeoPoints(centerCoordinate: map.region.center, radius: 10000, result: { result in
            guard (result) else { return }
            let points: [Points] = self.coreDatabase.fetchData()
            self.addAnnotation(points: points)
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
