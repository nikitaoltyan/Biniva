//
//  MeetingViewController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 06.12.2020.
//

import UIKit
import MapKit
import CoreLocation

import Firebase

class MeetingViewController: UIViewController {
    
    var tableHeightConstraint: NSLayoutConstraint!
    var joinHeightConstraint: NSLayoutConstraint?
    var commentHeightConstraint: NSLayoutConstraint!
    var numberOfRows = 1
    var keyboardSize: CGFloat?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    lazy var backView: BackTopView = {
        let view = BackTopView()
        view.label.text = postData["header"] as? String
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let back: UIButton = {
        let scale: CGFloat = 30
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var profileImage: UIImageView = {
        let scale = 37 as CGFloat
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        DispatchQueue.main.async { image.downloadImage(from: self.postData["image"] as? String) }
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    lazy var profileName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "@\(postData["username"] as! String)"
        label.font = UIFont.init(name: "SFPro-Bold", size: 22.0)
        return label
    }()
    
    lazy var titleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = postData["header"] as? String
        label.font = UIFont.init(name: "SFPro-Heavy", size: 27.0)
        return label
    }()
    
    lazy var timeAndDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "\(postData["date"] as! String)  \(postData["time"] as! String)"
        label.font = UIFont.init(name: "SFPro-Bold", size: 19.0)
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.numberOfLines = 0
        label.text = postData["desc"] as? String
        label.font = UIFont.init(name: "SFPro", size: 16.0)
        return label
    }()
    
    let threeImagesView: ThreeImagesView = {
        let view = ThreeImagesView(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let whoIsJoined: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "vostogor +19 others joined"
        label.font = UIFont.init(name: "SFPro-Medium", size: 16.0)
        return label
    }()
    
    let whereLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "Где?"
        label.font = UIFont.init(name: "SFPro-Heavy", size: 24.0)
        return label
    }()
    
    lazy var meetingLocation: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isUserInteractionEnabled = true
        
        let coordinateArray = postData["coordinates"] as? Array<CGFloat>
        let title = postData["header"] as? String
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(coordinateArray?[0] ?? 0), longitude: CLLocationDegrees(coordinateArray?[1] ?? 0))
        let label = Capital(title: title ?? "Title wasn't set", coordinate: coordinate, info: "")
        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
        map.addAnnotation(label)
        map.setRegion(viewRegion, animated: false)
        map.layer.cornerRadius = 15
        return map
    }()
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = postData["street_name"] as? String
        label.font = UIFont.init(name: "SFPro-Bold", size: 19.0)
        return label
    }()
    
    let joinInViewButton: ButtonView = {
        let view = ButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = MainConstants.orange.cgColor
        return view
    }()
    
    let discussLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "Обсудить"
        label.font = UIFont.init(name: "SFPro-Heavy", size: 24.0)
        return label
    }()
    
    lazy var discussTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = MainConstants.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentSize = CGSize(width: MainConstants.screenWidth, height: 250)
        table.frame = table.bounds
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        table.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        return table
    }()
    
    lazy var commentField: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        view.autocorrectionType = .yes
        view.backgroundColor = MainConstants.nearWhite
        view.textColor = MainConstants.nearBlack
        view.isScrollEnabled = true
        view.delegate = self
        view.textContainerInset = UIEdgeInsets(top: 6, left: 5, bottom: 6, right: 50)
        return view
    }()

    lazy var sendView: UIView = {
        let scale = 0.85 * (commentField.textContainerInset.top + commentField.textContainerInset.bottom + commentField.font!.lineHeight)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        view.layer.cornerRadius = scale/2
        return view
    }()
    
    lazy var imageInsideSendView: UIImageView = {
        let scale: CGFloat = sendView.frame.height * 0.8
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale*0.9))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "paperplane.fill")
        image.tintColor = MainConstants.white
        return image
    }()
    
    var postData: Dictionary<String, Any> = [:]
    var messagesData: Array<Dictionary<String, Any>> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMassages()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
        CheckIfJoin(userId: UserDefaults.standard.string(forKey: "uid")!, meetingId: postData["mid"] as! String)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ReloadTableHeight), userInfo: nil, repeats: false)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("Open keyboard")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.keyboardSize = keyboardSize.height
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("Close keyboard")
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            let setHeight = commentField.frame.maxY
            if MainConstants.screenHeight > 700{
                scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight+30)
            } else {
                scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight+10)
            }
        }
    }
    

    
    
    @objc func ReloadTableHeight() {
        print("Timer fired!")
        var tableViewHeight: CGFloat {
            discussTable.layoutIfNeeded()
            return discussTable.contentSize.height
        }
        print("Table view height: \(tableViewHeight)")
        let setHeight = discussTable.frame.minY + tableViewHeight + commentHeightConstraint.constant + 15
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight)
        tableHeightConstraint.constant = tableViewHeight
        discussTable.layoutIfNeeded()
    }
    
    
    @objc func OpenReply(){
        print("Open reply with index")
    }
    
    
    func SetHeightOfComment(rows: Int){
        guard rows<6 else {return}
        if rows == numberOfRows{
            return
        } else {
            numberOfRows = rows
            let lineHeight = UIFont.preferredFont(forTextStyle: .body).lineHeight
            let containerTopBottom = commentField.textContainerInset.top + commentField.textContainerInset.bottom
            commentHeightConstraint.constant = lineHeight*CGFloat(rows)+containerTopBottom
            print("Comment height constant: \(commentHeightConstraint.constant)")
            commentField.layoutIfNeeded()

            let setHeight = commentField.frame.maxY
            print("Set height: \(setHeight)")
            let scrollTo = setHeight - MainConstants.screenHeight + lineHeight
            scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight)
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollTo), animated: true)
        }
    }
    
    
    fileprivate func GetMassages(){
        Server.GetMessages(meetingId: postData["mid"] as! String, messages: { result in
            self.messagesData = result
            self.discussTable.reloadData()
            self.ReloadTableHeight()
        })
    }
    
    
    fileprivate func CheckIfJoin(userId uid: String, meetingId mid: String) {
        guard (postData["joined"] != nil) else { return }
        let arr = postData["joined"] as! Array<String>
        guard (arr.contains(uid)) else { return }
        print("User joined")
        joinHeightConstraint?.constant = 0
        joinInViewButton.layoutIfNeeded()
        joinInViewButton.isHidden = true
    }
    
    
    @objc func JoinInAction(){
        print("Joined in")
        Vibration.Soft()
        let uid: String = UserDefaults.standard.string(forKey: "uid")!
        Server.JoinMeeting(withUserId: uid, meetingId: postData["mid"] as! String, andType: "join")
        guard (postData["joined"] != nil) else {
            postData.merge(dict: ["joined": [uid]])
            CheckIfJoin(userId: uid, meetingId: postData["mid"] as! String)
            return
        }
        var arr = postData["joined"] as! Array<String>
        guard (arr.contains(uid)) else {
            arr.append(uid)
            postData.merge(dict: ["joined": arr])
            CheckIfJoin(userId: uid, meetingId: postData["mid"] as! String)
            return }
    }
    
    
    @objc func SendAction(){
        print("Sended")
        Vibration.Light()
        let uid: String = UserDefaults.standard.string(forKey: "uid")!
        Server.SendMessage(user: uid,
                           meetingId: postData["mid"] as! String,
                           massageText: commentField.text ?? "")
        commentField.endEditing(true)
        commentField.text = ""
    }

}






