//
//  AskForPointCell.swift
//  Biniva
//
//  Created by Ncik Oltyan on 02.09.2021.
//

import UIKit
import CoreLocation
import MapKit

class AskForPointCell: UITableViewCell {

    let adressLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Semibold", size: 14)
        return label
    }()
    
    let map: MKMapView = {
        let map = MKMapView()
            .with(autolayout: false)
            .with(cornerRadius: 15)
        map.isUserInteractionEnabled = false
        map.showsTraffic = false
        
        return map
    }()
    
    let statusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
            .with(autolayout: false)
            .with(cornerRadius: 10)
        button.titleLabel?.font = UIFont(name: "SFPro", size: 18)
        button.setTitleColor(Colors.background, for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func update(latitude: Double, longitude: Double, status: Bool) {
        let geocoder = CLGeocoder()
        let usedLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(usedLocation, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self.adressLabel.text = firstLocation?.name
            } else {
                self.adressLabel.text = NSLocalizedString("add_point_map_error", comment: "Special error when it can't get adtress. Asking for retry.")
            }
        })
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        map.setRegion(viewRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
        if status {
            statusButton.backgroundColor = Colors.topGradient
            statusButton.setTitle(NSLocalizedString("ask_for_points_added", comment: ""), for: .normal)
        } else {
            statusButton.backgroundColor = Colors.askForPointInWork
            statusButton.setTitle(NSLocalizedString("ask_for_points_in_process", comment: ""), for: .normal)
        }
    }
}






extension AskForPointCell {
    private
    func setSubviews() {
        self.addSubview(adressLabel)
        self.addSubview(statusButton)
        self.addSubview(map)
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            statusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            statusButton.heightAnchor.constraint(equalToConstant: statusButton.frame.height),
            statusButton.widthAnchor.constraint(equalToConstant: statusButton.frame.width),
            
            adressLabel.centerYAnchor.constraint(equalTo: statusButton.centerYAnchor),
            adressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            adressLabel.rightAnchor.constraint(equalTo: statusButton.leftAnchor, constant: -10),
            
            map.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -15),
            map.rightAnchor.constraint(equalTo: statusButton.rightAnchor),
            map.leftAnchor.constraint(equalTo: adressLabel.leftAnchor),
            map.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
}
