//
//  UserProfileController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.12.2020.
//

import UIKit

class UserProfileController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.delegate = self
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = true
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
        label.textColor = MainConstants.nearBlack
        label.text = "@nikitaoltyan"
        label.font = UIFont.init(name: "SFPro-Medium", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageScale: CGFloat = 140
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = imageScale/2
        return image
    }()
    
    let meetedLabelsView: InfoView = {
        let scale: CGFloat = 50
        let view = InfoView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let joinedLabelsView: InfoView = {
        let scale: CGFloat = 50
        let view = InfoView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let editView: ButtonView = {
        let view = ButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
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
        view.label.textColor = MainConstants.nearBlack
        view.label.text = "Изменить"
        view.label.font = UIFont.init(name: "SFPro", size: 20.0)
        return view
    }()
    
    let userBigDesc: UILabel = {
        let label = UILabel()
        label.textColor = MainConstants.nearBlack
        label.text = "Nikita Oltyan, Moscow"
        label.font = UIFont.init(name: "SFPro-Medium", size: 21.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userDesc: UILabel = {
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
    
    lazy var meetCollection: UICollectionView = {
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
    
    lazy var joinedCollection: UICollectionView = {
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
    
    var meetCollectionLeftLayoutConstraint: NSLayoutConstraint?
    var borderSelectedLeftLayoutConstraint: NSLayoutConstraint?
    var backWidthLayoutConstraint: NSLayoutConstraint?
    var usernameLeftLayoutConstraint: NSLayoutConstraint?
    
    var userId: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    
    
    func PlaceBackButton(withUserId userId: String){
//        End fucntion after Firebase connection.
        switch userId{
        case self.userId:
            self.backWidthLayoutConstraint?.constant = 0
            self.usernameLeftLayoutConstraint?.constant = 0
            view.layoutIfNeeded()
        default:
            self.backWidthLayoutConstraint?.constant = self.backButton.frame.width
            self.usernameLeftLayoutConstraint?.constant = 8
            view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func EditOpen(){
        print("Edit open")
//        let newVC = SettingsController()
        let newVC = AboutUsController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
    }
    
    
//    Test function for PopUpController. Should not be here.
    func PresentPopUp(){
        let newVC = PopUpController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(newVC, animated: false, completion: nil)
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
            self.meetCollectionLeftLayoutConstraint?.constant += MainConstants.screenWidth
            self.borderSelectedLeftLayoutConstraint?.constant -= MainConstants.screenWidth/2
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
    
    func SetSubviews(){
        meetCollection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        joinedCollection.register(MeetingCell.self, forCellWithReuseIdentifier: "MeetingCell")
        
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(username)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(meetedLabelsView)
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
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
//            backButton width constraint on the bottom of the fucntion.
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: backButton.frame.height),
            
//            username left constraint on the bottom of the fucntion.
            username.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            profileImage.leftAnchor.constraint(equalTo: backButton.leftAnchor),
            profileImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: profileImage.frame.height),
            profileImage.widthAnchor.constraint(equalToConstant: profileImage.frame.width),
            
            meetedLabelsView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -20),
            meetedLabelsView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 40),
            meetedLabelsView.heightAnchor.constraint(equalToConstant: meetedLabelsView.frame.height),
            meetedLabelsView.widthAnchor.constraint(equalToConstant: meetedLabelsView.frame.width),
            
            joinedLabelsView.centerYAnchor.constraint(equalTo: meetedLabelsView.centerYAnchor),
            joinedLabelsView.leftAnchor.constraint(equalTo: meetedLabelsView.rightAnchor, constant: 70),
            joinedLabelsView.heightAnchor.constraint(equalToConstant: joinedLabelsView.frame.height),
            joinedLabelsView.widthAnchor.constraint(equalToConstant: joinedLabelsView.frame.width),
            
            editView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            editView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20),
            editView.heightAnchor.constraint(equalToConstant: 35),
            editView.widthAnchor.constraint(equalToConstant: 160),
            
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
            meetCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight+10),
            
            joinedCollection.topAnchor.constraint(equalTo: meetCollection.topAnchor),
            joinedCollection.leftAnchor.constraint(equalTo: meetCollection.rightAnchor),
            joinedCollection.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth),
            joinedCollection.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight+10),
        ])
        
        backWidthLayoutConstraint = backButton.widthAnchor.constraint(equalToConstant: backButton.frame.width)
        usernameLeftLayoutConstraint = username.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8)
        meetCollectionLeftLayoutConstraint = meetCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        borderSelectedLeftLayoutConstraint = borderSelected.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        
        backWidthLayoutConstraint?.isActive = true
        usernameLeftLayoutConstraint?.isActive = true
        meetCollectionLeftLayoutConstraint?.isActive = true
        borderSelectedLeftLayoutConstraint?.isActive = true
    }
}
