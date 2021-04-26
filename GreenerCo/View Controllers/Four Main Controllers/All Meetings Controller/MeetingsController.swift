//
//  MeetingsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 12.11.2020.
//

import UIKit
import CoreLocation
import MapKit

class MeetingsController: UIViewController {

    lazy var meetingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = true
        collection.alwaysBounceVertical = false
        collection.backgroundColor = .clear
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(TopViewCell.self, forCellWithReuseIdentifier: "TopViewCell")
        collection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        collection.register(EmptyMeetingsCell.self, forCellWithReuseIdentifier: "EmptyMeetingsCell")
        return collection
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    var topHeightConstraint: NSLayoutConstraint?
    var postDetails: Array<Dictionary<String, Any>> = []
    
    
    override func viewDidLoad() {
        Server.ReturnArrayWithPostDictonaries() { result in
            self.postDetails = result
            self.meetingCollection.reloadData()
        }
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }

}



extension MeetingsController: AddMeetingDelegate {
    
    func addMeeting(){
        print("Add meeting")
        Vibration.Light()
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
        if postDetails.count < 10 {
            switch indexPath.row {
            case 0:
                let size: CGSize = CGSize(width: width, height: 150)
                return size
            case postDetails.count+1:
                let size: CGSize = CGSize(width: width, height: 650)
                return size
            default:
                let size: CGSize = CGSize(width: width, height: 320)
                return size
            }
        } else {
            switch indexPath.row {
            case 0:
                let size: CGSize = CGSize(width: width, height: 150)
                return size
            default:
                let size: CGSize = CGSize(width: width, height: 320)
                return size
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if postDetails.count < 10 {
            return postDetails.count+2
        } else {
            return postDetails.count+1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if postDetails.count < 10 {
            switch indexPath.row {
            case 0:
                let cell = ReturnTopCell(indexPath: indexPath)
                return cell
            case postDetails.count+1:
                let cell = ReturnEmptyCell(indexPath: indexPath)
                return cell
            default:
                let cell = ReturnMeetingCell(forIndexPath: indexPath, data: postDetails[indexPath.row - 1])
                return cell
            }
        } else {
            switch indexPath.row {
            case 0:
                let cell = ReturnTopCell(indexPath: indexPath)
                return cell
            default:
                let cell = ReturnMeetingCell(forIndexPath: indexPath, data: postDetails[indexPath.row - 1])
                return cell
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0{
            guard (postDetails.count >= 10 || (indexPath.row != postDetails.count && postDetails.count < 10)) else { return }
            Vibration.soft()
            let newVC = MeetingViewController()
            newVC.postData = postDetails[indexPath.row - 1]
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
    
    
    
    func ReturnMeetingCell(forIndexPath indexPath: IndexPath, data: Dictionary<String, Any>) -> MeetingCell{
        let cell = meetingCollection.dequeueReusableCell(withReuseIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
        cell.profileName.text = data["username"] as? String
        cell.profileImage.downloadImage(from: data["image"] as? String)
        cell.street.text = data["street_name"] as? String
        cell.time.text = "\(data["date"] as! String) \(data["time"] as! String)"
        cell.desc.text = data["desc"] as? String
        
        let coordinateArray = data["coordinates"] as? Array<CGFloat>
        let title = data["header"] as? String
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinateArray?[0] ?? 0), longitude: CLLocationDegrees(coordinateArray?[1] ?? 0))
        let label = Capital(title: title ?? "Title wasn't set", coordinate: coordinate, info: "")
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
        cell.meetingLocation.addAnnotation(label)
        cell.meetingLocation.setRegion(viewRegion, animated: false)
        cell.checkView.isHidden = true
        return cell
    }
    
    
    func ReturnTopCell(indexPath: IndexPath) -> TopViewCell{
        let cell = meetingCollection.dequeueReusableCell(withReuseIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
        cell.SetRightConstraints()
        cell.mainLabel.text = "Встречи"
        cell.delegateMeeting = self
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    
    func ReturnEmptyCell(indexPath: IndexPath) -> EmptyMeetingsCell{
        let cell = meetingCollection.dequeueReusableCell(withReuseIdentifier: "EmptyMeetingsCell", for: indexPath) as! EmptyMeetingsCell
        cell.delegateMeeting = self
        cell.isUserInteractionEnabled = true
        return cell
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







extension MeetingsController {
    
    func SetSubviews() {
        view.addSubview(topView)
        view.addSubview(meetingCollection)
    }
    
    
    func ActivateLayouts() {
        let collectionTop: CGFloat = {if MainConstants.screenHeight>700 { return -50 } else { return -20 } }()
        NSLayoutConstraint.activate([
//            topView height constraint on the bottom of the function.
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            meetingCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: collectionTop),
            meetingCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            meetingCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            meetingCollection.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        topHeightConstraint = topView.heightAnchor.constraint(equalToConstant: 20)
        topHeightConstraint?.isActive = true
    }
}
