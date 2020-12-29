//
//  ButtonImageCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit

class ButtonImageCell: UICollectionViewCell {
    
    var bgView: UIView!
    var icon: UIImageView!
    var changeColorView: UIView!
    var changeIconView: UIView!
    var addWeight: UITextView!
    
    override func awakeFromNib() {
//        self.backgroundColor = MainConstants.orange
        AddMaterialIcon()
        AddColorChangeView()
        AddChangeColorsView(parentView: changeColorView)
        AddIconChangeView()
        AddChangeIconsView(parentView: changeIconView)
//        TextFieldLayer()
    }
    
    @objc func ChangeColorFirst(){
        bgView.backgroundColor = MaterialsColors.organicGreen
    }
    
    @objc func ChangeColorSecond(){
        bgView.backgroundColor = MaterialsColors.metalBeige
    }
    
    @objc func ChangeColorThird(){
        bgView.backgroundColor = MaterialsColors.organicBeige
    }
    
    @objc func ChangeColorFourth(){
        bgView.backgroundColor = MaterialsColors.paperOrange
    }
    
    @objc func ChangeColorFifth(){
        bgView.backgroundColor = MaterialsColors.waterBlue
    }
    
    @objc func ChangeIconFirst(){
        icon.image = MaterialsIcons.organicLimone
    }
    
    @objc func ChangeIconSecond(){
        icon.image = MaterialsIcons.metal
    }
    
    @objc func ChangeIconThird(){
        icon.image = MaterialsIcons.organicTomato
    }
    
    @objc func ChangeIconFourth(){
        icon.image = MaterialsIcons.paper
    }
    
    @objc func ChangeIconFifth(){
        icon.image = MaterialsIcons.waterBottle
    }
    
    func CalculateScale(view: UIView) -> CGFloat{
        let width = view.frame.size.width
        return width/9
    }
}



