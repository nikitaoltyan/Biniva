//
//  ChangeButtonsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit

class ChangeButtonsController: UIViewController{

    var back: UIButton!
    var mainTitle: UILabel!
    var normalTitle: UILabel!
    var textView: UITextView!
    var buttonsTitle: UILabel!
    var desc: UILabel!
    
    var firstView: UIView!
    var secondView: UIView!
    var thirdView: UIView!
    var firstImage: UIImageView!
    var secondImage: UIImageView!
    var thirdImage: UIImageView!
    
    @IBOutlet weak var changeButtonView: ChangeButtonView!
    @IBOutlet weak var collection: UICollectionView!
    
    let collectionHeight = 650 as CGFloat
    var materials = [MaterialsObject]()
    
    override func viewDidLoad() {
        changeButtonView.isHidden = true
        view.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        BackButton()
        TitleLayer()
        NormalTitleLayer()
        TextLayer()
        ChangeButtonTitle()
        SetThreeButtons()
        AddCustomPickerView()
        PopulateMaterialsObject()
        Description()
    }

    @objc func BackAction(sender: UIButton!) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    @objc func ActivateCustomView(){
        changeButtonView.center.y = UIScreen.main.bounds.height + collectionHeight/2 - 25
        changeButtonView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.changeButtonView?.center.y -= self.collectionHeight-20
        }, completion: { finished in
            print("Animation completed")
        })
    }
    
    @objc func dismissView(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .down:
                UIView.animate(withDuration: 0.28, delay: 0, options: .curveEaseOut, animations: {
                    self.changeButtonView.center.y += self.collectionHeight-20
                }, completion: { finished in
                    self.changeButtonView.isHidden = true
                })
            default:
                return
            }
        }
    }
    
    func PopulateMaterialsObject(){
        for count in 0...MaterialsObjectItems.color.count-1 {
            let toList = MaterialsObject()
            toList.color = MaterialsObjectItems.color[count]
            toList.image = MaterialsObjectItems.image[count]
            toList.name = MaterialsObjectItems.name[count]
            materials.append(toList)
        }
        collection.reloadData()
    }

}


extension ChangeButtonsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: collectionHeight-40)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ButtonImageCell = collection.dequeueReusableCell(withReuseIdentifier: "ButtonImageCell", for: indexPath) as! ButtonImageCell
        cell.bgView.backgroundColor = materials[indexPath.row].color
        cell.icon.image = materials[indexPath.row].image
        TextFieldLayer(mainView: cell)
        return cell
    }
    
}

extension ChangeButtonsController {
    
