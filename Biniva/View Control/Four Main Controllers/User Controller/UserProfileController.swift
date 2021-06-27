//
//  UserProfileController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.12.2020.
//

import UIKit
import CoreLocation
import MapKit

class UserProfileController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.delegate = self
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let backButton: UIButton = {
        let scale: CGFloat = 30
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let username: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Medium", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageScale: CGFloat = 140
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
            .with(cornerRadius: imageScale/2)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let meetLabelsView: InfoView = {
        let scale: CGFloat = 50
        let view = InfoView(frame: CGRect(x: 0, y: 0, width: scale-5, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.descLabel.text = "встречи"
        return view
    }()
    
    let joinedLabelsView: InfoView = {
        let scale: CGFloat = 50
        let view = InfoView(frame: CGRect(x: 0, y: 0, width: scale-5, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.descLabel.text = "участник"
        return view
    }()
    
    let editView: ButtonView = {
        let view = ButtonView()
            .with(bgColor: MainConstants.nearWhite)
            .with(cornerRadius: 7)
            .with(borderWidth: 1, color: MainConstants.nearWhite.cgColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.label.textColor = MainConstants.nearBlack
        view.label.text = "Изменить"
        view.label.font = UIFont.init(name: "SFPro", size: 20.0)
        return view
    }()
    
    let userBigDesc: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Medium", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userDesc: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 14)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let meetLabelButton: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 20)
            .with(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Встречи"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let joinedLabelButton: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro", size: 20)
            .with(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Участник"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let borderViewHorizontal: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearWhite)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let borderViewVertical: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearWhite)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let borderSelected: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.nearBlack)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var meetCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = MainConstants.white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.tag = 0
        collection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        collection.register(EmptyMeetingsCell.self, forCellWithReuseIdentifier: "EmptyMeetingsCell")
        return collection
    }()
    
    lazy var joinedCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = MainConstants.white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.tag = 1
        collection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        collection.register(EmptyMeetingsCell.self, forCellWithReuseIdentifier: "EmptyMeetingsCell")
        return collection
    }()
    
    var meetCollectionLeftLayoutConstraint: NSLayoutConstraint?
    var borderSelectedLeftLayoutConstraint: NSLayoutConstraint?
    var usernameLeftLayoutConstraint: NSLayoutConstraint?
    
    var userId: String?
    var meetArray: Array<String> = []
    var meetDetails: Array<Dictionary<String, Any>> = []
    var joinedArray: Array<String> = []
    var joinedDetails: Array<Dictionary<String, Any>> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        UpdateData()
        SetSubviews()
        ActivateLayouts()
        PlaceBackButton(withUserId: Defaults.GetUserId())
    }
    
    
    
    func PlaceBackButton(withUserId uid: String?){
        if (userId == uid) && (uid != nil) {
            backButton.isHidden = true
            usernameLeftLayoutConstraint?.constant = 0
            view.layoutIfNeeded()
        } else {
            backButton.isHidden = false
            usernameLeftLayoutConstraint?.constant = backButton.frame.width + 8
            view.layoutIfNeeded()
        }
        
        guard (uid == nil) else { return }
        switch userId{
        case self.userId:
            self.usernameLeftLayoutConstraint?.constant = 0
            view.layoutIfNeeded()
        default:
            self.usernameLeftLayoutConstraint?.constant = 8
            view.layoutIfNeeded()
        }
        
    }
    
    
    
    func UpdateData() {
//        Server.GetAllUserData(forUserId: Defaults.GetUserId(), userData: { data in
//            DispatchQueue.main.async { self.profileImage.downloadImage(from: data["image"] as? String) }
//            self.username.text = "@\(data["username"] as? String ?? "NaN")"
//            self.userBigDesc.text = data["header_desc"] as? String ?? " "
//            self.userDesc.text = data["desc"] as? String ?? " "
//            let meetings = data["meetings"] as? Dictionary<String, Any> ?? [:]
//            self.meetArray = meetings["created_meetings"] as? Array ?? []
//            self.joinedArray = meetings["joined_meetings"] as? Array ?? []
//            self.meetLabelsView.numberLabel.text = "\(self.meetArray.count)"
//            self.joinedLabelsView.numberLabel.text = "\(self.joinedArray.count)"
//            self.CollectionUpdate()
//        })
    }
    
    
    func CollectionUpdate(){
//        for mid in meetArray{
//            Server.PostDetails(postWithId: mid, postDetails: { data in
//                self.meetDetails.append(data)
//                self.meetCollection.reloadData()
//            })
//        }
//        for mid in joinedArray{
//            Server.PostDetails(postWithId: mid, postDetails: { data in
//                self.joinedDetails.append(data)
//                self.joinedCollection.reloadData()
//            })
//        }
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: meetCollection.frame.minY+MainConstants.screenHeight)
    }
    
    
    
    @objc func EditOpen(){
        print("Edit open")
        let newVC = SettingsController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
    }
    
    
    @objc func MeetOpen(){
        Vibration.light()
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.meetCollection.center.x += MainConstants.screenWidth
            self.joinedCollection.center.x += MainConstants.screenWidth
            self.borderSelected.center.x -= MainConstants.screenWidth/2
            self.meetLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
            self.meetLabelButton.textColor = .black
            self.joinedLabelButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.joinedLabelButton.textColor = MainConstants.nearBlack
        }, completion: { finished in
            self.meetCollectionLeftLayoutConstraint?.constant += MainConstants.screenWidth
            self.borderSelectedLeftLayoutConstraint?.constant -= MainConstants.screenWidth/2
            self.meetCollection.layoutIfNeeded()
            self.borderSelected.layoutIfNeeded()
            self.joinedLabelButton.isUserInteractionEnabled = true
            self.meetLabelButton.isUserInteractionEnabled = false
        })
    }
    
    @objc func JoinedOpen(){
        Vibration.light()
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.meetCollection.center.x -= MainConstants.screenWidth
            self.joinedCollection.center.x -= MainConstants.screenWidth
            self.borderSelected.center.x += MainConstants.screenWidth/2
            self.joinedLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
            self.joinedLabelButton.textColor = .black
            self.meetLabelButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.meetLabelButton.textColor = MainConstants.nearBlack
        }, completion: { finished in
            self.meetCollectionLeftLayoutConstraint?.constant -= MainConstants.screenWidth
            self.borderSelectedLeftLayoutConstraint?.constant += MainConstants.screenWidth/2
            self.meetCollection.layoutIfNeeded()
            self.borderSelected.layoutIfNeeded()
            self.joinedLabelButton.isUserInteractionEnabled = false
            self.meetLabelButton.isUserInteractionEnabled = true
        })
    }
    
    @objc func BackAction(sender: UIButton!) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
}






