//
//  AddTrashController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 20.04.2021.
//

import UIKit

class AddTrashController: UIViewController {

    let backButton: UIButton = {
        let scale: CGFloat = 50
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()
    
    let whiteBGView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight * 0.835))
            .with(bgColor: Colors.background)
            .with(cornerRadius: 22)
            .with(autolayout: false)
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var materialsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 450)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(autolayout: false)
            .with(bgColor: .clear)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(MaterialCell.self, forCellWithReuseIdentifier: "MaterialCell")
        return collection
    }()
    
    lazy var pager: UIPageControl = {
        let pager = UIPageControl()
            .with(bgColor: .clear)
            .with(autolayout: false)
        pager.numberOfPages = 4
        pager.currentPageIndicatorTintColor = Colors.darkGrayText
        pager.pageIndicatorTintColor = Colors.sliderGray
        return pager
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.sliderGray
        SetSubviews()
        ActivateLayouts()
    }

    
    @objc func Close(){
        let newVC = RecyclingController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
    }
}





extension AddTrashController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: materialsCollection.frame.width, height: materialsCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = materialsCollection.dequeueReusableCell(withReuseIdentifier: "MaterialCell", for: indexPath) as! MaterialCell
        cell.image.image = #imageLiteral(resourceName: "5-02.3-s")
        cell.title.text = "Plastik"
        return cell
    }
    
}





extension AddTrashController {
    func SetSubviews(){
        view.addSubview(backButton)
        view.addSubview(whiteBGView)
        whiteBGView.addSubview(materialsCollection)
        whiteBGView.addSubview(button)
        
        backButton.addTarget(self, action: #selector(Close), for: .touchUpInside)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            
            whiteBGView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteBGView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whiteBGView.heightAnchor.constraint(equalToConstant: whiteBGView.frame.height),
            whiteBGView.widthAnchor.constraint(equalToConstant: whiteBGView.frame.width),
            
            materialsCollection.centerXAnchor.constraint(equalTo: whiteBGView.centerXAnchor),
            materialsCollection.topAnchor.constraint(equalTo: whiteBGView.topAnchor, constant: 22),
            materialsCollection.heightAnchor.constraint(equalToConstant: materialsCollection.frame.height),
            materialsCollection.widthAnchor.constraint(equalToConstant: materialsCollection.frame.width),
            
            button.centerXAnchor.constraint(equalTo: whiteBGView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: whiteBGView.bottomAnchor, constant: -66),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width)
        ])
    }
}