    func BackButton(){
        let backButton = UIButton()
        backButton.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        view.addSubview(backButton)
        let useImage = UIImage(systemName: "chevron.left")
        backButton.setImage(useImage, for: .normal)
        back = backButton
        back.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            back.heightAnchor.constraint(equalToConstant: 30),
            back.widthAnchor.constraint(equalToConstant: 30)
        ])
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    func TitleLayer(){
        let title = UILabel()
        view.addSubview(title)
        mainTitle = title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            mainTitle.leftAnchor.constraint(equalTo: back.rightAnchor, constant: 8),
            mainTitle.heightAnchor.constraint(equalToConstant: 30),
            mainTitle.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        mainTitle.text = "Изменить кнопки"
        mainTitle.font = UIFont.init(name: "Palatino-Bold", size: 33.0)
        mainTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func NormalTitleLayer(){
        let title = UILabel()
        view.addSubview(title)
        normalTitle = title
        normalTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            normalTitle.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 55),
            normalTitle.leftAnchor.constraint(equalTo: back.leftAnchor),
            normalTitle.heightAnchor.constraint(equalToConstant: 30),
            normalTitle.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        normalTitle.text = "Изменить ежедневную норму"
        normalTitle.font = UIFont.init(name: "SFPro-Medium", size: 22.0)
        normalTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func TextLayer(){
        let field = UITextView()
        view.addSubview(field)
        textView = field
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: normalTitle.bottomAnchor, constant: 15),
            textView.leftAnchor.constraint(equalTo: normalTitle.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 50)
        ])
        textView.font = UIFont.preferredFont(forTextStyle: .title2)
        textView.text = "200"
        textView.layer.cornerRadius = 5
        textView.autocorrectionType = .yes
        textView.keyboardType = .numberPad
        textView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        textView.textColor = .darkGray
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 10)

    }
    
    func ChangeButtonTitle(){
        let title = UILabel()
        view.addSubview(title)
        buttonsTitle = title
        buttonsTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsTitle.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 55),
            buttonsTitle.leftAnchor.constraint(equalTo: back.leftAnchor),
            buttonsTitle.heightAnchor.constraint(equalToConstant: 30),
            buttonsTitle.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        buttonsTitle.text = "Изменить быстрые кнопки"
        buttonsTitle.font = UIFont.init(name: "SFPro-Medium", size: 23.0)
        buttonsTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func SetThreeButtons(){
        let scale = 100 as CGFloat
        
        let firstView = UIView()
        view.addSubview(firstView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: buttonsTitle.bottomAnchor, constant: 18),
            firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -125),
            firstView.heightAnchor.constraint(equalToConstant: scale),
            firstView.widthAnchor.constraint(equalToConstant: scale)
        ])
        firstView.layer.masksToBounds = true
        firstView.layer.cornerRadius = scale/4
        firstView.isUserInteractionEnabled = true
        firstView.backgroundColor = MaterialsColors.waterBlue
        self.firstView = firstView
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateCustomView)))
        
        let firstImage = UIImageView()
        firstView.addSubview(firstImage)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 10),
            firstImage.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -10),
            firstImage.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 10),
            firstImage.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -10)
        ])
        firstImage.image = MaterialsIcons.waterBottle
        self.firstImage = firstImage
        
        let secondView = UIView()
        view.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: firstView.topAnchor),
            secondView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondView.heightAnchor.constraint(equalToConstant: scale),
            secondView.widthAnchor.constraint(equalToConstant: scale)
        ])
        secondView.layer.masksToBounds = true
        secondView.layer.cornerRadius = scale/4
        secondView.isUserInteractionEnabled = true
        secondView.backgroundColor = MaterialsColors.paperOrange
        self.secondView = secondView
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateCustomView)))
        
        let secondImage = UIImageView()
        secondView.addSubview(secondImage)
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 10),
            secondImage.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -10),
            secondImage.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 10),
            secondImage.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10)
        ])
        secondImage.image = MaterialsIcons.paper
        self.secondImage = secondImage
        
        
        let thirdView = UIView()
        view.addSubview(thirdView)
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdView.topAnchor.constraint(equalTo: firstView.topAnchor),
            thirdView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 125),
            thirdView.heightAnchor.constraint(equalToConstant: scale),
            thirdView.widthAnchor.constraint(equalToConstant: scale)
        ])
        thirdView.layer.masksToBounds = true
        thirdView.layer.cornerRadius = scale/4
        thirdView.isUserInteractionEnabled = true
        thirdView.backgroundColor = MaterialsColors.organicGreen
        self.thirdView = thirdView
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateCustomView)))
        
        let thirdImage = UIImageView()
        thirdView.addSubview(thirdImage)
        thirdImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdImage.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 10),
            thirdImage.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -10),
            thirdImage.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 10),
            thirdImage.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -10)
        ])
        thirdImage.image = MaterialsIcons.organicLimone
        self.thirdImage = thirdImage
    }
    
    func AddCustomPickerView(){
        view.bringSubviewToFront(changeButtonView)
        changeButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            changeButtonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            changeButtonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            changeButtonView.heightAnchor.constraint(equalToConstant: collectionHeight)
        ])
        changeButtonView.layer.cornerRadius = 20
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        changeButtonView?.addGestureRecognizer(swipeDown)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.leftAnchor.constraint(equalTo: changeButtonView.leftAnchor),
            collection.rightAnchor.constraint(equalTo: changeButtonView.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: changeButtonView.bottomAnchor),
            collection.topAnchor.constraint(equalTo: changeButtonView.topAnchor, constant: 20)
        ])
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = MainConstants.white
        collection.isPagingEnabled = true
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }
    
    func TextFieldLayer(mainView: UICollectionViewCell){
        let field = UITextView()
        mainView.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -50),
            field.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 30),
            field.widthAnchor.constraint(equalToConstant: 100),
            field.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        field.font = UIFont.preferredFont(forTextStyle: .body)
        field.layer.cornerRadius = 5
        field.autocorrectionType = .no
        field.backgroundColor = .red
        field.textColor = .darkGray
        field.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func Description(){
        let label: UILabel = {
            let label = UILabel()
            label.textColor = MainConstants.white
            label.numberOfLines = 0
            label.text = MainConstants.aboutChangingButtons
            label.font = UIFont.init(name: "SFPro", size: 14.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        view.addSubview(label)
        desc = label
        var const: Array<NSLayoutConstraint> = []
        const.append(contentsOf: [
            desc.topAnchor.constraint(equalTo: self.firstView.bottomAnchor, constant: 20),
            desc.leftAnchor.constraint(equalTo: self.firstView.leftAnchor),
            desc.rightAnchor.constraint(equalTo: self.thirdView.rightAnchor),
            desc.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        NSLayoutConstraint.activate(const)
    }
}
