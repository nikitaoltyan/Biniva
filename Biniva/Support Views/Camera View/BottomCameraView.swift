//
//  BottomCameraView.swift
//  Biniva
//
//  Created by Никита Олтян on 25.07.2021.
//

import UIKit


class BottomCameraView: UIView {
    
    let functions = MaterialFunctions()
    
    let weightView: WeightView = {
        let view = WeightView()
            .with(autolayout: false)
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    lazy var materialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2+40, height: 60)
        let collection = UICollectionView(frame: useFrame, collectionViewLayout: layout)
            .with(bgColor: .clear)
            .with(autolayout: false)
        collection.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        collection.isUserInteractionEnabled = true
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.alpha = 0
        collection.register(MaterialPinCell.self, forCellWithReuseIdentifier: "MaterialPinCell")
        return collection
    }()
    
    lazy var gradientViewLeft: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: materialCollection.frame.height))
            .with(autolayout: false)
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    lazy var gradientLeft: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientViewLeft.frame
        gradient.colors = [Colors.background.cgColor,
                           UIColor.white.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }()
    
    lazy var gradientViewRight: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: materialCollection.frame.height))
            .with(autolayout: false)
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    lazy var gradientRight: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientViewRight.frame
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor,
                           Colors.background.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }()
    
    let mainButton: TakePhotoView = {
        let view = TakePhotoView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    var isPhotoTaken: Bool = false
    
    var delegate: bottomCameraDelegate?
    var mainButtonCenterXConstraint: NSLayoutConstraint?
    var selectedMaterial: Int?
    
    
    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 130)
        super.init(frame: useFrame)
        backgroundColor = Colors.background
        
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    @objc
    func mainAction() {
        Vibration.light()
        if !(isPhotoTaken) {
            mainButton.tap(completion: { (_) in
                self.delegate?.takePhoto()
            })
            forwardAnimate()
        } else {
            addMaterial()
        }
    }
    
    
    func backAnimate() {
        isPhotoTaken = false
        mainButtonCenterXConstraint?.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
            self.materialCollection.alpha = 0
            self.weightView.alpha = 0
            self.gradientViewLeft.alpha = 0
            self.gradientViewRight.alpha = 0
            self.mainButton.setCamera()
        }, completion: { (_) in
            self.materialCollection.isHidden = true
            self.weightView.isHidden = true
            self.gradientViewLeft.isHidden = true
            self.gradientViewRight.isHidden = true
        })
    }
    
    private
    func forwardAnimate() {
        isPhotoTaken = true
        gradientViewLeft.isHidden = false
        gradientViewRight.isHidden = false
        materialCollection.isHidden = false
        weightView.isHidden = false
        mainButtonCenterXConstraint?.constant = MainConstants.screenWidth/2 - mainButton.frame.width
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
            self.materialCollection.alpha = 1
            self.gradientViewLeft.alpha = 1
            self.gradientViewRight.alpha = 1
            self.weightView.alpha = 1
            self.mainButton.setTray()
        })
    }
    
    private
    func addMaterial() {

        guard (selectedMaterial != nil) else {
            delegate?.showAlert(withTitle: "Add material!",
                                andSubtitle: "Please")
            return
        }
        
        let txt = self.weightView.textView.text.split(separator: " ")
        let weight: Int = Int(txt[0]) ?? 0
        
        guard (weight != 0) else {
            delegate?.showAlert(withTitle: "Set the weight!",
                                andSubtitle: "Please")
            return
        }
        
        delegate?.addMaterial(material: selectedMaterial!, weight: weight)
    }
}





extension BottomCameraView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 52, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = materialCollection.dequeueReusableCell(withReuseIdentifier: "MaterialPinCell", for: indexPath) as! MaterialPinCell
        cell.backgroundColor = functions.colorByRowValue(indexPath.row)
        let useImage: UIImage = functions.iconByRowValue(indexPath.row)
        let tintedImage = useImage.withRenderingMode(.alwaysTemplate)
        cell.image.image = tintedImage
        cell.image.tintColor = Colors.background
        cell.layer.cornerRadius = 26
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Vibration.soft()
        if let cell = materialCollection.cellForItem(at: indexPath) as? MaterialPinCell {
            guard (selectedMaterial != nil) else {
                selectedMaterial = indexPath.row
                cell.layer.borderWidth = 1.5
                return
            }
            
            guard (selectedMaterial == indexPath.row) else {
                if let cell = materialCollection.cellForItem(at: IndexPath(row: selectedMaterial!, section: 0)) as? MaterialPinCell {
                    cell.layer.borderWidth = 0
                }
                selectedMaterial = indexPath.row
                cell.layer.borderWidth = 1.5
                return
            }
        }
    }
}





extension BottomCameraView {
    
    func setSubviews(){
        self.addSubview(weightView)
        self.addSubview(materialCollection)
        self.addSubview(gradientViewLeft)
        gradientViewLeft.layer.addSublayer(gradientLeft)
        self.addSubview(gradientViewRight)
        gradientViewRight.layer.addSublayer(gradientRight)
        self.addSubview(gradientViewRight)
        self.addSubview(mainButton)
        
        mainButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainAction)))
    }
    
    
    func activateLayouts(){
        NSLayoutConstraint.activate([
//            mainButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            mainButton.widthAnchor.constraint(equalToConstant: mainButton.frame.width),
            mainButton.heightAnchor.constraint(equalToConstant: mainButton.frame.height),
            
            weightView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weightView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            weightView.widthAnchor.constraint(equalToConstant: weightView.frame.width),
            weightView.heightAnchor.constraint(equalToConstant: weightView.frame.height),
            
            materialCollection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            materialCollection.centerYAnchor.constraint(equalTo: mainButton.centerYAnchor),
            materialCollection.widthAnchor.constraint(equalToConstant: materialCollection.frame.width),
            materialCollection.heightAnchor.constraint(equalToConstant: materialCollection.frame.height),
            
            gradientViewLeft.leftAnchor.constraint(equalTo: materialCollection.leftAnchor),
            gradientViewLeft.centerYAnchor.constraint(equalTo: materialCollection.centerYAnchor),
            gradientViewLeft.widthAnchor.constraint(equalToConstant: gradientViewLeft.frame.width),
            gradientViewLeft.heightAnchor.constraint(equalToConstant: gradientViewLeft.frame.height),
            
            gradientViewRight.rightAnchor.constraint(equalTo: materialCollection.rightAnchor),
            gradientViewRight.centerYAnchor.constraint(equalTo: materialCollection.centerYAnchor),
            gradientViewRight.widthAnchor.constraint(equalToConstant: gradientViewRight.frame.width),
            gradientViewRight.heightAnchor.constraint(equalToConstant: gradientViewRight.frame.height),
        ])
        mainButtonCenterXConstraint = mainButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        mainButtonCenterXConstraint?.isActive = true
    }
}
