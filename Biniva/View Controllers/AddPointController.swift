//
//  AddPointController.swift
//  Biniva
//
//  Created by Nick Oltyan on 27.06.2021.
//

import UIKit
import MapKit
import CoreLocation

class AddPointController: UIViewController {

    let functions = MaterialFunctions()
    let analytics = ServerAnalytics()
    let locationManager = CLLocationManager()
    let server = Server()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 940)
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let mainTitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 28)
            .with(autolayout: false)
        label.text = NSLocalizedString("add_point_title", comment: "title for whole view")
        return label
    }()
    
    let map: MKMapView = {
        let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 300, height: 330))
            .with(autolayout: false)
            .with(cornerRadius: 13)
        map.isUserInteractionEnabled = true
        map.showsTraffic = false

        // There should be user's coordinate.
        let coordinate = CLLocationCoordinate2D(latitude: 55.794698, longitude: 37.929111)
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
        map.setRegion(viewRegion, animated: false)
        
        return map
    }()
    
    let adressLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 20)
            .with(autolayout: false)
        label.text = NSLocalizedString("add_point_map_start_position", comment: "defining that adress wasn't setted") // Then this text is changing into choosed adress.
        return label
    }()
    
    let materialsLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 23)
            .with(autolayout: false)
        label.text = NSLocalizedString("add_point_choose_materials", comment: "Ask about materials thet can be recycled")
        return label
    }()
    
    lazy var materialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 60)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        collection.isUserInteractionEnabled = true
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(MaterialPinCell.self, forCellWithReuseIdentifier: "MaterialPinCell")
        collection.tag = 0
        return collection
    }()
    
    let photoLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 23)
            .with(autolayout: false)
        label.text = NSLocalizedString("add_point_add_photo", comment: "Ask for adding photos")
        return label
    }()
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 190)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 8
        
        collection.isUserInteractionEnabled = true
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(TakePhotoCell.self, forCellWithReuseIdentifier: "TakePhotoCell")
        collection.register(ImagePinCell.self, forCellWithReuseIdentifier: "ImagePinCell")
        collection.tag = 1
        return collection
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    var currentAnnotation: MKPointAnnotation?
    
    var settedLocation: CLLocationCoordinate2D?
    var uploadedImages: [UIImage?] = []
    var selectedMaterials: Set<Int> = []
    
    var delegate: mapDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        setUserLocation()
    }
    
    func setUserLocation() {
        map.showsUserLocation = true
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            let location: CLLocationCoordinate2D = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.754316, longitude: 37.619521) // Cremlin I guess
            let span = MKCoordinateSpan(latitudeDelta: 0.003,
                                        longitudeDelta: 0.003) // Around 300x300 meters
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
        }
    }
    
    @objc
    func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: map)
        let coordinate = map.convert(location, toCoordinateFrom: map)
        settedLocation = coordinate
        
        // Remove last setted Pin.
        map.removeAnnotations(map.annotations)
        
        currentAnnotation = MKPointAnnotation()
        currentAnnotation?.coordinate = coordinate
        map.addAnnotation(currentAnnotation!)
        
        let geocoder = CLGeocoder()
        let usedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(usedLocation, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self.adressLabel.text = firstLocation?.name
            } else {
                self.adressLabel.text = NSLocalizedString("add_point_map_error", comment: "Special error when it can't get adtress. Asking for retry.")
            }
        })

    }
    
    func showImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }

    
    @objc
    func add(){
        guard (settedLocation != nil) else {
            showAlert(withTitle: NSLocalizedString("add_point_adress_alert_title", comment: "title for add location alert"),
                      andSubtitle: NSLocalizedString("add_point_adress_alert_subtitle",
                                                     comment: "subtitle for add location alert"))
            return
        }
        guard (selectedMaterials.count > 0) else {
            showAlert(withTitle: NSLocalizedString("add_point_materials_alert_title",
                                                   comment: "title for add materials alert"),
                      andSubtitle: NSLocalizedString("add_point_materials_alert_subtitle",
                                                     comment: "subtitle for add materials alert"))
            return
        }
        
//        Commented it because of some distant points adding without photos.
//        guard (uploadedImages.count > 0) else {
//            showAlert(withTitle: "Не загружены фото", andSubtitle: "Пожалуйста, загрузи фото места переработки. Это поможет другим пользователям проще найти это место.")
//            return
//        }
        
        print("Guard passed. Add new Point.")
        DispatchQueue.main.async {
            self.server.createNewPoint(forCoorinate: self.settedLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                       withMaterials: Array(self.selectedMaterials),
                                       andImages: self.uploadedImages)
        }
        analytics.logAddPoint()
        button.tap(completion: { (_) in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.showPopUp(title: NSLocalizedString("add_point_added_title", comment: "Title for added points Pop Up"),
                                    subtitle: NSLocalizedString("add_point_added_desc", comment: "Description for added points Pop Up"),
                                    andButtonText: NSLocalizedString("add_point_added_button", comment: "button title"))
        })
    }
    
    
    func showAlert(withTitle title: String, andSubtitle subtitle: String) {
        let alert = prepareAlert(withTitle: title,
                                 andSubtitle: subtitle,
                                 closeAction: NSLocalizedString("add_point_close_alert", comment: "Ask for change everything"))
        present(alert, animated: true, completion: nil)
    }
}




