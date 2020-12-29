//
//  MeetingCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 12.11.2020.
//

import UIKit
import MapKit
import CoreLocation

class MeetingCell: UICollectionViewCell {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let meetingLocation: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 15
        map.isUserInteractionEnabled = false
        let coordinate = CLLocationCoordinate2D(latitude: 55.740897, longitude: 37.598034)
        let london = Capital(title: "Остоженка", coordinate: coordinate, info: "Home to the 2012 Summer Olympics.")
        map.addAnnotation(london)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 900, longitudinalMeters: 900)
        map.setRegion(viewRegion, animated: false)
        return map
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "Icon-1024")
        image.layer.masksToBounds = true
        return image
    }()
    
    let profileName: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "nikitaoltyan"
        label.font = UIFont.init(name: "SFPro-Bold", size: 19.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let street: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Остоженка, 15"
        label.font = UIFont.init(name: "SFPro-Medium", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let time: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "1 November, 16:54"
        label.font = UIFont.init(name: "SFPro-Medium", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Some big custome description. Some big custome description. Some big custome description. Some big custome description. Some big custome description. Some big custome description."
        label.font = UIFont.init(name: "SFPro", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let checkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  MainConstants.green
        view.layer.cornerRadius = 50/2
        return view
    }()
    
    let checkImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "checkmark.seal")
        image.tintColor = MainConstants.white
        return image
    }()
    
    let locationManager = CLLocationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ActivateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ActivateConstraints(){
        let width = MainConstants.screenWidth-40
        let height = 245 as CGFloat
        let scale = 25 as CGFloat
        mainView.frame.size = CGSize(width: MainConstants.screenWidth-40, height: height)
        profileImage.layer.cornerRadius = scale/2
        
        self.addSubview(mainView)
        mainView.addSubview(meetingLocation)
        mainView.addSubview(profileImage)
        mainView.addSubview(profileName)
        mainView.addSubview(street)
        mainView.addSubview(time)
        mainView.addSubview(desc)
        mainView.addSubview(checkView)
        checkView.addSubview(checkImage)
        
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainView.widthAnchor.constraint(equalToConstant: width),
            mainView.heightAnchor.constraint(equalToConstant: height),
            
            meetingLocation.leftAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 20),
            meetingLocation.topAnchor.constraint(equalTo: mainView.topAnchor),
            meetingLocation.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            meetingLocation.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            profileImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            profileImage.heightAnchor.constraint(equalToConstant: scale),
            profileImage.widthAnchor.constraint(equalToConstant: scale),
            
            profileName.topAnchor.constraint(equalTo: profileImage.topAnchor),
            profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
            profileName.heightAnchor.constraint(equalToConstant: 23),
            profileName.widthAnchor.constraint(equalToConstant: 150),
            
            street.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
            street.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            street.heightAnchor.constraint(equalToConstant: 23),
            street.widthAnchor.constraint(equalToConstant: 150),
            
            time.topAnchor.constraint(equalTo: street.bottomAnchor),
            time.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            time.heightAnchor.constraint(equalToConstant: 23),
            time.widthAnchor.constraint(equalToConstant: 150),
            
            desc.topAnchor.constraint(equalTo: time.bottomAnchor),
            desc.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            desc.rightAnchor.constraint(equalTo: meetingLocation.leftAnchor, constant: -10),
            desc.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            
            checkView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            checkView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            checkView.heightAnchor.constraint(equalToConstant: 50),
            checkView.widthAnchor.constraint(equalToConstant: 50),
            
            checkImage.centerYAnchor.constraint(equalTo: checkView.centerYAnchor),
            checkImage.centerXAnchor.constraint(equalTo: checkView.centerXAnchor),
            checkImage.heightAnchor.constraint(equalToConstant: 35),
            checkImage.widthAnchor.constraint(equalToConstant: 35)
        ])
        NSLayoutConstraint.activate(const)
    }
}

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
