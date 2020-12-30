//
//  RecyclingLayers.swift
//  GreenerCo
//
//  Created by Никита Олтян on 24.11.2020.
//

import UIKit

extension RecyclingController{
    
    func PerformLayers(){
        customAddView.isHidden = true
        addFirstItemView.isHidden = true
        addSecondItemView.isHidden = true
        addThirdItemView.isHidden = true
        MainViewLayer()
        TopViewLayer()
        ImageLayer()
        AddCustomPickerView()
        PlusViewLayer()
        AddFirstLayer()
        AddSecondLayer()
        AddThirdLayer()
        mainView.bringSubviewToFront(plusView)
        AchieveLayout()
        ViewOpenCustomPickerView()
        AddImage()
    }
    
    func MainViewLayer(){
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height-95)
        ])
    }
    
    func TopViewLayer(){
        topBGView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBGView.topAnchor.constraint(equalTo: view.topAnchor),
            topBGView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topBGView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topBGView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func ImageLayer(){
        let addView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            view.layer.cornerRadius = 20
            return view
        }()
        mainView.addSubview(addView)
        bgRecyclingBin = addView
        
        let orangeView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = MainConstants.orange
            view.layer.cornerRadius = 20
            return view
        }()
        mainView.addSubview(orangeView)
        fillRecylingBin = orangeView
        
        let recycleBin: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "Recycling_bin")
            return image
        }()
        mainView.addSubview(recycleBin)
        
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            let imageHeight = MainConstants.screenHeight-430
            const.append(contentsOf: [
                recycleBin.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 28),
                recycleBin.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 80),
                recycleBin.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -80),
                recycleBin.heightAnchor.constraint(equalToConstant: imageHeight),
                
                addView.topAnchor.constraint(equalTo: recycleBin.topAnchor),
                addView.leftAnchor.constraint(equalTo: recycleBin.leftAnchor),
                addView.rightAnchor.constraint(equalTo: recycleBin.rightAnchor),
                addView.bottomAnchor.constraint(equalTo: recycleBin.bottomAnchor),
                
                orangeView.bottomAnchor.constraint(equalTo: recycleBin.bottomAnchor),
                orangeView.leftAnchor.constraint(equalTo: recycleBin.leftAnchor),
                orangeView.rightAnchor.constraint(equalTo: recycleBin.rightAnchor),
                orangeView.heightAnchor.constraint(equalToConstant: 100)
            ])
        } else {
            let imageHeight = MainConstants.screenHeight-290
            const.append(contentsOf: [
                recycleBin.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
                recycleBin.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 80),
                recycleBin.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -80),
                recycleBin.heightAnchor.constraint(equalToConstant: imageHeight),
                
                addView.topAnchor.constraint(equalTo: recycleBin.topAnchor),
                addView.leftAnchor.constraint(equalTo: recycleBin.leftAnchor),
                addView.rightAnchor.constraint(equalTo: recycleBin.rightAnchor),
                addView.bottomAnchor.constraint(equalTo: recycleBin.bottomAnchor),
                
                orangeView.bottomAnchor.constraint(equalTo: recycleBin.bottomAnchor),
                orangeView.leftAnchor.constraint(equalTo: recycleBin.leftAnchor),
                orangeView.rightAnchor.constraint(equalTo: recycleBin.rightAnchor),
                orangeView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        NSLayoutConstraint.activate(const)
    }
    
    
    func PlusViewLayer(){
        mainView.addSubview(plusView)
        mainView.bringSubviewToFront(plusView)
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateThreeMainViews)))
        
        NSLayoutConstraint.activate([
            plusView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -130),
            plusView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height)
        ])
    }
    
    
    func AddFirstLayer(){
        mainView.addSubview(addFirstItemView)
        mainView.bringSubviewToFront(addFirstItemView)
        addFirstItemView.backgroundColor = MaterialsColors.metalBeige
        addFirstItemView.image.image = MaterialsIcons.metal
        addFirstItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddFirstItem)))
        
        NSLayoutConstraint.activate([
            addFirstItemView.bottomAnchor.constraint(equalTo: plusView.bottomAnchor),
            addFirstItemView.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: -addFirstItemView.frame.width*2/3),
            addFirstItemView.widthAnchor.constraint(equalToConstant: addFirstItemView.frame.width),
            addFirstItemView.heightAnchor.constraint(equalToConstant: addFirstItemView.frame.height)
        ])
    }
    
    
    func AddSecondLayer(){
        mainView.addSubview(addSecondItemView)
        mainView.bringSubviewToFront(addSecondItemView)
        addSecondItemView.backgroundColor = MaterialsColors.organicGreen
        addSecondItemView.image.image = MaterialsIcons.organicLimone
        addSecondItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddSecondItem)))
        
        NSLayoutConstraint.activate([
            addSecondItemView.bottomAnchor.constraint(equalTo: plusView.bottomAnchor),
            addSecondItemView.rightAnchor.constraint(equalTo: plusView.rightAnchor, constant: addSecondItemView.frame.width*2/3),
            addSecondItemView.widthAnchor.constraint(equalToConstant: addSecondItemView.frame.width),
            addSecondItemView.heightAnchor.constraint(equalToConstant: addSecondItemView.frame.height)
        ])
    }
    
    
    func AddThirdLayer(){
        mainView.addSubview(addThirdItemView)
        mainView.bringSubviewToFront(addThirdItemView)
        addThirdItemView.backgroundColor = MaterialsColors.paperOrange
        addThirdItemView.image.image = MaterialsIcons.paper
        addThirdItemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddThirdItem)))
        
        NSLayoutConstraint.activate([
            addThirdItemView.bottomAnchor.constraint(equalTo: plusView.topAnchor, constant: -addThirdItemView.frame.width*2/3),
            addThirdItemView.rightAnchor.constraint(equalTo: plusView.rightAnchor),
            addThirdItemView.widthAnchor.constraint(equalToConstant: addThirdItemView.frame.width),
            addThirdItemView.heightAnchor.constraint(equalToConstant: addThirdItemView.frame.height)
        ])
    }
    
    
    func AddCustomPickerView(){
        customAddView?.translatesAutoresizingMaskIntoConstraints = false
        let viewHeight = MainConstants.screenHeight/1.9
        print("Custom add view height: \(viewHeight)")
        customAddView.frame.size = CGSize(width: MainConstants.screenWidth, height: viewHeight)
        NSLayoutConstraint.activate([
            customAddView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            customAddView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            customAddView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            customAddView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])
        customAddView.layer.masksToBounds = true
        customAddView?.layer.cornerRadius = 20
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        customAddView?.addGestureRecognizer(swipeDown)
        
        customTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTable.leftAnchor.constraint(equalTo: customAddView.leftAnchor, constant: 0),
            customTable.rightAnchor.constraint(equalTo: customAddView.rightAnchor, constant: 0),
            customTable.bottomAnchor.constraint(equalTo: customAddView.bottomAnchor, constant: -70),
            customTable.topAnchor.constraint(equalTo: customAddView.topAnchor, constant: 90)
        ])
        customTable.showsVerticalScrollIndicator = false
        customTable.backgroundColor = MainConstants.white
    }
    
    func AchieveLayout(){
        let userProfile = UIImageView()
        topBGView.addSubview(userProfile)
        userProfile.translatesAutoresizingMaskIntoConstraints = false
        let scale = 30 as CGFloat
        NSLayoutConstraint.activate([
            userProfile.topAnchor.constraint(equalTo: topBGView.topAnchor, constant: 40),
            userProfile.rightAnchor.constraint(equalTo: topBGView.rightAnchor, constant: -20),
            userProfile.widthAnchor.constraint(equalToConstant: scale),
            userProfile.heightAnchor.constraint(equalToConstant: scale*0.9)
        ])
        profileImage = userProfile
        profileImage.image = UIImage(systemName: "crown.fill")
        profileImage.tintColor = MainConstants.white
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = scale/2
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenProfile)))
    }
    
    func ViewOpenCustomPickerView(){
        let addView = UIView()
        view.addSubview(addView)
        openCustomView = addView
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addView.leftAnchor.constraint(equalTo: plusView.rightAnchor, constant: 33),
            addView.centerYAnchor.constraint(equalTo: plusView.centerYAnchor),
            addView.widthAnchor.constraint(equalToConstant: 35),
            addView.heightAnchor.constraint(equalToConstant: 35)
        ])
        addView.layer.cornerRadius = 14
        addView.layer.borderWidth = 3
        addView.layer.borderColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1).cgColor
        addView.backgroundColor = UIColor.clear
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivateCustomView)))
        
        let firstLine = UIView()
        let secondLine = UIView()
        let thirdLine = UIView()
        addView.addSubview(firstLine)
        addView.addSubview(secondLine)
        addView.addSubview(thirdLine)
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLine.topAnchor.constraint(equalTo: addView.topAnchor, constant: 10),
            firstLine.leftAnchor.constraint(equalTo: addView.leftAnchor, constant: 9),
            firstLine.rightAnchor.constraint(equalTo: addView.rightAnchor, constant: -9),
            firstLine.heightAnchor.constraint(equalToConstant: 3),
            
            secondLine.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 3),
            secondLine.leftAnchor.constraint(equalTo: addView.leftAnchor, constant: 9),
            secondLine.rightAnchor.constraint(equalTo: addView.rightAnchor, constant: -9),
            secondLine.heightAnchor.constraint(equalToConstant: 3),
            
            thirdLine.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 3),
            thirdLine.leftAnchor.constraint(equalTo: addView.leftAnchor, constant: 9),
            thirdLine.rightAnchor.constraint(equalTo: addView.rightAnchor, constant: -9),
            thirdLine.heightAnchor.constraint(equalToConstant: 3),
        ])
        firstLine.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        firstLine.layer.cornerRadius = 1
        secondLine.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        secondLine.layer.cornerRadius = 1
        thirdLine.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        thirdLine.layer.cornerRadius = 1
    }
    
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