extension AddPointController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let choosedImage = info[.editedImage] as? UIImage
        uploadedImages.append(choosedImage)
        photoCollection.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}





extension AddPointController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return materials.name.count
        default:
            switch uploadedImages.count {
            case 0:
                return 1
            case 4...:
                return 4
            default:
                return uploadedImages.count+1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: 52, height: 52)
        default:
            return CGSize(width: 140, height: 140)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = materialCollection.dequeueReusableCell(withReuseIdentifier: "MaterialPinCell", for: indexPath) as! MaterialPinCell
            cell.backgroundColor = functions.colorByRowValue(indexPath.row)
            let useImage: UIImage = functions.iconByRowValue(indexPath.row)
            let tintedImage = useImage.withRenderingMode(.alwaysTemplate)
            cell.image.image = tintedImage
            cell.image.tintColor = Colors.background
            cell.layer.cornerRadius = 26
            return cell
            
        default:
            switch uploadedImages.count {
            case 0:
                let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "TakePhotoCell", for: indexPath) as! TakePhotoCell
                return cell
            case 4...:
                let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "ImagePinCell", for: indexPath) as! ImagePinCell
                cell.image.image = uploadedImages[indexPath.row]
                return cell
            default:
                if indexPath.row == 0 {
                    let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "TakePhotoCell", for: indexPath) as! TakePhotoCell
                    return cell
                } else {
                    let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "ImagePinCell", for: indexPath) as! ImagePinCell
                    cell.image.image = uploadedImages[indexPath.row-1]
                    return cell
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if (uploadedImages.count < 5) && (collectionView.tag == 1) && (indexPath.row == 0) {
            showImagePicker()
        }
        
        guard collectionView.tag == 0 else { return }
        if let cell = materialCollection.cellForItem(at: indexPath) as? MaterialPinCell {
            guard (cell.layer.borderWidth == 0) else {
                selectedMaterials.remove(indexPath.row)
                cell.layer.borderWidth = 0
                return
            }
            
            selectedMaterials.insert(indexPath.row)
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = Colors.bottomGradient.cgColor
        }
    }
}





extension AddPointController {
    func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(map)
        scrollView.addSubview(adressLabel)
        scrollView.addSubview(materialsLabel)
        scrollView.addSubview(materialCollection)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(photoCollection)
        scrollView.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(add)))
        map.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:))))
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 26),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            map.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 18),
            map.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 29),
            map.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -29),
            map.heightAnchor.constraint(equalToConstant: map.frame.height),
            
            adressLabel.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 18),
            adressLabel.leftAnchor.constraint(equalTo: map.leftAnchor),
            
            materialsLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 44),
            materialsLabel.leftAnchor.constraint(equalTo: map.leftAnchor),
            
            materialCollection.topAnchor.constraint(equalTo: materialsLabel.bottomAnchor, constant: 6),
            materialCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            materialCollection.heightAnchor.constraint(equalToConstant: materialCollection.frame.height),
            materialCollection.widthAnchor.constraint(equalToConstant: materialCollection.frame.width),
            
            photoLabel.topAnchor.constraint(equalTo: materialCollection.bottomAnchor, constant: 30),
            photoLabel.leftAnchor.constraint(equalTo: map.leftAnchor),
            
            photoCollection.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 6),
            photoCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: photoCollection.frame.height),
            photoCollection.widthAnchor.constraint(equalToConstant: photoCollection.frame.width),
            
            button.topAnchor.constraint(equalTo: photoCollection.bottomAnchor, constant: 25),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height)
        ])
    }
}
