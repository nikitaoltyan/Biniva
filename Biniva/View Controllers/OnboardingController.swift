//
//  OnboardingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.01.2021.
//

import UIKit

protocol OnbordingDelegate {
    func next(slide: Int)
    func finish()
}

class OnboardingController: UIViewController {
    
    let analytics = ServerAnalytics()
    let userDefaults = Defaults()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            .with(autolayout: false)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.isPagingEnabled = false
        collection.isScrollEnabled = false
        collection.backgroundColor = Colors.background
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(Onboarding_1_Cell.self, forCellWithReuseIdentifier: "Onboarding_1_Cell")
        collection.register(Onboarding_2_Cell.self, forCellWithReuseIdentifier: "Onboarding_2_Cell")
        collection.register(Onboarding_3_Cell.self, forCellWithReuseIdentifier: "Onboarding_3_Cell")
        collection.register(Onboarding_4_Cell.self, forCellWithReuseIdentifier: "Onboarding_4_Cell")
        collection.register(Onboarding_5_Cell.self, forCellWithReuseIdentifier: "Onboarding_5_Cell")
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        setSubviews()
        activateLayouts()
        analytics.logStartOnboarding()
    }
}





extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth, height: MainConstants.screenHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_1_Cell", for: indexPath) as! Onboarding_1_Cell
            cell.delegate = self
            return cell
        case 1:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_2_Cell", for: indexPath) as! Onboarding_2_Cell
            cell.delegate = self
            return cell
        case 2:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_3_Cell", for: indexPath) as! Onboarding_3_Cell
            cell.delegate = self
            return cell
        case 3:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_4_Cell", for: indexPath) as! Onboarding_4_Cell
            cell.delegate = self
            return cell
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "Onboarding_5_Cell", for: indexPath) as! Onboarding_5_Cell
            cell.delegate = self
            return cell
        }
    }
    
}





extension OnboardingController: OnbordingDelegate {

    func next(slide: Int) {
        Vibration.soft()
        collection.isPagingEnabled = true
        let indexPath = IndexPath(item: slide, section: 0)
        collection.scrollToItem(at: indexPath, at: .right, animated: true)
        collection.isPagingEnabled = false
        collection.reloadItems(at: [IndexPath(item: slide, section: 0)])
    }
    
    func finish() {
        analytics.logFinishOnboarding()
        userDefaults.setHasLaunched(true)
        let newVC = RecyclingController()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }
}





extension OnboardingController {
    
    func setSubviews(){
        view.addSubview(collection)
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
