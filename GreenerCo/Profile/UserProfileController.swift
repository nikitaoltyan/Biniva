//
//  UserProfileController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.12.2020.
//

import UIKit

class UserProfileController: UIViewController {

    var scrollView: UIScrollView!
    let profileImageHeight = 140 as CGFloat
    var meetCollectionLeftLayoutConstraint: NSLayoutConstraint!
    var borderSelectedLeftLayoutConstraint: NSLayoutConstraint!
    
    let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nickname: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "@nikitaoltyan"
        label.font = UIFont.init(name: "SFPro-Medium", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "Nikita Oltyan"
        label.font = UIFont.init(name: "SFPro-Bold", size: 26.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userCity: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "Moscow"
        label.font = UIFont.init(name: "SFPro-Medium", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editView: UIView = {
        let view = UIView()
        view.backgroundColor = MainConstants.nearWhite
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1
        view.layer.borderColor = MainConstants.nearWhite.cgColor
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 0
        label.text = "Some big custome description. Some big custome description. Some big custome description. Some big custome description. Some big custome description. Some big custome description."
        label.font = UIFont.init(name: "SFPro", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let meetingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "Meetings"
        label.font = UIFont.init(name: "SFPro-Heavy", size: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let meetLabelButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "Meetings"
        label.font = UIFont.init(name: "SFPro", size: 20.0)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let joinedLabelButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "Joined"
        label.font = UIFont.init(name: "SFPro", size: 20.0)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let borderViewHorizontal: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.nearWhite
        return view
    }()
    
    let borderViewVertical: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.nearWhite
        return view
    }()
    
    let borderSelected: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.nearBlack
        return view
    }()
    
    var meetCollection: UICollectionView!
    var joinedCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        ActivateConstraints()
    }
    
    @objc func EditOpen(){
        print("Edit open")
        let newVC = SettingsController()
        newVC.modalPresentationStyle = .overFullScreen
        present(newVC, animated: true, completion: nil)
    }
    
    @objc func MeetOpen(){
        print("Meet open")
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.meetCollection.center.x += MainConstants.screenWidth
            self.joinedCollection.center.x += MainConstants.screenWidth
            self.borderSelected.center.x -= MainConstants.screenWidth/2
            self.meetLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
            self.meetLabelButton.textColor = .black
            self.joinedLabelButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.joinedLabelButton.textColor = MainConstants.nearBlack
        }, completion: { finished in
            self.meetCollectionLeftLayoutConstraint.constant += MainConstants.screenWidth
            self.borderSelectedLeftLayoutConstraint.constant -= MainConstants.screenWidth/2
            self.meetCollection.layoutIfNeeded()
            self.borderSelected.layoutIfNeeded()
            self.joinedLabelButton.isUserInteractionEnabled = true
            self.meetLabelButton.isUserInteractionEnabled = false
        })
    }
    
