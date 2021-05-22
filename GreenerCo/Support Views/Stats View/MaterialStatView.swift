//
//  MaterialStatView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 17.05.2021.
//

import UIKit

class MaterialStatView: UIView {
    
    let materialFunction = MaterialFunctions()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.3)
        return gradient
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-50)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(MaterialStatsCell.self, forCellWithReuseIdentifier: "MaterialStatsCell")
        collection.register(MaterialStatsCell_Empty.self, forCellWithReuseIdentifier: "MaterialStatsCell_Empty")
        return collection
    }()

    var data: Array<(Int, Double)> = []
    var heightFunction: ((Double) -> (CGFloat))?

    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 185)
        super.init(frame: useFrame)
        self.layer.cornerRadius = 30
        setSubviews()
        activateLayouts()
        update()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func update(){
        data = materialFunction.calculate()
        if data.count > 0 {
            let (_, weight) = data[0]
            heightFunction = materialFunction.statsHeightFunction(maxProportion: weight)
        }
        collection.reloadData()
    }
}




extension MaterialStatView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch data.count {
        case 0, nil:
            return 1
        default:
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch data.count {
        case 0, nil:
            return CGSize(width: self.frame.width, height: 150)
        default:
            return CGSize(width: 80, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data.count {
        case 0, nil:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "MaterialStatsCell_Empty", for: indexPath) as! MaterialStatsCell_Empty
            return cell
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "MaterialStatsCell", for: indexPath) as! MaterialStatsCell
            let (id, percent) = data[indexPath.row]
            print(heightFunction!(percent))
            cell.updateHeight(height: heightFunction!(percent))
            cell.updateMaterial(id: id)
            cell.percent.text = "\(Int(percent*100))%"
            return cell
        }
    }
}





extension MaterialStatView{
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(collection)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            collection.leftAnchor.constraint(equalTo: self.leftAnchor),
            collection.rightAnchor.constraint(equalTo: self.rightAnchor),
            collection.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height)
        ])
    }
}