extension UserProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            if meetDetails.count < 10 {
                return meetDetails.count + 1
            } else {
                return meetDetails.count
            }
        } else {
            if joinedDetails.count < 10 {
                return joinedDetails.count + 1
            } else {
                return joinedDetails.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = MainConstants.screenWidth
        if collectionView.tag == 0{
            if meetDetails.count < 10 {
                switch indexPath.row {
                case meetDetails.count:
                    let size: CGSize = CGSize(width: width, height: 650)
                    return size
                default:
                    let size: CGSize = CGSize(width: width, height: 320)
                    return size
                }
            } else {
                let size: CGSize = CGSize(width: width, height: 320)
                return size
            }
        } else {
            if joinedDetails.count < 10 {
                switch indexPath.row {
                case joinedDetails.count:
                    let size: CGSize = CGSize(width: width, height: 650)
                    return size
                default:
                    let size: CGSize = CGSize(width: width, height: 320)
                    return size
                }
            } else {
                let size: CGSize = CGSize(width: width, height: 320)
                return size
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            if meetDetails.count < 10 {
                switch indexPath.row {
                case meetDetails.count:
                    let cell = ReturnEmptyCell(forCollection: meetCollection, indexPath: indexPath)
                    return cell
                default:
                    let cell = ReturnMeetingCell(forCollection: meetCollection, indexPath: indexPath, data: meetDetails[indexPath.row], checkIsHidden: true)
                    return cell
                }
            } else {
                let cell = ReturnMeetingCell(forCollection: meetCollection, indexPath: indexPath, data: meetDetails[indexPath.row], checkIsHidden: true)
                return cell
            }
        } else {
            if joinedDetails.count < 10 {
                switch indexPath.row {
                case joinedDetails.count:
                    let cell = ReturnEmptyCell(forCollection: joinedCollection, indexPath: indexPath)
                    return cell
                default:
                    let cell = ReturnMeetingCell(forCollection: joinedCollection, indexPath: indexPath, data: joinedDetails[indexPath.row], checkIsHidden: false)
                    return cell
                }
            } else {
                let cell = ReturnMeetingCell(forCollection: joinedCollection, indexPath: indexPath, data: joinedDetails[indexPath.row], checkIsHidden: false)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            guard (meetDetails.count >= 10 || (indexPath.row != meetDetails.count && meetDetails.count < 10)) else { return }
            Vibration.soft()
            let newVC = MeetingViewController()
            newVC.postData = meetDetails[indexPath.row]
            newVC.modalPresentationStyle = .overFullScreen
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            self.present(newVC, animated: false, completion: nil)
        } else {
            guard (joinedDetails.count >= 10 || (indexPath.row != joinedDetails.count && joinedDetails.count < 10)) else { return }
            Vibration.soft()
            let newVC = MeetingViewController()
            newVC.postData = joinedDetails[indexPath.row]
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
    
    
    func ReturnMeetingCell(forCollection collection: UICollectionView, indexPath: IndexPath, data: Dictionary<String, Any>, checkIsHidden: Bool) -> MeetingCell{
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
        cell.profileName.text = data["username"] as? String
        cell.profileImage.downloadImage(from: data["image"] as? String)
        cell.street.text = data["street_name"] as? String
        cell.time.text = "\(data["date"] as! String) \(data["time"] as! String)"
        cell.desc.text = data["desc"] as? String
        cell.checkView.isHidden = checkIsHidden
        
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
    
    func ReturnEmptyCell(forCollection collection: UICollectionView, indexPath: IndexPath) -> EmptyMeetingsCell{
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "EmptyMeetingsCell", for: indexPath) as! EmptyMeetingsCell
        cell.delegateMeeting = self
        cell.isUserInteractionEnabled = true
        return cell
    }
}





extension UserProfileController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            meetCollection.isScrollEnabled = (self.scrollView.contentOffset.y >=  meetCollection.frame.minY)
            joinedCollection.isScrollEnabled = (self.scrollView.contentOffset.y >=  joinedCollection.frame.minY)
        }
        if scrollView == meetCollection{
            meetCollection.isScrollEnabled = (meetCollection.contentOffset.y > 0)
        }
        if scrollView == joinedCollection{
            joinedCollection.isScrollEnabled = (joinedCollection.contentOffset.y > 0)
        }
    }
}






extension UserProfileController: AddMeetingDelegate {
    
    func addMeeting(){
        print("Add meeting")
        Vibration.light()
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




extension UserProfileController {
    
    func SetSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(username)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(meetLabelsView)
        scrollView.addSubview(joinedLabelsView)
        scrollView.addSubview(userBigDesc)
        scrollView.addSubview(editView)
        scrollView.addSubview(userDesc)
        scrollView.addSubview(meetLabelButton)
        scrollView.addSubview(joinedLabelButton)
        scrollView.addSubview(borderViewHorizontal)
        scrollView.addSubview(borderViewVertical)
        scrollView.addSubview(borderSelected)
        scrollView.addSubview(meetCollection)
        scrollView.addSubview(joinedCollection)
        
        backButton.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
        editView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditOpen)))
        meetLabelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MeetOpen)))
        joinedLabelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(JoinedOpen)))
        
        meetLabelButton.isUserInteractionEnabled = false
        meetLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
        meetLabelButton.textColor = .black
    }
    
    func ActivateLayouts(){
        let leftMeetConst: CGFloat = {if MainConstants.screenHeight>700{return 40}else{return 40}}()
        let leftJoinedConst: CGFloat = {if MainConstants.screenHeight>700{return 50}else{return 30}}()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width),
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            
//            username left constraint on the bottom of the fucntion.
            username.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            profileImage.leftAnchor.constraint(equalTo: backButton.leftAnchor),
            profileImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: profileImage.frame.height),
            profileImage.widthAnchor.constraint(equalToConstant: profileImage.frame.width),
            
            meetLabelsView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -20),
            meetLabelsView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: leftMeetConst),
            meetLabelsView.heightAnchor.constraint(equalToConstant: meetLabelsView.frame.height),
            meetLabelsView.widthAnchor.constraint(equalToConstant: meetLabelsView.frame.width),
            
            joinedLabelsView.centerYAnchor.constraint(equalTo: meetLabelsView.centerYAnchor),
            joinedLabelsView.leftAnchor.constraint(equalTo: meetLabelsView.rightAnchor, constant: leftJoinedConst),
            joinedLabelsView.heightAnchor.constraint(equalToConstant: joinedLabelsView.frame.height),
            joinedLabelsView.widthAnchor.constraint(equalToConstant: joinedLabelsView.frame.width),
            
            editView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            editView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20),
            editView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            editView.heightAnchor.constraint(equalToConstant: 35),
            
            userBigDesc.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            userBigDesc.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            userBigDesc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            userDesc.topAnchor.constraint(equalTo: userBigDesc.bottomAnchor, constant: 6),
            userDesc.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            userDesc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            meetLabelButton.topAnchor.constraint(equalTo: userDesc.bottomAnchor, constant: 15),
            meetLabelButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            meetLabelButton.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth/2),
            meetLabelButton.heightAnchor.constraint(equalToConstant: 30),
            
            joinedLabelButton.topAnchor.constraint(equalTo: meetLabelButton.topAnchor),
            joinedLabelButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            joinedLabelButton.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth/2),
            joinedLabelButton.heightAnchor.constraint(equalToConstant: 30),
            
            borderViewHorizontal.topAnchor.constraint(equalTo: meetLabelButton.bottomAnchor, constant: 4),
            borderViewHorizontal.heightAnchor.constraint(equalToConstant: 1),
            borderViewHorizontal.leftAnchor.constraint(equalTo: view.leftAnchor),
            borderViewHorizontal.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            borderViewVertical.topAnchor.constraint(equalTo: joinedLabelButton.topAnchor),
            borderViewVertical.bottomAnchor.constraint(equalTo: borderViewHorizontal.bottomAnchor),
            borderViewVertical.leftAnchor.constraint(equalTo: meetLabelButton.rightAnchor, constant: -0.5),
            borderViewVertical.widthAnchor.constraint(equalToConstant: 1),
            
//            borderSelected left layout constraint on the bottom of the fucntion.
            borderSelected.topAnchor.constraint(equalTo: borderViewHorizontal.topAnchor),
            borderSelected.heightAnchor.constraint(equalToConstant: 1.5),
            borderSelected.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth/2),
            
//            meetCollection left layout constraint on the bottom of the fucntion.
            meetCollection.topAnchor.constraint(equalTo: borderViewHorizontal.bottomAnchor),
            meetCollection.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth),
            meetCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight),
            
            joinedCollection.topAnchor.constraint(equalTo: meetCollection.topAnchor),
            joinedCollection.leftAnchor.constraint(equalTo: meetCollection.rightAnchor),
            joinedCollection.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth),
            joinedCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight),
        ])
        
        usernameLeftLayoutConstraint = username.leftAnchor.constraint(equalTo: backButton.leftAnchor, constant: 8+backButton.frame.width)
        meetCollectionLeftLayoutConstraint = meetCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        borderSelectedLeftLayoutConstraint = borderSelected.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        
        usernameLeftLayoutConstraint?.isActive = true
        meetCollectionLeftLayoutConstraint?.isActive = true
        borderSelectedLeftLayoutConstraint?.isActive = true
    }
}