extension MeetingViewController: myTableDelegate {
    func myTableDelegate(commentIndex: Int){
        print("Open reply view controller")
    }
}








extension MeetingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Add empty state.
        print("Messages count: \(messagesData.count)")
        return messagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = messagesData[indexPath.row]
        print("Message data: \(data)")
        let cell: MessageCell = ReturnMessageCell(withIndexPath: indexPath, andData: data)
        return cell
    }
    
    
    func ReturnMessageCell(withIndexPath indexPath: IndexPath, andData data: Dictionary<String, Any>) -> MessageCell{
        let cell: MessageCell = discussTable.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.contentView.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.delegate = self
        cell.isUserInteractionEnabled = true
        cell.messageLabel.text = data["text"] as? String
        cell.dataLabel.text = data["date"] as? String
        cell.nameLabel.text = data["username"] as? String
        DispatchQueue.main.async {
            cell.profileImage.downloadImage(from: data["image"] as? String)
        }
        cell.commentIndex = indexPath.row
        return cell
    }
}







extension MeetingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let numberOfLines = Int(commentField.contentSize.height/(textView.font!.lineHeight))
        SetHeightOfComment(rows: numberOfLines)
    }
}







extension MeetingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            discussTable.isScrollEnabled = (self.scrollView.contentOffset.y >=  discussTable.frame.minY)
            backView.isHidden = (self.scrollView.contentOffset.y < titleName.frame.maxY)
        }
        if scrollView == self.discussTable {
            discussTable.isScrollEnabled = (discussTable.contentOffset.y > 0)
        }
    }
}





extension MeetingViewController: BackTopDelegate {
    @objc func Back(){
        Vibration.Soft()
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}





extension MeetingViewController {
    
    func SetSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(back)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(profileName)
        scrollView.addSubview(titleName)
        scrollView.addSubview(timeAndDataLabel)
        scrollView.addSubview(desc)
        scrollView.addSubview(threeImagesView)
        scrollView.addSubview(whoIsJoined)
        scrollView.addSubview(whereLabel)
        scrollView.addSubview(meetingLocation)
        scrollView.addSubview(adressLabel)
        scrollView.addSubview(joinInViewButton)
        scrollView.addSubview(discussLabel)
        scrollView.addSubview(discussTable)
        scrollView.addSubview(commentField)
        scrollView.addSubview(sendView)
        sendView.addSubview(imageInsideSendView)
        
