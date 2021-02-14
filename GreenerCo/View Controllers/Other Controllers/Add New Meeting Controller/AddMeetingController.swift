//
//  AddMeetingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 28.12.2020.
//

import UIKit

class AddMeetingController: UIViewController {

    lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.isScrollEnabled = false
        
        collection.register(AddMapCell.self, forCellWithReuseIdentifier: "AddMapCell")
        collection.register(AddOtherCell.self, forCellWithReuseIdentifier: "AddOtherCell")
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = MainConstants.white
        return collection
    }()
    
    lazy var topView: TopProgressView = {
        let view = TopProgressView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.delegate = self
        view.slide = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.borderColor = MainConstants.nearWhite.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    let numberOfSlides: Int = 2
    var keyboardSize: CGFloat?
    
    var place: String?
    var date: String?
    var time: String?
    var header: String?
    var desc: String?
    
    var dataDictonary: Dictionary<String, Any> = ["user_id": UserDefaults.standard.string(forKey: "uid") as Any]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        SetSubviews()
        ActivateLayouts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
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
        }
    }

    func ShowPopUpController() {
        sleep(1)
        let newVC = PopUpController()
        newVC.modalPresentationStyle = .overFullScreen
        self.present(newVC, animated: false, completion: nil)
    }
}





extension AddMeetingController: TopProgressDelegate {
    
    func CloseView() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    func Scroll(slide: Int){
        let indexPath = IndexPath(item: slide, section: 0)
        mainCollection.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
}





extension AddMeetingController: PassDataDelegate {
    func PassDate(date: Dictionary<String, String>) {
        dataDictonary.merge(dict: date)
    }
    
    func PassTime(time: Dictionary<String, String>) {
        dataDictonary.merge(dict: time)
    }
    
    func PassHeader(header: Dictionary<String, String>) {
        dataDictonary.merge(dict: header)
    }
    
    func PassDesc(desc: Dictionary<String, String>) {
        dataDictonary.merge(dict: desc)
    }
    
    func PassStreetName(streetName: Dictionary<String, String>) {
        dataDictonary.merge(dict: streetName)
    }
    
    func PassCoordinates(coord: Dictionary<String, Array<CGFloat>>) {
        dataDictonary.merge(dict: coord)
    }
    
    func CloseKeyboard() {
        
    }
}





extension AddMeetingController: AddMeetingSendDelegate {
    func Send() {
        print("Create meeting")
        let uid: String = UserDefaults.standard.string(forKey: "uid")!
        Server.CreateMeeting(withData: dataDictonary, andUserId: uid)
        
        tabBarController?.selectedIndex = 2
        DispatchQueue.main.async { self.ShowPopUpController() }
    }
}





extension AddMeetingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfSlides
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = CGSize(width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "AddMapCell", for: indexPath) as! AddMapCell
            cell.delegate = self
            return cell
        default:
            let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "AddOtherCell", for: indexPath) as! AddOtherCell
            cell.delegate = self
            cell.sendDelegate = self
            return cell
        }
    }

}





extension AddMeetingController {
    
    func SetSubviews(){
        view.addSubview(mainCollection)
        view.addSubview(topView)
        
    }
    
    
    func ActivateLayouts(){
        let topViewHeight: CGFloat = {if MainConstants.screenHeight>700{return 90}else{return 75}}()
        NSLayoutConstraint.activate([
            mainCollection.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: topViewHeight)
        ])
    }
}





protocol TopProgressDelegate {
    func CloseView()
    func Scroll(slide: Int)
}





protocol PassDataDelegate {
    func PassStreetName(streetName: Dictionary<String, String>)
    func PassDate(date: Dictionary<String, String>)
    func PassTime(time: Dictionary<String, String>)
    func PassHeader(header: Dictionary<String, String>)
    func PassDesc(desc: Dictionary<String, String>)
    func PassCoordinates(coord: Dictionary<String, Array<CGFloat>>)
    func CloseKeyboard()
}





protocol AddMeetingSendDelegate {
    func Send()
}