    @objc func JoinedOpen(){
        print("Joined open")
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.meetCollection.center.x -= MainConstants.screenWidth
            self.joinedCollection.center.x -= MainConstants.screenWidth
            self.borderSelected.center.x += MainConstants.screenWidth/2
            self.joinedLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
            self.joinedLabelButton.textColor = .black
            self.meetLabelButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.meetLabelButton.textColor = MainConstants.nearBlack
        }, completion: { finished in
            self.meetCollectionLeftLayoutConstraint.constant -= MainConstants.screenWidth
            self.borderSelectedLeftLayoutConstraint.constant += MainConstants.screenWidth/2
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
            return 5
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = MainConstants.screenWidth
        let size: CGSize = CGSize(width: width, height: 270)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = meetCollection.dequeueReusableCell(withReuseIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
            cell.checkView.isHidden = true
            return cell
        } else  {
            let cell = meetCollection.dequeueReusableCell(withReuseIdentifier: "MeetingCell", for: indexPath) as! MeetingCell
            return cell
        }
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

extension UserProfileController {
    
    func ActivateConstraints(){
        let scroll: UIScrollView = {
            let scroll = UIScrollView()
            scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
            scroll.delegate = self
            scroll.bounces = false
            scroll.showsVerticalScrollIndicator = true
            scroll.translatesAutoresizingMaskIntoConstraints = false
            return scroll
        }()
        
        let editLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = MainConstants.nearBlack
            label.text = "Изменить"
            label.font = UIFont.init(name: "SFPro", size: 20.0)
            return label
        }()
        
        let collectionMeet: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.backgroundColor = MainConstants.white
            collection.delegate = self
            collection.dataSource = self
            collection.showsVerticalScrollIndicator = true
            collection.tag = 0
            return collection
        }()
        
        let collectionJoined: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.backgroundColor = MainConstants.white
            collection.delegate = self
            collection.dataSource = self
            collection.showsVerticalScrollIndicator = true
            collection.tag = 1
            return collection
        }()
        meetCollection = collectionMeet
        joinedCollection = collectionJoined
        meetCollection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        joinedCollection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        
        scrollView = scroll
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(nickname)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(userName)
        scrollView.addSubview(userCity)
        scrollView.addSubview(editView)
        scrollView.addSubview(desc)
        scrollView.addSubview(meetingsLabel)
        scrollView.addSubview(meetLabelButton)
        scrollView.addSubview(joinedLabelButton)
        scrollView.addSubview(borderViewHorizontal)
        scrollView.addSubview(borderViewVertical)
        scrollView.addSubview(borderSelected)
        scrollView.addSubview(meetCollection)
        scrollView.addSubview(joinedCollection)
    
        editView.addSubview(editLabel)
        
        backButton.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
        editView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditOpen)))
        meetLabelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MeetOpen)))
        meetLabelButton.isUserInteractionEnabled = false
        joinedLabelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(JoinedOpen)))
        meetLabelButton.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
        meetLabelButton.textColor = .black
        profileImage.layer.cornerRadius = profileImageHeight/2
        
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            nickname.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            nickname.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8),
            
            profileImage.leftAnchor.constraint(equalTo: backButton.leftAnchor),
            profileImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: profileImageHeight),
            profileImage.widthAnchor.constraint(equalToConstant: profileImageHeight),
            
            userName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10),
            
            userCity.leftAnchor.constraint(equalTo: userName.leftAnchor),
            userCity.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 6),
            
            editView.topAnchor.constraint(equalTo: userCity.bottomAnchor, constant: 10),
            editView.leftAnchor.constraint(equalTo: userName.leftAnchor),
            editView.heightAnchor.constraint(equalToConstant: 35),
            editView.widthAnchor.constraint(equalToConstant: 160),
            
            editLabel.centerXAnchor.constraint(equalTo: editView.centerXAnchor),
            editLabel.centerYAnchor.constraint(equalTo: editView.centerYAnchor),
            
            desc.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            desc.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            meetingsLabel.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 28),
            meetingsLabel.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            
            meetLabelButton.topAnchor.constraint(equalTo: meetingsLabel.bottomAnchor, constant: 15),
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
            
            borderSelected.topAnchor.constraint(equalTo: borderViewHorizontal.topAnchor),
            borderSelected.heightAnchor.constraint(equalToConstant: 1.5),
            borderSelected.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth/2),
            
            meetCollection.topAnchor.constraint(equalTo: borderViewHorizontal.bottomAnchor),
            meetCollection.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth),
            meetCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight+10),
            
            joinedCollection.topAnchor.constraint(equalTo: meetCollection.topAnchor),
            joinedCollection.leftAnchor.constraint(equalTo: meetCollection.rightAnchor),
            joinedCollection.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth),
            joinedCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight+10),
        ])
        NSLayoutConstraint.activate(const)
        
        meetCollectionLeftLayoutConstraint = meetCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        borderSelectedLeftLayoutConstraint = borderSelected.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        meetCollectionLeftLayoutConstraint.isActive = true
        borderSelectedLeftLayoutConstraint.isActive = true
    }


}