extension ButtonImageCell{
    func AddMaterialIcon(){
        print("Add Material Icon")
        let scale = 230 as CGFloat
        let view = UIView()
        self.addSubview(view)
        bgView = view
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bgView.widthAnchor.constraint(equalToConstant: scale),
            bgView.heightAnchor.constraint(equalToConstant: scale)
        ])
        bgView.layer.cornerRadius = scale/4
        
        let image = UIImageView()
        view.addSubview(image)
        icon = image
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            icon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            icon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            icon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    func AddColorChangeView(){
        let height = 70 as CGFloat
        let view: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: height)
            view.backgroundColor = MainConstants.white
            view.layer.cornerRadius = 15
            view.clipsToBounds = true
            view.layer.masksToBounds = false
            view.layer.shadowRadius = 8
            view.layer.shadowOpacity = 0.27
            view.layer.shadowOffset = CGSize(width: 2, height: 3)
            view.layer.shadowColor = UIColor.darkGray.cgColor
            return view
        }()
        self.addSubview(view)
        changeColorView = view
        NSLayoutConstraint.activate([
            changeColorView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 25),
            changeColorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            changeColorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            changeColorView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func AddChangeColorsView(parentView: UIView){
        let scale = CalculateScale(view: parentView)
        let firstView = UIView()
        parentView.addSubview(firstView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            firstView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            firstView.heightAnchor.constraint(equalToConstant: scale),
            firstView.widthAnchor.constraint(equalToConstant: scale)
        ])
        firstView.backgroundColor = MaterialsColors.organicGreen
        firstView.layer.cornerRadius = scale/4
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeColorFirst)))
        
        let secondView = UIView()
        parentView.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            secondView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: scale*1.8),
            secondView.heightAnchor.constraint(equalToConstant: scale),
            secondView.widthAnchor.constraint(equalToConstant: scale)
        ])
        secondView.backgroundColor = MaterialsColors.metalBeige
        secondView.layer.cornerRadius = scale/4
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeColorSecond)))
        
        let thirdView = UIView()
        parentView.addSubview(thirdView)
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            thirdView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -scale*1.8),
            thirdView.heightAnchor.constraint(equalToConstant: scale),
            thirdView.widthAnchor.constraint(equalToConstant: scale)
        ])
        thirdView.backgroundColor = MaterialsColors.organicBeige
        thirdView.layer.cornerRadius = scale/4
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeColorThird)))
        
        let fourthView = UIView()
        parentView.addSubview(fourthView)
        fourthView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            fourthView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: scale*1.8),
            fourthView.heightAnchor.constraint(equalToConstant: scale),
            fourthView.widthAnchor.constraint(equalToConstant: scale)
        ])
        fourthView.backgroundColor = MaterialsColors.paperOrange
        fourthView.layer.cornerRadius = scale/4
        fourthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeColorFourth)))
        
        let fifthView = UIView()
        parentView.addSubview(fifthView)
        fifthView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fifthView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            fifthView.centerXAnchor.constraint(equalTo: thirdView.centerXAnchor, constant: -scale*1.8),
            fifthView.heightAnchor.constraint(equalToConstant: scale),
            fifthView.widthAnchor.constraint(equalToConstant: scale)
        ])
        fifthView.backgroundColor = MaterialsColors.waterBlue
        fifthView.layer.cornerRadius = scale/4
        fifthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeColorFifth)))
    }
    
    func AddIconChangeView(){
        let view = UIView()
        let height = 70 as CGFloat
        self.addSubview(view)
        changeIconView = view
        changeIconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeIconView.topAnchor.constraint(equalTo: changeColorView.bottomAnchor, constant: 25),
            changeIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            changeIconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            changeIconView.heightAnchor.constraint(equalToConstant: height)
        ])
        changeIconView.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: height)
        changeIconView.backgroundColor = MainConstants.white
        changeIconView.layer.cornerRadius = 15
        changeIconView.clipsToBounds = true
        changeIconView.layer.masksToBounds = false
        changeIconView.layer.shadowRadius = 8
        changeIconView.layer.shadowOpacity = 0.27
        changeIconView.layer.shadowOffset = CGSize(width: 2, height: 3)
        changeIconView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func AddChangeIconsView(parentView: UIView){
        let scale = CalculateScale(view: parentView)
        let firstView = UIView()
        parentView.addSubview(firstView)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            firstView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            firstView.heightAnchor.constraint(equalToConstant: scale),
            firstView.widthAnchor.constraint(equalToConstant: scale)
        ])
        firstView.backgroundColor = .lightGray
        firstView.layer.cornerRadius = scale/4
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeIconFirst)))
        
        let firstImage = UIImageView()
        firstView.addSubview(firstImage)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 3),
            firstImage.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -3),
            firstImage.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 3),
            firstImage.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -3)
        ])
        firstImage.image = MaterialsIcons.organicLimone

        let secondView = UIView()
        parentView.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            secondView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: scale*1.8),
            secondView.heightAnchor.constraint(equalToConstant: scale),
            secondView.widthAnchor.constraint(equalToConstant: scale)
        ])
        secondView.backgroundColor = .lightGray
        secondView.layer.cornerRadius = scale/4
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeIconSecond)))
        
        let secondImage = UIImageView()
        secondView.addSubview(secondImage)
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 3),
            secondImage.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -3),
            secondImage.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 3),
            secondImage.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -3)
        ])
        secondImage.image = MaterialsIcons.metal

        let thirdView = UIView()
        parentView.addSubview(thirdView)
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            thirdView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -scale*1.8),
            thirdView.heightAnchor.constraint(equalToConstant: scale),
            thirdView.widthAnchor.constraint(equalToConstant: scale)
        ])
        thirdView.backgroundColor = .lightGray
        thirdView.layer.cornerRadius = scale/4
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeIconThird)))
        
        let thirdImage = UIImageView()
        thirdView.addSubview(thirdImage)
        thirdImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdImage.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 3),
            thirdImage.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -3),
            thirdImage.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 3),
            thirdImage.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -3)
        ])
        thirdImage.image = MaterialsIcons.organicTomato

        let fourthView = UIView()
        parentView.addSubview(fourthView)
        fourthView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            fourthView.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: scale*1.8),
            fourthView.heightAnchor.constraint(equalToConstant: scale),
            fourthView.widthAnchor.constraint(equalToConstant: scale)
        ])
        fourthView.backgroundColor = .lightGray
        fourthView.layer.cornerRadius = scale/4
        fourthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeIconFourth)))
        
        let fourthImage = UIImageView()
        fourthView.addSubview(fourthImage)
        fourthImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthImage.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 3),
            fourthImage.bottomAnchor.constraint(equalTo: fourthView.bottomAnchor, constant: -3),
            fourthImage.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 3),
            fourthImage.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -3)
        ])
        fourthImage.image = MaterialsIcons.paper

        let fifthView = UIView()
        parentView.addSubview(fifthView)
        fifthView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fifthView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            fifthView.centerXAnchor.constraint(equalTo: thirdView.centerXAnchor, constant: -scale*1.8),
            fifthView.heightAnchor.constraint(equalToConstant: scale),
            fifthView.widthAnchor.constraint(equalToConstant: scale)
        ])
        fifthView.backgroundColor = .lightGray
        fifthView.layer.cornerRadius = scale/4
        fifthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeIconFifth)))
        
        let fifthImage = UIImageView()
        fifthView.addSubview(fifthImage)
        fifthImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fifthImage.topAnchor.constraint(equalTo: fifthView.topAnchor, constant: 3),
            fifthImage.bottomAnchor.constraint(equalTo: fifthView.bottomAnchor, constant: -3),
            fifthImage.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 3),
            fifthImage.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -3)
        ])
        fifthImage.image = MaterialsIcons.waterBottle
    }
    
    func TextFieldLayer(){
        let field = UITextView()
        self.addSubview(field)
        addWeight = field
        addWeight.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addWeight.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            addWeight.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            addWeight.widthAnchor.constraint(equalToConstant: 100),
            addWeight.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        addWeight.font = UIFont.preferredFont(forTextStyle: .body)
        addWeight.layer.cornerRadius = 5
        addWeight.autocorrectionType = .no
        addWeight.backgroundColor = .red
        addWeight.textColor = .darkGray
        addWeight.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
