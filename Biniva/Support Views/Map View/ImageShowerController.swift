//
//  ImageShowerController.swift
//  Biniva
//
//  Created by Nick Oltyan on 13.08.2021.
//

import UIKit

class ImageShowerController: UIViewController {
    
    let analytics = ServerAnalytics()

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.null, collectionViewLayout: layout)
            .with(autolayout: false)
            .with(bgColor: .clear)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(ImagePinCell.self, forCellWithReuseIdentifier: "ImagePinCell")
        return collection
    }()
    
    let cross: UIButton = {
        let cross = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 27))
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.tintColor = .white
        cross.contentVerticalAlignment = .fill
        cross.contentHorizontalAlignment = .fill
        cross.alpha = 0
        cross.setImage(UIImage(systemName: "xmark"), for: .normal)
        return cross
    }()
    
    var images: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.logOpenImage()
        view.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.12, animations: {
            self.view.backgroundColor = .black.withAlphaComponent(0.8)
            self.cross.alpha = 1
        })
    }
    
    
    func update(arrayOfImages images: [String]) {
        self.images = images
        collection.reloadData()
    }
    
    func open(image: Int) {
        collection.scrollToItem(at: IndexPath(row: image, section: 0),
                                at: .right, animated: true)
    }
    
    
    @objc
    func closeAction() {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.backgroundColor = .clear
            self.cross.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
}





extension ImageShowerController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainConstants.screenWidth, height: MainConstants.screenWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImagePinCell", for: indexPath) as! ImagePinCell
        DispatchQueue.main.async {
            cell.image.downloadImage(from: self.images[indexPath.row])
        }
        return cell
    }
    
    
    
}






extension ImageShowerController {
    private
    func setSubviews() {
        view.addSubview(collection)
        view.addSubview(cross)
        cross.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            cross.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            cross.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            cross.heightAnchor.constraint(equalToConstant: cross.frame.height),
            cross.widthAnchor.constraint(equalToConstant: cross.frame.width),
        ])
    }
}

