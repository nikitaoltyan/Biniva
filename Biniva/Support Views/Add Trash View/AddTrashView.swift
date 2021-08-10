//
//  AddTrashView.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 21.04.2021.
//

import UIKit

class AddTrashView: UIView {
    
    let materialDefaults = MaterialDefaults()
    let measure = Measure()
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 24)
            .with(autolayout: false)
        return label
    }()
    
    let weightView: WeightView = {
        let view = WeightView()
            .with(autolayout: false)
        view.isHidden = (Defaults.getWeightSystem() != 0) // Returns false when metric (0)
        return view
    }()
    
    let weightViewImperial: WeightViewImperial = {
        let view = WeightViewImperial()
            .with(autolayout: false)
        view.isHidden = (Defaults.getWeightSystem() != 1) // Returns false when imperial (1)
        return view
    }()
    
    lazy var collection: UICollectionView = {
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 390 }
            else { return 350 }
        }()
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth*0.86, height: height)
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
        let height: CGFloat = {
            if MainConstants.screenHeight > 700 { return 530 }
            else { return 400 }
        }()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: height)
        super.init(frame: useFrame)
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func populate(){
        guard let material = useCase else { return }
        (titles, subtitles, weights) = materialDefaults.getMaterialData(material: material)
        collection.reloadData()
    }
}




extension AddTrashView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch MainConstants.screenHeight {
        case 736: return CGSize(width: self.collection.frame.width/2-12, height: 100)
        case 700...735, 737...: return CGSize(width: self.collection.frame.width/2-4, height: 115)
        default: return CGSize(width: self.collection.frame.width/3-6, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ExtraAddCell", for: indexPath) as! ExtraAddCell
        cell.title.text = titles?[indexPath.row] ?? "Title"
        cell.subtitle.text = subtitles?[indexPath.row] ?? "Title"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = collection.cellForItem(at: currentSelectedIndexPath ?? indexPath) as? ExtraAddCell {
            cell.unselect()
        }
        
        if let cell = collection.cellForItem(at: indexPath) as? ExtraAddCell {
            cell.select()
        
            let weight: Int = weights?[indexPath.row] ?? 0
            switch Defaults.getWeightSystem() {
            case 0: // Metric
                let weightSymbol: String = NSLocalizedString("weight_measurement_gramms", comment: "localized gramms symbol")
                weightView.textView.text = "\(weight) \(weightSymbol)"
            default: //Imperial
                let weightSymbol: String = NSLocalizedString("weight_measurement_ounces", comment: "localized ounces symbol")
                let oz: Double = measure.getOzForGramms(gramms: weight)
                weightViewImperial.textView.text = "\(oz) \(weightSymbol)"
                weightViewImperial.currentNumber = oz
            }
            currentSelectedIndexPath = indexPath
        }
    }
}




extension AddTrashView {
    func SetSubviews(){
        self.addSubview(title)
        self.addSubview(weightView)
        self.addSubview(weightViewImperial)
        self.addSubview(collection)
    }
    
    func ActivateLayouts(){
        let titleTopConst: CGFloat = {
            if MainConstants.screenHeight > 700 { return 5 }
            else { return 0 }
        }()
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: titleTopConst),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            weightView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            weightView.widthAnchor.constraint(equalToConstant: weightView.frame.width),
            weightView.heightAnchor.constraint(equalToConstant: weightView.frame.height),
            
            weightViewImperial.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightViewImperial.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            weightViewImperial.widthAnchor.constraint(equalToConstant: weightViewImperial.frame.width),
            weightViewImperial.heightAnchor.constraint(equalToConstant: weightViewImperial.frame.height),
            
            collection.topAnchor.constraint(equalTo: weightView.bottomAnchor, constant: 40),
            collection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collection.widthAnchor.constraint(equalToConstant: collection.frame.width),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height)
        ])
    }
}
