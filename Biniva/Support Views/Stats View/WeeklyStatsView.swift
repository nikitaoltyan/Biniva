//
//  WeeklyStatsView.swift
//  Biniva
//
//  Created by Nick Oltyan on 11.08.2021.
//

import UIKit


class WeeklyStatsView: UIView {

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
        collection.register(WeeklyStatsCell.self, forCellWithReuseIdentifier: "WeeklyStatsCell")
        collection.register(WeeklyStatsCell_Empty.self, forCellWithReuseIdentifier: "WeeklyStatsCell_Empty")
        collection.register(WeeklyStatsCell_Unsubscribed.self, forCellWithReuseIdentifier: "WeeklyStatsCell_Unsubscribed")
        return collection
    }()
    
    let weeklySubtitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.bottomGradient)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 19)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_weekly_subtitle", comment: "Title for weekly plate")
        label.isHidden = true
        return label
    }()

    var data: Array<(Int, Double, direction)> = []
    var heightFunction: ((Double) -> (CGFloat))?

    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 50, height: 230)
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
        guard Defaults.getIsSubscribed() else { return } // Do not calculate if user is unsubscribed
        
        data = materialFunction.calculateWeekly()
        if data.count > 0 {
            let (material, percentage, _) = data[0]
            heightFunction = materialFunction.weeklyHeightFunction(maxPercentage: percentage)
            weeklySubtitle.textColor = materialFunction.colorByRowValue(material)
            weeklySubtitle.isHidden = false
        }
        collection.reloadData()
    }
    
}






extension WeeklyStatsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: self.frame.width, height: 195)
        default:
            return CGSize(width: 75, height: 195)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data.count {
        case 0, nil:
            if Defaults.getIsSubscribed() {
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "WeeklyStatsCell_Empty", for: indexPath) as! WeeklyStatsCell_Empty
                return cell
            } else {
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "WeeklyStatsCell_Unsubscribed", for: indexPath) as! WeeklyStatsCell_Unsubscribed
                return cell
            }
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "WeeklyStatsCell", for: indexPath) as! WeeklyStatsCell
            let (id, percent, direction) = data[indexPath.row]
            if percent > 0 {
                cell.updateHeight(height: heightFunction!(percent))
            } else {
                cell.updateHeight(height: heightFunction!(0))
            }
            cell.updateMaterial(id: id)
            cell.updateArrow(direction: direction)
            cell.percent.text = "\(Int(percent*100))%"
            return cell
        }
    }
}






extension WeeklyStatsView{
    func setSubviews(){
        self.layer.addSublayer(gradient)
        self.addSubview(collection)
        self.addSubview(weeklySubtitle)
    }
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            collection.leftAnchor.constraint(equalTo: self.leftAnchor),
            collection.rightAnchor.constraint(equalTo: self.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height),
            
            weeklySubtitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            weeklySubtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22)
        ])
    }
}
