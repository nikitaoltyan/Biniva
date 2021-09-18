//
//  BottomPinView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 22.05.2021.
//

import UIKit
import CoreLocation

class BottomPinView: UIView {
    
    let functions = MaterialFunctions()
    let server = Server()
    
    let topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 6))
            .with(bgColor: Colors.sliderGray)
            .with(cornerRadius: 3)
            .with(autolayout: false)
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 28)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_pin_title", comment: "Title for all points")
        return label
    }()
    
//    let activityButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
//            .with(autolayout: false)
//            .with(bgColor: .clear)
//        let image = UIImage(systemName: "pencil.circle")?.withRenderingMode(.alwaysTemplate)
//        button.contentHorizontalAlignment = .fill
//        button.contentVerticalAlignment = .fill
//        button.imageView?.contentMode = .scaleAspectFill
//        button.setImage(image, for: .normal)
//        button.tintColor = Colors.darkGrayText
//        button.alpha = 0
//        return button
//    }()
    
    let adressLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 20)
            .with(autolayout: false)
        label.text = "" // Creates automaticaly with coordinates.
        return label
    }()
    
    lazy var materialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 60)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
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
            .with(fontName: "SFPro-Medium", size: 20)
            .with(autolayout: false)
        label.text = NSLocalizedString("map_pin_photo", comment: "Photo title for all points")
        return label
    }()
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 190)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 8
        
        collection.isUserInteractionEnabled = true
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(ImagePinCell.self, forCellWithReuseIdentifier: "ImagePinCell")
        collection.register(ImagePinCell_Empty.self, forCellWithReuseIdentifier: "ImagePinCell_Empty")
        collection.tag = 1
        return collection
    }()
    
    var leftTitleConstraint: NSLayoutConstraint?
    var leftAdressConstraint: NSLayoutConstraint?
    var topAdressConstraint: NSLayoutConstraint?
    var types: [Int] = []
    var images: [String] = []
    var pointID: String?
    
    var isTouchedAlready: Bool = false
    var delegate: bottomPinDelegate?
    
//    enum buttonActivity {
//        case hide
//        case show
//    }
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 800)
        super.init(frame: useFrame)
        backgroundColor = Colors.background
        layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setUp(trashTypes types: [Int], coordinate: CLLocationCoordinate2D) {
        print("Set up with types: \(types) and coordinate: \(coordinate)")
        // Add here translation from coordinate into adress.
        // Then update label and collection view with materials.
        self.types = types
        materialCollection.reloadData()
        
        let geocoder = CLGeocoder()
        let usedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(usedLocation, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                self.adressLabel.text = firstLocation?.name
            } else {
                self.adressLabel.text = NSLocalizedString("map_pin_error", comment: "error")
            }
        })
    }

    func loadImages() {
        server.getImagesArray(forPointID: pointID, result: { (images) in
//            guard (images.count != 0) else { return }
            self.images = images
            self.photoCollection.reloadData()
        })
    }
    
    
//    func update(set status: buttonActivity) {
//        switch status {
//        case .show:
//            guard activityButton.isHidden == true else { return }
//            activityButton.isHidden = false
//            UIView.animate(withDuration: 0.2, animations: {
//                self.activityButton.alpha = 1
//            })
//        case .hide:
//            guard activityButton.isHidden == false else { return }
//            UIView.animate(withDuration: 0.2, animations: {
//                self.activityButton.alpha = 0
//            }, completion: { _ in
//                self.activityButton.isHidden = true
//            })
//        }
//    }
    
    @objc
    func activityAcrion() {
        delegate?.showActivityController()
    }
}




extension BottomPinView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return types.count
        default:
            if images.count > 0 {
                return images.count
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: 52, height: 52)
        default:
            if images.count > 0 {
                return CGSize(width: 140, height: 140)
            } else {
                return CGSize(width: MainConstants.screenWidth, height: 230)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = materialCollection.dequeueReusableCell(withReuseIdentifier: "MaterialPinCell", for: indexPath) as! MaterialPinCell
            cell.backgroundColor = functions.colorByRowValue(types[indexPath.row])
            let useImage: UIImage = functions.iconByRowValue(types[indexPath.row])
            let tintedImage = useImage.withRenderingMode(.alwaysTemplate)
            cell.image.image = tintedImage
            cell.image.tintColor = Colors.background
            cell.layer.cornerRadius = 26
            return cell
        default:
            if images.count > 0 {
                let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "ImagePinCell", for: indexPath) as! ImagePinCell
                DispatchQueue.main.async {
                    cell.image.downloadImage(from: self.images[indexPath.row])
                }
                return cell
            } else {
                let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "ImagePinCell_Empty", for: indexPath) as! ImagePinCell_Empty
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.tag == 1 else { return }
        delegate?.showImageShower(withImages: self.images, open: indexPath.row)
    }
    
}







extension BottomPinView {
    private
    func setSubviews(){
        self.addSubview(topView)
        self.addSubview(title)
//        self.addSubview(activityButton)
        self.addSubview(adressLabel)
        self.addSubview(materialCollection)
        self.addSubview(photoLabel)
        self.addSubview(photoCollection)
        
//        activityButton.addTarget(self, action: #selector(activityAcrion), for: .touchUpInside)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
     
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 19),
            
//            activityButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -19),
//            activityButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
//            activityButton.heightAnchor.constraint(equalToConstant: activityButton.frame.height),
//            activityButton.widthAnchor.constraint(equalToConstant: activityButton.frame.width),
            
            adressLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 7),
            adressLabel.leftAnchor.constraint(equalTo: title.leftAnchor),
            
            materialCollection.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 15),
            materialCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            materialCollection.heightAnchor.constraint(equalToConstant: materialCollection.frame.height),
            materialCollection.widthAnchor.constraint(equalToConstant: materialCollection.frame.width),
            
            photoLabel.topAnchor.constraint(equalTo: materialCollection.bottomAnchor, constant: 38),
            photoLabel.leftAnchor.constraint(equalTo: title.leftAnchor),
            
            photoCollection.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 10),
            photoCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoCollection.heightAnchor.constraint(equalToConstant: photoCollection.frame.height),
            photoCollection.widthAnchor.constraint(equalToConstant: photoCollection.frame.width),
        ])
    }
}
