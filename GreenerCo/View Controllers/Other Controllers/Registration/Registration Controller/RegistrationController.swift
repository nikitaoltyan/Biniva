//
//  RegistrationController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class RegistrationController: UIViewController {

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let topConst: CGFloat = {if MainConstants.screenHeight>700{return 57}else{return 10}}()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth,
                                                        height: MainConstants.screenHeight-topConst),
                                          collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.isScrollEnabled = true
        collection.backgroundColor = MainConstants.white
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(TextFieldCell.self, forCellWithReuseIdentifier: "TextFieldCell")
        collection.register(AddPhotoCell.self, forCellWithReuseIdentifier: "AddPhotoCell")
        collection.register(AddGoalCell.self, forCellWithReuseIdentifier: "AddGoalCell")
        
        return collection
    }()
    
    var dataDictonary: Dictionary<String, Any> = [:]
    var avatarImage: UIImage?
//    var setPhotoDelegate: AddPhotoDelegate?
    
    let mainLabels: Array<String> = ["Please, enter your Email",
                                     "Please, enter your Password",
                                     "Please, enter your Username",
                                     "Please, take a Photo",
                                     "Set your daily trash level"]
    let placeholders: Array<String> = ["Email",
                                       "Password",
                                       "Name"]
    let explanations: Array<String> = ["This is how we will identify you and how you can log in. You will not be able to change it.",
                                       "This is how you can log in. You will be able to change it.",
                                       "This is how Users will identify you. You will not be able to change it."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }

}





extension RegistrationController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.cellNumber = indexPath.row
            cell.mainLabel.text = mainLabels[indexPath.row]
            cell.textField.placeholder = placeholders[indexPath.row]
            cell.textField.keyboardType = .emailAddress
            cell.explainLabel.text = explanations[indexPath.row]
            cell.delegate = self
            return cell
        case 1:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.cellNumber = indexPath.row
            cell.mainLabel.text = mainLabels[indexPath.row]
            cell.textField.placeholder = placeholders[indexPath.row]
            cell.explainLabel.text = explanations[indexPath.row]
            cell.delegate = self
            return cell
        case 2:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.cellNumber = indexPath.row
            cell.mainLabel.text = mainLabels[indexPath.row]
            cell.textField.placeholder = placeholders[indexPath.row]
            cell.explainLabel.text = explanations[indexPath.row]
            cell.delegate = self
            return cell
        case 3:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath) as! AddPhotoCell
            cell.cellNumber = indexPath.row
            cell.mainLabel.text = mainLabels[indexPath.row]
            if avatarImage != nil {
                cell.avatar.image = avatarImage
                cell.nextButton.isActive = true
            }
            cell.delegate = self
            return cell
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "AddGoalCell", for: indexPath) as! AddGoalCell
            cell.cellNumber = indexPath.row
            cell.mainLabel.text = mainLabels[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
}






extension RegistrationController: RegistrationDelegate {
    
    func Scroll(slide: Int) {
        Vibration.Soft()
        let indexPath = IndexPath(item: slide, section: 0)
        collection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    func Back() {
        Vibration.Soft()
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    
    func PassEmail(email: Dictionary<String, String>) {
        dataDictonary.merge(dict: email)
    }
    
    func PassPassword(password: Dictionary<String, String>) {
        dataDictonary.merge(dict: password)
    }
    
    func PassUsername(username: Dictionary<String, String>) {
        dataDictonary.merge(dict: username)
    }
    
    func PickerController() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
}






extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImage = info[.editedImage] as? UIImage
        collection.reloadItems(at: [IndexPath(item: 3, section: 0)])
        self.dismiss(animated: true, completion: nil)
    }
}





extension RegistrationController {
    
    func SetSubviews(){
        view.addSubview(collection)
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            collection.leftAnchor.constraint(equalTo: view.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.heightAnchor.constraint(equalToConstant: collection.frame.height)
        ])
    }
}





protocol RegistrationDelegate {
    func Scroll(slide: Int)
    func Back()
    func PassEmail(email: Dictionary<String, String>)
    func PassPassword(password: Dictionary<String, String>)
    func PassUsername(username: Dictionary<String, String>)
    func PickerController()
}
