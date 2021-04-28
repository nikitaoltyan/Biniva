//
//  AddTrashController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 20.04.2021.
//

import UIKit

protocol PushUpdateDelegate {
    func animateCircle(addWeight: Int)
    func updateStats()
}

class AddTrashController: UIViewController {

    let backButton: UIImageView = {
        let scale: CGFloat = 35
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale-5))
            .with(autolayout: false)
        button.tintColor = MainConstants.nearBlack
        button.image = UIImage(systemName: "chevron.down")
        button.isUserInteractionEnabled = true
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
        pager.numberOfPages = materials.enums.count
        pager.currentPageIndicatorTintColor = Colors.darkGrayText
        pager.pageIndicatorTintColor = Colors.sliderGray
        return pager
    }()
    
    let addTrashView: AddTrashView = {
        let view = AddTrashView()
            .with(bgColor: .clear)
            .with(autolayout: false)
        view.isHidden = true
        return view
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
    
    
    var delegate: Test?
    var currentPage: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.sliderGray
        self.hideKeyboardWhenTappedAround()
        SetSubviews()
        ActivateLayouts()
    }

    
    @objc func Close(){
        if (materialsCollection.isHidden) {
            addTrashView.isHidden = true
            materialsCollection.isHidden = false
            pager.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.backButton.transform = CGAffineTransform(rotationAngle: 0)
            })
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func Add(){
        if (materialsCollection.isHidden) {
            Vibration.Light()
            let txt = addTrashView.weightView.textView.text.split(separator: " ")
            let weight: Int = Int(txt[0]) ?? 0
            DataFunction().addData(loggedSize: weight, material: currentPage, date: Date().onlyDate)
//            Call circle ani,mation function here also.
            dismiss(animated: true, completion: {() in  self.delegate?.update() })
        } else {
            Vibration.soft()
            materialsCollection.isHidden = true
            pager.isHidden = true
            addTrashView.isHidden = false
            addTrashView.title.text = materials.name[currentPage]
            addTrashView.useCase = materials.enums[currentPage]
            addTrashView.populate()
            UIView.animate(withDuration: 0.2, animations: {
                self.backButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            })
        }
    }
}




extension AddTrashController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        currentPage = Int(pageIndex)
        pager.currentPage = Int(pageIndex)
    }
}





extension AddTrashController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.enums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: materialsCollection.frame.width, height: materialsCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = materialsCollection.dequeueReusableCell(withReuseIdentifier: "MaterialCell", for: indexPath) as! MaterialCell
        cell.image.image = materials.image[indexPath.row]
        cell.title.text = materials.name[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Add()
    }
    
}





extension AddTrashController {
    func SetSubviews(){
        view.addSubview(backButton)
        view.addSubview(whiteBGView)
        whiteBGView.addSubview(materialsCollection)
        whiteBGView.addSubview(button)
        whiteBGView.addSubview(pager)
        whiteBGView.addSubview(addTrashView)
        
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Close)))
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Add)))
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
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            
            pager.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -50),
            pager.centerXAnchor.constraint(equalTo: whiteBGView.centerXAnchor),
            
            addTrashView.centerXAnchor.constraint(equalTo: whiteBGView.centerXAnchor),
            addTrashView.topAnchor.constraint(equalTo: whiteBGView.topAnchor, constant: 22),
            addTrashView.heightAnchor.constraint(equalToConstant: addTrashView.frame.height),
            addTrashView.widthAnchor.constraint(equalToConstant: addTrashView.frame.width),
        ])
    }
}
