//
//  MeetingsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 12.11.2020.
//

import UIKit
import Firebase

class MeetingsController: UIViewController {

    let meetingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = MainConstants.white
        collection.showsVerticalScrollIndicator = true
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
        Server.AuthUser(withEmail: "nikitaoltyan@mail.ru", password: "12345678")
        view.backgroundColor = MainConstants.white
        view.addSubview(meetingCollection)
        meetingCollection.delegate = self
        meetingCollection.dataSource = self
        view.addSubview(topView)
        meetingCollection.register(TopViewCell.self, forCellWithReuseIdentifier: "TopViewCell")
        meetingCollection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        TopViewLayer()
        CollectionLayer()
    }

}



extension MeetingsController: AddMeetingDelegate {
    
    func addMeeting(){
        print("Add meeting")
        let newVC = AddMeetingController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
    
}




extension MeetingsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = MainConstants.screenWidth
        if indexPath.row != 0 {
            let size: CGSize = CGSize(width: width, height: 320)
            return size
        } else {
            let size: CGSize = CGSize(width: width, height: 150)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Return number of cells")
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != 0 {
            let cell = meetingCollection.dequeueReusableCell(withReuseIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
            cell.checkView.isHidden = true
            return cell
        } else {
            let cell = meetingCollection.dequeueReusableCell(withReuseIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
            cell.SetRightConstraints()
            cell.mainLabel.text = "Встречи"
            cell.delegateMeeting = self
            cell.isUserInteractionEnabled = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0{
            Vibration.Soft()
            
            let newVC = MeetingViewController()
            newVC.modalPresentationStyle = .overFullScreen
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            self.present(newVC, animated: false, completion: nil)
        }
    }
}





extension MeetingsController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topView.isHidden = (meetingCollection.contentOffset.y>0)
        if topView.isHidden == false {
            topHeightConstraint?.constant = abs(meetingCollection.contentOffset.y)
            topView.layoutIfNeeded()
        }
    }
    
}





extension MeetingsController{
    
    func TopViewLayer(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        topHeightConstraint = topView.heightAnchor.constraint(equalToConstant: 20)
        topHeightConstraint?.isActive = true
    }
    
    func CollectionLayer(){
        meetingCollection.alwaysBounceVertical = false
        meetingCollection.delegate = self
        meetingCollection.backgroundColor = .clear
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                meetingCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
                meetingCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                meetingCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
                meetingCollection.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        } else {
            const.append(contentsOf: [
                meetingCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
                meetingCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                meetingCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
                meetingCollection.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }
        NSLayoutConstraint.activate(const)
        view.bringSubviewToFront(meetingCollection)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumLineSpacing = 1
    }
}




extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
