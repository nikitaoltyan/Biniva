//
//  AchieveController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 08.11.2020.
//

import UIKit

class AchieveController: UIViewController {

    lazy var achieveCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(CategoryNameCell.self, forCellWithReuseIdentifier: "CategoryNameCell")
        collection.register(TopViewCell.self, forCellWithReuseIdentifier: "TopViewCell")
        collection.register(AchieveCell.self, forCellWithReuseIdentifier: "AchieveCell")
        
        return collection
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    var topHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        PopulateImages()
        SetSubviews()
        ActivateLayouts()
    }
    
    var useImages: Array<UIImage?> = []
    
    func PopulateImages(){
        useImages.append(contentsOf: [
            UIImage(named: "1-02.1-s"),
            UIImage(named: "1-02.2-s"),
            UIImage(named: "1-02.3-s"),
            
            UIImage(named: "2-02.1-s"),
            UIImage(named: "2-02.2-s"),
            UIImage(named: "2-02.3-s"),
            
            UIImage(named: "3-02.1-s"),
            UIImage(named: "3-02.2-s"),
            UIImage(named: "3-02.3-s"),
            UIImage(named: "3-02.4-s"),
            UIImage(named: "3-02.5-s"),
            UIImage(named: "3-02.6-s"),
            UIImage(named: "3-02.7-s"),
            UIImage(named: "3-02.8-s"),
            UIImage(named: "3-02.9-s"),
            
            UIImage(named: "4-02.1-s"),
            UIImage(named: "4-02.2-s"),
            UIImage(named: "4-02.3-s"),
            
            UIImage(named: "5-02.1-s"),
            UIImage(named: "5-02.2-s"),
            UIImage(named: "5-02.3-s"),
            
            UIImage(named: "6-02.1-s"),
            UIImage(named: "6-02.2-s"),
            UIImage(named: "6-02.3-s"),
            
            UIImage(named: "7-02.1-s"),
            UIImage(named: "7-02.2-s"),
            UIImage(named: "7-02.3-s"),
            
            UIImage(named: "8-02-s"),
        ])
    }
}




extension AchieveController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let minWidth = width/3 - 4
        if indexPath.row == 0{
            let size: CGSize = CGSize(width: width, height: 150)
            return size
        } else if indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 9 || indexPath.row == 19 || indexPath.row == 23 || indexPath.row == 27 || indexPath.row == 31 || indexPath.row == 35{
            let size: CGSize = CGSize(width: MainConstants.screenWidth-10, height: 60)
            return size
        } else{
            let size: CGSize = CGSize(width: minWidth, height: minWidth)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return useImages.count + 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        if row < 19 {
            if row == 0{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
                cell.mainLabel.text = "Аллея славы"
                cell.plusView.isHidden = true
                cell.delegateBack = self
                cell.isUserInteractionEnabled = true
                return cell
            } else if row == 1{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title One"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 2 || row == 3 || row == 4 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-2]
                return cell
            } else if row == 5{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Two"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 6 || row == 7 || row == 8{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-3]
                return cell
            } else if row == 9{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Three"
                cell.isUserInteractionEnabled = false
                return cell
            }  else {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-4]
                return cell
            }
        } else {
            if row == 19{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Four"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 20 || row == 21 || row == 22 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-5]
                return cell
            } else if row == 23 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Five"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 24 || row == 25 || row == 26 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-6]
                return cell
            } else if row == 27{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Six"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 28 || row == 29 || row == 30 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-7]
                return cell
            } else if row == 31 {
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Seven"
                cell.isUserInteractionEnabled = false
                return cell
            } else if row == 32 || row == 33 || row == 34{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-8]
                return cell
            } else if row == 35{
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "CategoryNameCell", for: indexPath) as! CategoryNameCell
                cell.categoryLabel.text = "Title Eight"
                cell.isUserInteractionEnabled = false
                return cell
            } else {
                print(row)
                let cell = achieveCollection.dequeueReusableCell(withReuseIdentifier: "AchieveCell", for: indexPath) as! AchieveCell
                cell.achieveImage.image = useImages[row-9]
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = ShowAchieveController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
}




extension AchieveController: BackDelegate {
    func Back(){
        print("Back after delegate")
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}




extension AchieveController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topView.isHidden = (achieveCollection.contentOffset.y>0)
        if topView.isHidden == false {
            topHeightConstraint!.constant = abs(achieveCollection.contentOffset.y)
            topView.layoutIfNeeded()
        }
    }
    
}




extension AchieveController {
    
    func SetSubviews(){
        view.addSubview(topView)
        view.addSubview(achieveCollection)
    }
    
    func ActivateLayouts(){
        let const: CGFloat = {if MainConstants.screenHeight > 700{return -50}else{return -20}}()
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            achieveCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: const),
            achieveCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            achieveCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            achieveCollection.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        topHeightConstraint = topView.heightAnchor.constraint(equalToConstant: 20)
        topHeightConstraint?.isActive = true
        view.bringSubviewToFront(achieveCollection)
        
    }
    
}
