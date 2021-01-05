//
//  RecyclingLayers.swift
//  GreenerCo
//
//  Created by Никита Олтян on 24.11.2020.
//

import UIKit

extension RecyclingController{
    
    func PerformLayers(){
        AddCustomPickerView()
        AddImage()
    }
    
    
    func AddCustomPickerView(){
//        customTable.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            customTable.leftAnchor.constraint(equalTo: customAddView.leftAnchor, constant: 0),
//            customTable.rightAnchor.constraint(equalTo: customAddView.rightAnchor, constant: 0),
//            customTable.bottomAnchor.constraint(equalTo: customAddView.bottomAnchor, constant: -70),
//            customTable.topAnchor.constraint(equalTo: customAddView.topAnchor, constant: 90)
//        ])
//        customTable.showsVerticalScrollIndicator = false
//        customTable.backgroundColor = MainConstants.white
    }
    
//    func AchieveLayout(){
//        let userProfile = UIImageView()
//        topBGView.addSubview(userProfile)
//        userProfile.translatesAutoresizingMaskIntoConstraints = false
//        let scale = 30 as CGFloat
//        NSLayoutConstraint.activate([
//            userProfile.topAnchor.constraint(equalTo: topBGView.topAnchor, constant: 40),
//            userProfile.rightAnchor.constraint(equalTo: topBGView.rightAnchor, constant: -20),
//            userProfile.widthAnchor.constraint(equalToConstant: scale),
//            userProfile.heightAnchor.constraint(equalToConstant: scale*0.9)
//        ])
//        profileImage = userProfile
//        profileImage.image = UIImage(systemName: "crown.fill")
//        profileImage.tintColor = MainConstants.white
//        profileImage.layer.masksToBounds = true
//        profileImage.layer.cornerRadius = scale/2
//        profileImage.isUserInteractionEnabled = true
//        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenProfile)))
//    }

    
    func AddImage(){
        let scale = 50 as CGFloat
        let view = UIView()
        customAddView.addSubview(view)
        pickedView = view
        pickedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickedView.topAnchor.constraint(equalTo: customAddView.topAnchor, constant: 30),
            pickedView.leftAnchor.constraint(equalTo: customAddView.leftAnchor, constant: 10),
            pickedView.widthAnchor.constraint(equalToConstant: scale),
            pickedView.heightAnchor.constraint(equalToConstant: scale)
        ])
        pickedView.layer.masksToBounds = true
        pickedView.backgroundColor = MaterialsColors.organicGreen
        pickedView.layer.cornerRadius = scale/4
        
        let image = UIImageView()
        pickedView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        pickedImage = image
        NSLayoutConstraint.activate([
            pickedImage.topAnchor.constraint(equalTo: pickedView.topAnchor, constant: 2),
            pickedImage.bottomAnchor.constraint(equalTo: pickedView.bottomAnchor, constant: -2),
            pickedImage.leftAnchor.constraint(equalTo: pickedView.leftAnchor, constant: 2),
            pickedImage.rightAnchor.constraint(equalTo: pickedView.rightAnchor, constant: -2),
        ])
        pickedImage.layer.masksToBounds = true
        pickedImage.image = #imageLiteral(resourceName: "Organic-1")
    }
}




extension RecyclingController {
    
    func SetSubviews(){
        view.addSubview(topView)
        view.addSubview(plusView)
        view.addSubview(addFirstItemView)
        view.addSubview(addSecondItemView)
        view.addSubview(addThirdItemView)
        view.addSubview(openCustomView)
        view.addSubview(progressView)
        view.addSubview(customAddView)
        
        addFirstItemView.backgroundColor = MaterialsColors.metalBeige
        addFirstItemView.image.image = MaterialsIcons.metal
        addSecondItemView.backgroundColor = MaterialsColors.organicGreen
        addSecondItemView.image.image = MaterialsIcons.organicLimone
        addThirdItemView.backgroundColor = MaterialsColors.paperOrange
        addThirdItemView.image.image = MaterialsIcons.paper
        
        view.bringSubviewToFront(plusView)
        view.bringSubviewToFront(addSecondItemView)
        
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateThreeMainViews)))
        addFirstItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddFirstItem)))
        addSecondItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddSecondItem)))
        addThirdItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddThirdItem)))
        openCustomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateCustomView)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        customAddView.addGestureRecognizer(swipeDown)
        
        customAddView.isHidden = true
        addFirstItemView.isHidden = true
        addSecondItemView.isHidden = true
        addThirdItemView.isHidden = true
    }
    
    func ActivateLayouts(){
        let heightOfProgressView: CGFloat = {if MainConstants.screenHeight>700{return 420}else{return 260}}()
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 150),
            
            plusView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -130),
            plusView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            
            addFirstItemView.bottomAnchor.constraint(equalTo: plusView.bottomAnchor),
            addFirstItemView.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: -addFirstItemView.frame.width*2/3),
            addFirstItemView.widthAnchor.constraint(equalToConstant: addFirstItemView.frame.width),
            addFirstItemView.heightAnchor.constraint(equalToConstant: addFirstItemView.frame.height),
            
            addSecondItemView.bottomAnchor.constraint(equalTo: plusView.bottomAnchor),
            addSecondItemView.rightAnchor.constraint(equalTo: plusView.rightAnchor, constant: addSecondItemView.frame.width*2/3),
            addSecondItemView.widthAnchor.constraint(equalToConstant: addSecondItemView.frame.width),
            addSecondItemView.heightAnchor.constraint(equalToConstant: addSecondItemView.frame.height),
            
            addThirdItemView.bottomAnchor.constraint(equalTo: plusView.topAnchor, constant: -addThirdItemView.frame.width*2/3),
            addThirdItemView.rightAnchor.constraint(equalTo: plusView.rightAnchor),
            addThirdItemView.widthAnchor.constraint(equalToConstant: addThirdItemView.frame.width),
            addThirdItemView.heightAnchor.constraint(equalToConstant: addThirdItemView.frame.height),
            
            openCustomView.leftAnchor.constraint(equalTo: plusView.rightAnchor, constant: 33),
            openCustomView.centerYAnchor.constraint(equalTo: plusView.centerYAnchor),
            openCustomView.widthAnchor.constraint(equalToConstant: openCustomView.frame.width),
            openCustomView.heightAnchor.constraint(equalToConstant: openCustomView.frame.height),
            
            progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 158),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-160),
            progressView.heightAnchor.constraint(equalToConstant: heightOfProgressView),
            
            customAddView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            customAddView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            customAddView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            customAddView.heightAnchor.constraint(equalToConstant: customAddView.frame.height)
        ])
    }
}
