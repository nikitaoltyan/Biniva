//
//  MeetingViewController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 06.12.2020.
//

import UIKit
import MapKit
import CoreLocation

class MeetingViewController: UIViewController {
    
    
    let scrollHeight = 1500 as CGFloat
    var tableHeightConstraint: NSLayoutConstraint!
    var commentHeightConstraint: NSLayoutConstraint!
    var numberOfRows = 1
    var keyboardSize: CGFloat?
    
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        return view
    }()
    
    let back: UIButton = {
        let button = UIButton()
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scrollView: UIScrollView!
    var profileImage: UIImageView!
    var profileName: UILabel!
    var titleName: UILabel!
    var timeAndDataLabel: UILabel!
    var desc: UILabel!
    var firstUserImage: UIImageView!
    var secondUserImage: UIImageView!
    var thirdUserImage: UIImageView!
    var whoIsJoined: UILabel!
    var whereLabel: UILabel!
    var meetingLocation: MKMapView!
    var adressLabel: UILabel!
    var joinInViewButton: UIView!
    var discussLabel: UILabel!
    let discussTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = MainConstants.white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentSize = CGSize(width: MainConstants.screenWidth, height: 250)
        table.frame = table.bounds
        table.showsVerticalScrollIndicator = true
        return table
    }()
    
    let commentField: UITextView = {
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
        view.textContainerInset = UIEdgeInsets(top: 6, left: 5, bottom: 6, right: 50)
        return view
    }()

    let sendView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        view.layer.cornerRadius = 25/2
        return view
    }()
    
    let imageInsideSendView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "paperplane.fill")
        image.tintColor = MainConstants.white
        return image
    }()
    
    let populate: Array<String> = ["Some custome message text.","Some custome message text Some custome message text Some custome message text."," ","Some custome message text","Some custome message text. Some custome message text. Some custome message text. \n\nSome custome message text. Some custome message text", "Some custome message text.","Some custome message text Some custome message text Some custome message text."," ","Some custome message text","Some custome message text. Some custome message text. Some custome message text. \n\nSome custome message text. Some custome message text"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
        _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        SetUpAllLayouts()
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
    
    
    override func viewDidLayoutSubviews() {
        print("Layout happened")
    }
    
    
    @objc func fireTimer() {
        print("Timer fired!")
        var tableViewHeight: CGFloat {
            discussTable.layoutIfNeeded()
            return discussTable.contentSize.height
        }
        let setHeight = discussTable.frame.minY + tableViewHeight + commentHeightConstraint.constant + 15
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight)
        tableHeightConstraint.constant = tableViewHeight
        discussTable.layoutIfNeeded()
    }
    
    
    @objc func OpenReply(){
        print("Open reply with index")
    }
    
    
    func SetHeightOfComment(rows: Int){
        print("Rows: \(rows)")
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
    
    
    @objc func JoinInAction(){
        print("Joined in")
        print(UIFont.preferredFont(forTextStyle: .body).lineHeight)
    }
    
    
    @objc func SendAction(){
        print("Sended")
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





extension MeetingViewController: myTableDelegate {
    
    func myTableDelegate(commentIndex: Int){
        print("My table delegate with index \(commentIndex)")
        
        let newVC = ReplyCommentController()
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






extension MeetingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return populate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageCell = discussTable.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = populate[indexPath.row]
        cell.contentView.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.delegate = self
        cell.isUserInteractionEnabled = true
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




extension MeetingViewController {
    
    func SetUpAllLayouts(){
        ScrollLayer()
        BackButtonLayer()
        ProfileImage()
        ProfileName()
        TitleNameLayer()
        TimeAndDataLayer()
        DescriptionLayer()
        ThreeUserImages()
        WhoIsJoinedLayer()
        WhereLabelLayer()
        CreateMap()
        AdressLayer()
        JoinInLayer()
        DiscusLayer()
        DiscussTable()
        CommentFieldLayer()
        SendViewLayer()
        BackViewLayer()
    }
    
    func BackViewLayer(){
        view.addSubview(backView)
        
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "Big Title Name"
            label.font = UIFont.init(name: "SFPro-Heavy", size: 30.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        backView.addSubview(label)
        
        let back: UIButton = {
            let button = UIButton()
            button.tintColor = MainConstants.nearBlack
            button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        backView.addSubview(back)
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
        
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                backView.topAnchor.constraint(equalTo: view.topAnchor),
                backView.leftAnchor.constraint(equalTo: view.leftAnchor),
                backView.rightAnchor.constraint(equalTo: view.rightAnchor),
                backView.heightAnchor.constraint(equalToConstant: 90),
                
                back.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 20),
                back.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 15),
                back.heightAnchor.constraint(equalToConstant: 30),
                back.widthAnchor.constraint(equalToConstant: 30),
                
                label.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 20),
                label.leftAnchor.constraint(equalTo: back.rightAnchor, constant: 15)
            ])
        } else {
            const.append(contentsOf: [
                backView.topAnchor.constraint(equalTo: view.topAnchor),
                backView.leftAnchor.constraint(equalTo: view.leftAnchor),
                backView.rightAnchor.constraint(equalTo: view.rightAnchor),
                backView.heightAnchor.constraint(equalToConstant: 70),
                
                back.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 12),
                back.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 15),
                back.heightAnchor.constraint(equalToConstant: 30),
                back.widthAnchor.constraint(equalToConstant: 30),
                
                label.centerYAnchor.constraint(equalTo: back.centerYAnchor),
                label.leftAnchor.constraint(equalTo: back.rightAnchor, constant: 15)
            ])
        }
        NSLayoutConstraint.activate(const)
    }
    
    func ScrollLayer(){
        let scroll: UIScrollView = {
            let scroll = UIScrollView()
            scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: scrollHeight)
            scroll.delegate = self
            scroll.bounces = false
            scroll.showsVerticalScrollIndicator = true
            scroll.translatesAutoresizingMaskIntoConstraints = false
            return scroll
        }()
        scrollView = scroll
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func BackButtonLayer(){
        scrollView.addSubview(back)
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            back.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            back.heightAnchor.constraint(equalToConstant: 30),
            back.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate(const)
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    func ProfileImage(){
        let scale = 37 as CGFloat
        let image: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
            image.layer.masksToBounds = true
            image.layer.cornerRadius = scale/2
            return image
        }()
        scrollView.addSubview(image)
        profileImage = image
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
            profileImage.leftAnchor.constraint(equalTo: back.rightAnchor, constant: 15),
            profileImage.heightAnchor.constraint(equalToConstant: scale),
            profileImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func ProfileName(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "@nikitaoltyan"
            label.font = UIFont.init(name: "SFPro-Bold", size: 22.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        profileName = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            profileName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
            profileName.heightAnchor.constraint(equalToConstant: 40),
            profileName.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func TitleNameLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "Big Title Name"
            label.font = UIFont.init(name: "SFPro-Heavy", size: 30.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        titleName = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            titleName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            titleName.leftAnchor.constraint(equalTo: back.leftAnchor),
            titleName.heightAnchor.constraint(equalToConstant: 45),
            titleName.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func TimeAndDataLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "19:00,  1 November"
            label.font = UIFont.init(name: "SFPro-Bold", size: 19.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        timeAndDataLabel = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            timeAndDataLabel.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 4),
            timeAndDataLabel.leftAnchor.constraint(equalTo: back.leftAnchor),
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func DescriptionLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.numberOfLines = 0
            label.text = "Some big description custome text. Some big description custome text. Some big description custome text. Some big description custome text. Some big description custome text. Some big description custome text. \n\nSome big description custome text. Some big description custome text. Some big description custome text. Some big description custome text. "
            label.font = UIFont.init(name: "SFPro", size: 16.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        desc = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            desc.topAnchor.constraint(equalTo: timeAndDataLabel.bottomAnchor, constant: 24),
            desc.leftAnchor.constraint(equalTo: back.leftAnchor),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func ThreeUserImages(){
        let scale = 25 as CGFloat
        let imageOne: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.borderWidth = 1
            image.layer.borderColor = MainConstants.white.cgColor
            image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
            image.layer.masksToBounds = true
            image.layer.cornerRadius = scale/2
            return image
        }()
        scrollView.addSubview(imageOne)
        firstUserImage = imageOne
        
        let imageTwo: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.borderWidth = 1
            image.layer.borderColor = MainConstants.white.cgColor
            image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
            image.layer.masksToBounds = true
            image.layer.cornerRadius = scale/2
            return image
        }()
        scrollView.addSubview(imageTwo)
        secondUserImage = imageTwo
        
        let imageThree: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.borderWidth = 1
            image.layer.borderColor = MainConstants.white.cgColor
            image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
            image.layer.masksToBounds = true
            image.layer.cornerRadius = scale/2
            return image
        }()
        scrollView.addSubview(imageThree)
        thirdUserImage = imageThree
        
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            firstUserImage.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 24),
            firstUserImage.leftAnchor.constraint(equalTo: back.leftAnchor),
            firstUserImage.heightAnchor.constraint(equalToConstant: scale),
            firstUserImage.widthAnchor.constraint(equalToConstant: scale),
            
            secondUserImage.topAnchor.constraint(equalTo: firstUserImage.topAnchor),
            secondUserImage.leftAnchor.constraint(equalTo: firstUserImage.centerXAnchor, constant: 5),
            secondUserImage.heightAnchor.constraint(equalToConstant: scale),
            secondUserImage.widthAnchor.constraint(equalToConstant: scale),
            
            thirdUserImage.topAnchor.constraint(equalTo: firstUserImage.topAnchor),
            thirdUserImage.leftAnchor.constraint(equalTo: secondUserImage.centerXAnchor, constant: 5),
            thirdUserImage.heightAnchor.constraint(equalToConstant: scale),
            thirdUserImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func WhoIsJoinedLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "vostogor +19 others joined"
            label.font = UIFont.init(name: "SFPro-Medium", size: 16.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        whoIsJoined = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            whoIsJoined.centerYAnchor.constraint(equalTo: firstUserImage.centerYAnchor),
            whoIsJoined.leftAnchor.constraint(equalTo: thirdUserImage.rightAnchor, constant: 6),
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func WhereLabelLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "Где?"
            label.font = UIFont.init(name: "SFPro-Heavy", size: 24.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        whereLabel = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            whereLabel.topAnchor.constraint(equalTo: firstUserImage.bottomAnchor, constant: 35),
            whereLabel.leftAnchor.constraint(equalTo: back.leftAnchor)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func CreateMap(){
        let map: MKMapView = {
            let map = MKMapView()
            map.translatesAutoresizingMaskIntoConstraints = false
            map.isUserInteractionEnabled = true
            let coordinate = CLLocationCoordinate2D(latitude: 55.740897, longitude: 37.598034)
            let london = Capital(title: "Остоженка", coordinate: coordinate, info: "Home to the 2012 Summer Olympics.")
            map.addAnnotation(london)
            let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 900, longitudinalMeters: 900)
            map.setRegion(viewRegion, animated: false)
            map.layer.cornerRadius = 15
            return map
        }()
        scrollView.addSubview(map)
        meetingLocation = map
        
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            meetingLocation.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 10),
            meetingLocation.leftAnchor.constraint(equalTo: view.leftAnchor),
            meetingLocation.rightAnchor.constraint(equalTo: view.rightAnchor),
            meetingLocation.heightAnchor.constraint(equalToConstant: MainConstants.screenHeight*3/5)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func AdressLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "Остоженка 12"
            label.font = UIFont.init(name: "SFPro-Bold", size: 19.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        adressLabel = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            adressLabel.topAnchor.constraint(equalTo: meetingLocation.bottomAnchor, constant: 7),
            adressLabel.leftAnchor.constraint(equalTo: back.leftAnchor),
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func JoinInLayer(){
        let view: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = MainConstants.orange
            view.layer.cornerRadius = 15
            view.clipsToBounds = true
            view.layer.masksToBounds = false
            view.layer.shadowRadius = 7
            view.layer.shadowOpacity = 0.3
            view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
            view.layer.shadowColor = UIColor.darkGray.cgColor
            return view
        }()
        scrollView.addSubview(view)
        joinInViewButton = view
        joinInViewButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(JoinInAction)))
        
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.white
            label.text = "Присоедениться"
            label.font = UIFont.init(name: "SFPro-Bold", size: 25.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        joinInViewButton.addSubview(label)
        
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            joinInViewButton.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 30),
            joinInViewButton.leftAnchor.constraint(equalTo: desc.leftAnchor),
            joinInViewButton.rightAnchor.constraint(equalTo: desc.rightAnchor),
            joinInViewButton.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerXAnchor.constraint(equalTo: joinInViewButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: joinInViewButton.centerYAnchor)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func DiscusLayer(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.nearBlack
            label.text = "Обсудить"
            label.font = UIFont.init(name: "SFPro-Heavy", size: 24.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        scrollView.addSubview(label)
        discussLabel = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            discussLabel.topAnchor.constraint(equalTo: joinInViewButton.bottomAnchor, constant: 35),
            discussLabel.leftAnchor.constraint(equalTo: back.leftAnchor)
        ])
        NSLayoutConstraint.activate(const)
    }
    
    func DiscussTable(){
        scrollView.addSubview(discussTable)
        discussTable.delegate = self
        discussTable.dataSource = self
        discussTable.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        var const: Array<NSLayoutConstraint> = []
        tableHeightConstraint = discussTable.heightAnchor.constraint(equalToConstant: 250)
        const.append(contentsOf: [
            discussTable.topAnchor.constraint(equalTo: discussLabel.bottomAnchor, constant: 5),
            discussTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            discussTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableHeightConstraint.isActive = true
        NSLayoutConstraint.activate(const)
    }
    
    func CommentFieldLayer(){
        scrollView.addSubview(commentField)
        commentField.delegate = self
        let lineHeight = commentField.font!.lineHeight
        print(lineHeight)
        let containerTopBottom = commentField.textContainerInset.top + commentField.textContainerInset.bottom
        var const: Array<NSLayoutConstraint> = []
        commentHeightConstraint = commentField.heightAnchor.constraint(equalToConstant: lineHeight+containerTopBottom)
        const.append(contentsOf: [
            commentField.topAnchor.constraint(equalTo: discussTable.bottomAnchor, constant: 6),
            commentField.leftAnchor.constraint(equalTo: back.leftAnchor),
            commentField.rightAnchor.constraint(equalTo: desc.rightAnchor),
        ])
        commentHeightConstraint.isActive = true
        NSLayoutConstraint.activate(const)
    }
    
    func SendViewLayer(){
        scrollView.addSubview(sendView)
        sendView.addSubview(imageInsideSendView)
        let containerRight = commentField.textContainerInset.right
        let height = commentField.textContainerInset.top + commentField.textContainerInset.bottom + commentField.font!.lineHeight
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            sendView.centerXAnchor.constraint(equalTo: commentField.rightAnchor, constant: -containerRight/2),
            sendView.centerYAnchor.constraint(equalTo: commentField.centerYAnchor),
            sendView.heightAnchor.constraint(equalToConstant: height*0.85),
            sendView.widthAnchor.constraint(equalToConstant: height*0.85),

            imageInsideSendView.centerXAnchor.constraint(equalTo: sendView.centerXAnchor, constant: -1),
            imageInsideSendView.centerYAnchor.constraint(equalTo: sendView.centerYAnchor),
            imageInsideSendView.heightAnchor.constraint(equalToConstant: height*0.85*0.76),
            imageInsideSendView.widthAnchor.constraint(equalToConstant: height*0.85*0.96),
        ])
        NSLayoutConstraint.activate(const)
        sendView.bringSubviewToFront(imageInsideSendView)
        sendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SendAction)))
    }
}
