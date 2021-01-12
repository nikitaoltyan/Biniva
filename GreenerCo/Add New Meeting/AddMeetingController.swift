//
//  AddMeetingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 28.12.2020.
//

import UIKit

class AddMeetingController: UIViewController {

    lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.isScrollEnabled = false
        
        collection.register(AddMapCell.self, forCellWithReuseIdentifier: "AddMapCell")
        collection.register(FirstAddCell.self, forCellWithReuseIdentifier: "FirstAddCell")
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = MainConstants.white
        return collection
    }()
    
    lazy var topView: TopProgressView = {
        let view = TopProgressView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.delegate = self
        view.slide = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.borderColor = MainConstants.nearWhite.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    let numberOfSlides: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        SetSubviews()
        ActivateLayouts()
    }

}



extension AddMeetingController: TopProgressDelegate {
    
    func CloseView() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    func Scroll(slide: Int){
        let indexPath = IndexPath(item: slide, section: 0)
        mainCollection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
}



extension AddMeetingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSlides
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = CGSize(width: MainConstants.screenWidth, height: MainConstants.screenHeight-100)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "AddMapCell", for: indexPath) as! AddMapCell
            return cell
        default:
            let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "FirstAddCell", for: indexPath) as! FirstAddCell
            cell.backgroundColor = .red
            return cell
        }
    }

}





extension AddMeetingController {
    
    func SetSubviews(){
        view.addSubview(mainCollection)
        view.addSubview(topView)
    }
    
    func ActivateLayouts(){
        let topViewHeight: CGFloat = {if MainConstants.screenHeight>700{return 90}else{return 75}}()
        NSLayoutConstraint.activate([
            mainCollection.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: topViewHeight)
        ])
    }
}


protocol TopProgressDelegate {
    
    func CloseView()
    func Scroll(slide: Int)
    
}
