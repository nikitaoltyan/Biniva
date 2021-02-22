//
//  RecyclingLayers.swift
//  GreenerCo
//
//  Created by Никита Олтян on 24.11.2020.
//

import UIKit

extension RecyclingController {
    
    func SetSubviews(){
        view.addSubview(topView)
        view.addSubview(plusView)
        view.addSubview(addFirstItemView)
        view.addSubview(addSecondItemView)
        view.addSubview(addThirdItemView)
        view.addSubview(openCustomView)
        view.addSubview(progressView)
        view.addSubview(numberView)
        view.addSubview(customAddView)
        view.addSubview(dimView)
        
        addFirstItemView.backgroundColor = MaterialsColors.waterBlue
        addFirstItemView.image.image = MaterialsIcons.waterBottle
        addSecondItemView.backgroundColor = MaterialsColors.organicGreen
        addSecondItemView.image.image = MaterialsIcons.organicLimone
        addThirdItemView.backgroundColor = MaterialsColors.paperOrange
        addThirdItemView.image.image = MaterialsIcons.paper
        
        view.bringSubviewToFront(addThirdItemView)
        view.bringSubviewToFront(plusView)
        view.bringSubviewToFront(dimView)
        view.bringSubviewToFront(customAddView)
        
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
        dimView.isHidden = true
    }
    
    
    
    func ActivateLayouts(){
        let heightOfProgressView: CGFloat = {if MainConstants.screenHeight>700{return 400}else{return 360}}()
        let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.size.height ?? 49
        let plusViewFromBottom: CGFloat = {
            if MainConstants.screenHeight == 736 { return 85 }
            else if MainConstants.screenHeight>700 { return 130 }
            else { return 70 }}()
        let progressViewFromHeight: CGFloat = {if MainConstants.screenHeight>700{return 158}else{return 138}}()
        let customAddBottom: CGFloat = {
            if MainConstants.screenHeight == 736 { return -tabBarHeight }
            else if MainConstants.screenHeight>700 { return -tabBarHeight-34 }
            else { return -tabBarHeight }}()
        let dailyNorm = UserDefaults.standard.integer(forKey: "dailyNorm")
        let lineTop: CGFloat = MaterialDefaults.YForDashedLine(dailyNorm: dailyNorm)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 150),
            
            plusView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -plusViewFromBottom),
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
            
            progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: progressViewFromHeight),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-160),
            progressView.heightAnchor.constraint(equalToConstant: heightOfProgressView),
            
            numberView.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: lineTop+numberView.frame.height/2),
            numberView.rightAnchor.constraint(equalTo: progressView.leftAnchor, constant: -5),
            numberView.heightAnchor.constraint(equalToConstant: numberView.frame.height),
            numberView.widthAnchor.constraint(equalToConstant: numberView.frame.width),
            
            customAddView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: customAddBottom),
            customAddView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            customAddView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            customAddView.heightAnchor.constraint(equalToConstant: customAddView.frame.height),
            
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dimView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