        sendView.bringSubviewToFront(imageInsideSendView)
        
        view.addSubview(backView)
        
        back.addTarget(self, action: #selector(Back), for: .touchUpInside)
        joinInViewButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(JoinInAction)))
        sendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SendAction)))
    }
    
    func ActivateLayouts(){
        let topHeightConst: CGFloat = {if MainConstants.screenHeight>700 {return 90} else {return 70}}()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            back.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width),
            
            profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            profileImage.leftAnchor.constraint(equalTo: back.rightAnchor, constant: 15),
            profileImage.heightAnchor.constraint(equalToConstant: profileImage.frame.height),
            profileImage.widthAnchor.constraint(equalToConstant: profileImage.frame.width),
            
            profileName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
            
            titleName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            titleName.leftAnchor.constraint(equalTo: back.leftAnchor),
            
            timeAndDataLabel.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 4),
            timeAndDataLabel.leftAnchor.constraint(equalTo: back.leftAnchor),
            
            desc.topAnchor.constraint(equalTo: timeAndDataLabel.bottomAnchor, constant: 24),
            desc.leftAnchor.constraint(equalTo: back.leftAnchor),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            threeImagesView.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 24),
            threeImagesView.leftAnchor.constraint(equalTo: back.leftAnchor),
            threeImagesView.heightAnchor.constraint(equalToConstant: threeImagesView.frame.height),
            threeImagesView.widthAnchor.constraint(equalToConstant: threeImagesView.frame.width),
            
            whoIsJoined.centerYAnchor.constraint(equalTo: threeImagesView.centerYAnchor),
            whoIsJoined.leftAnchor.constraint(equalTo: threeImagesView.rightAnchor, constant: 6),
            
            whereLabel.topAnchor.constraint(equalTo: threeImagesView.bottomAnchor, constant: 35),
            whereLabel.leftAnchor.constraint(equalTo: back.leftAnchor),
            
            meetingLocation.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 10),
            meetingLocation.leftAnchor.constraint(equalTo: view.leftAnchor),
            meetingLocation.rightAnchor.constraint(equalTo: view.rightAnchor),
            meetingLocation.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight*3/5),
            
            adressLabel.topAnchor.constraint(equalTo: meetingLocation.bottomAnchor, constant: 7),
            adressLabel.leftAnchor.constraint(equalTo: back.leftAnchor),
           
//            joinInViewButton height constraint on the bottom of the function.
            joinInViewButton.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 30),
            joinInViewButton.leftAnchor.constraint(equalTo: desc.leftAnchor),
            joinInViewButton.rightAnchor.constraint(equalTo: desc.rightAnchor),
            
            discussLabel.topAnchor.constraint(equalTo: joinInViewButton.bottomAnchor, constant: 35),
            discussLabel.leftAnchor.constraint(equalTo: back.leftAnchor),

//            discussTable height constraint on the bottom of the function.
            discussTable.topAnchor.constraint(equalTo: discussLabel.bottomAnchor, constant: 5),
            discussTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            discussTable.rightAnchor.constraint(equalTo: view.rightAnchor),
           
//            commentField height constraint on the bottom of the function.
            commentField.topAnchor.constraint(equalTo: discussTable.bottomAnchor, constant: 6),
            commentField.leftAnchor.constraint(equalTo: back.leftAnchor),
            commentField.rightAnchor.constraint(equalTo: desc.rightAnchor),
            
            sendView.rightAnchor.constraint(equalTo: commentField.rightAnchor, constant: -4),
            sendView.bottomAnchor.constraint(equalTo: commentField.bottomAnchor, constant: -4),
            sendView.heightAnchor.constraint(equalToConstant: sendView.frame.height),
            sendView.widthAnchor.constraint(equalToConstant: sendView.frame.width),

            imageInsideSendView.centerXAnchor.constraint(equalTo: sendView.centerXAnchor, constant: -1),
            imageInsideSendView.centerYAnchor.constraint(equalTo: sendView.centerYAnchor),
            imageInsideSendView.heightAnchor.constraint(equalToConstant: imageInsideSendView.frame.height),
            imageInsideSendView.widthAnchor.constraint(equalToConstant: imageInsideSendView.frame.width),
            
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backView.heightAnchor.constraint(equalToConstant: topHeightConst),
        ])
        
        let lineHeight = commentField.font!.lineHeight
        let containerTopBottom = commentField.textContainerInset.top + commentField.textContainerInset.bottom + 3
        
        tableHeightConstraint = discussTable.heightAnchor.constraint(equalToConstant: 250)
        joinHeightConstraint = joinInViewButton.heightAnchor.constraint(equalToConstant: 60)
        commentHeightConstraint = commentField.heightAnchor.constraint(equalToConstant: lineHeight+containerTopBottom)
        tableHeightConstraint.isActive = true
        joinHeightConstraint?.isActive = true
        commentHeightConstraint.isActive = true
    }
}
