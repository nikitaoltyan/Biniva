//
//  BottomPinView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 22.05.2021.
//

import UIKit

class BottomPinView: UIView {
    
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
        label.text = "Контейнер"
        return label
    }()
    
    let adressLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 20)
            .with(autolayout: false)
        label.text = "Sans Str. 19"
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
        label.text = "Фото"
        return label
    }()
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 200)
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
        collection.register(MaterialPinCell.self, forCellWithReuseIdentifier: "MaterialPinCell")
        collection.tag = 1
        return collection
    }()
    
    var leftTitleConstraint: NSLayoutConstraint?
    var leftAdressConstraint: NSLayoutConstraint?
    var topAdressConstraint: NSLayoutConstraint?
    
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

}




extension BottomPinView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 8
        default:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: 52, height: 52)
        default:
            return CGSize(width: 95, height: 95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = materialCollection.dequeueReusableCell(withReuseIdentifier: "MaterialPinCell", for: indexPath) as! MaterialPinCell
            cell.layer.cornerRadius = 26
            return cell
        default:
            let cell = materialCollection.dequeueReusableCell(withReuseIdentifier: "MaterialPinCell", for: indexPath) as! MaterialPinCell
            cell.backgroundColor = .gray
            return cell
        }
    }
    
    
}




extension BottomPinView {
    func setSubviews(){
        self.addSubview(topView)
        self.addSubview(title)
        self.addSubview(adressLabel)
        self.addSubview(materialCollection)
        self.addSubview(photoLabel)
        self.addSubview(photoCollection)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
     
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 19),
            
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