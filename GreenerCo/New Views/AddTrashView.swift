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
    var useCase: material?
    var titles: Array<String>?
    var subtitles: Array<String>?
    var weights: Array<Int>?
    

    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 530)
        super.init(frame: useFrame)
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func populate(){
        switch useCase {
        case .plastic:
            titles = plastic.title
            subtitles = plastic.subtitle
            weights = plastic.weight
        case .organic:
            titles = organic.title
            subtitles = organic.subtitle
            weights = organic.weight
        case .paper:
            titles = paper.title
            subtitles = paper.subtitle
            weights = paper.weight
        case .metal:
            titles = metal.title
            subtitles = metal.subtitle
            weights = metal.weight
        case .wood:
            titles = wood.title
            subtitles = wood.subtitle
            weights = wood.weight
        default:
            titles = fabric.title
            subtitles = fabric.subtitle
            weights = fabric.weight
        }
        collection.reloadData()
    }
}




extension AddTrashView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.width/2-4, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ExtraAddCell", for: indexPath) as! ExtraAddCell
        cell.title.text = titles?[indexPath.row] ?? "Title"
        cell.subtitle.text = subtitles?[indexPath.row] ?? "Title"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? ExtraAddCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? ExtraAddCell {
            cell.select()
            weightView.textView.text = "\(weights?[indexPath.row] ?? 0) г"
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
