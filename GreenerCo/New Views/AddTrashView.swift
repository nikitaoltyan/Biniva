//
//  AddTrashView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 21.04.2021.
//

import UIKit

class AddTrashView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 28)
            .with(autolayout: false)
        label.text = "Пластик"
        return label
    }()
    
    let weightView: WeightView = {
        let view = WeightView()
            .with(autolayout: false)
        return view
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: 410)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(autolayout: false)
            .with(bgColor: .clear)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 1
        
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(ExtraAddCell.self, forCellWithReuseIdentifier: "ExtraAddCell")
        return collection
    }()
    
    var currentSelectedIndexPath: IndexPath?
    

    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 530)
        super.init(frame: useFrame)
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}




extension AddTrashView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.width/2-4, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ExtraAddCell", for: indexPath) as! ExtraAddCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? ExtraAddCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? ExtraAddCell {
            cell.select()
            currentSelectedIndexPath = indexPath
        }
    }
}




extension AddTrashView {
    func SetSubviews(){
        self.addSubview(title)
        self.addSubview(weightView)
        self.addSubview(collection)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            weightView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            weightView.widthAnchor.constraint(equalToConstant: weightView.frame.width),
            weightView.heightAnchor.constraint(equalToConstant: weightView.frame.height),
            
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collection.widthAnchor.constraint(equalToConstant: collection.frame.width),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height)
        ])
    }
}
