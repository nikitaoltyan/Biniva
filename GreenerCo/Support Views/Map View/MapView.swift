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
        map.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 55.794698, longitude: 37.929111)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
        let label = Capital(title: "Title", coordinate: coordinate, info: "Info")
        map.addAnnotation(label)
        map.setRegion(viewRegion, animated: false)
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
    
    private var currentState: AnnotationState = .closed
    private var runningAnimators = [UIViewPropertyAnimator]()
    private var animationProgress = [CGFloat]()
    
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

    
    @objc
    func draggedView(_ sender:UIPanGestureRecognizer){
        self.bringSubviewToFront(pinAnnotation)
        let translation = sender.translation(in: self)
        let centerCoordinate: CGFloat = MainConstants.screenHeight + pinAnnotation.frame.height/2
        let condition_1 = pinAnnotation.center.y <= centerCoordinate - 170
        let condition_2 = pinAnnotation.center.y >= centerCoordinate - 500
        if condition_1 && condition_2 {
            pinAnnotation.center = CGPoint(x: pinAnnotation.center.x, y: pinAnnotation.center.y + translation.y)
        } else {
            setRightPosition(centerCoordinate)
        }
        sender.setTranslation(CGPoint.zero, in: self)
        
        if (sender.state == .ended) {
            print("draging ended")
            setRightPosition(centerCoordinate)
        }
    }
    
    func setRightPosition(_ centerCoordinate: CGFloat){
        let middle: CGFloat = (170.0 + 500.0)/2.0
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
                                                y: centerCoordinate-170)
        })
    }
    
    func setTopPosition(_ centerCoordinate: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.pinAnnotation.center = CGPoint(x: self.pinAnnotation.center.x,
                                                y: centerCoordinate-500)
        })
    }
}






extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = CustomPin(annotation: annotation, reuseIdentifier: "")
        return annotation
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
            
            pinAnnotation.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -170),
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
