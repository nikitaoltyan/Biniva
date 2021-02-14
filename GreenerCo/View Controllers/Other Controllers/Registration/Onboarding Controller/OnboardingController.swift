//
//  OnboardingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.01.2021.
//

import UIKit

class OnboardingController: UIViewController {
    
    lazy var bottomView: BottomLogInView = {
        let bottomViewHeight: CGFloat = {if MainConstants.screenHeight > 700 { return 390 } else { return 258}}()
        let view = BottomLogInView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: bottomViewHeight))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.backgroundColor = MainConstants.white
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(OnboardCell.self, forCellWithReuseIdentifier: "OnboardCell")
        
        return collection
    }()
    
    lazy var pager: UIPageControl = {
        let pager = UIPageControl()
        pager.translatesAutoresizingMaskIntoConstraints = false
        pager.numberOfPages = images.count
        pager.backgroundColor = .clear
        pager.currentPageIndicatorTintColor = MainConstants.green
        pager.pageIndicatorTintColor = MainConstants.nearWhite
        return pager
    }()
    
    let logInButton: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            .with(color: MainConstants.white)
            .with(alignment: .center)
            .with(fontName: "SFPro", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.text = "Войти"
        return label
    }()
    
    let images: Array<UIImage?> = [UIImage(named: "point_1"),
                                  UIImage(named: "point_2"),
                                  UIImage(named: "point_3")]
    let labels: Array<String> = ["Находи людей для экологических встреч",
                                 "Следи за уровнем своих отходов",
                                 "Присоединяйся к Zero Waste сообществу"]
    let secondLabels: Array<String> = ["Потом придумаю",
                                       "Потом придумаю",
                                       "Потом придумаю"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }

    @objc func OpenLogIn() {
        let newVC = LogInController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
    }
}





extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collection.frame.maxY-collection.frame.minY
        return CGSize(width: MainConstants.screenWidth, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "OnboardCell", for: indexPath) as! OnboardCell
        cell.image.image = images[indexPath.row]
        cell.mainLabel.text = labels[indexPath.row]
        cell.secondLabel.text = secondLabels[indexPath.row]
        return cell
    }
    
}





extension OnboardingController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pager.currentPage = Int(pageIndex)
    }
}





extension OnboardingController: OnbordingDelegate {

    //        Now is not available
    func OpenApple() {}

//        Now is not available
    func OpenFacebook() {}
    
    func OpenEmail() {
        print("Open registration")
        let newVC = RegistrationController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
    }
}





extension OnboardingController {
    
    func SetSubviews(){
        view.addSubview(bottomView)
        view.addSubview(collection)
        view.addSubview(pager)
        view.addSubview(logInButton)
        
        logInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenLogIn)))
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: bottomView.frame.height),
            
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            pager.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pager.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5),
            
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            logInButton.heightAnchor.constraint(equalToConstant: logInButton.frame.height),
            logInButton.widthAnchor.constraint(equalToConstant: logInButton.frame.width)
        ])
    }
}




protocol OnbordingDelegate {
    func OpenApple()
    func OpenFacebook()
    func OpenEmail()
}
