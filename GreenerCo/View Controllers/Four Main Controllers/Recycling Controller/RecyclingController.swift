//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

protocol SwitcherDelegate {
    func ShowStats()
    func ShowRecycling()
}


protocol StatsDelegate {
    func HideTopBar(_ should: Bool)
}


protocol RecyclingDelegate {
    func Add()
}


protocol TopViewDelegate {
    func UpdateTitles(isRecylcing: Bool)
}


class RecyclingController: UIViewController {
    
    let topView: TopView = {
        let view = TopView()
            .with(bgColor: Colors.background)
            .with(autolayout: false)
        return view
    }()
    
    lazy var switcherView: SwitcherView = {
        let view = SwitcherView()
            .with(autolayout: false)
        view.delegate = self
        view.topViewDelegate = topView
        return view
    }()
    
    lazy var recyclingView: RecyclingView = {
        let view = RecyclingView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()
    
    lazy var statsView: StatsView = {
        let view = StatsView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()
    
    lazy var mapView: MapView = {
        let view = MapView()
            .with(autolayout: false)
//        view.delegate = self
        return view
    }()
    
    
    var recyclingXConstraint: NSLayoutConstraint?
    var statsXConstraint: NSLayoutConstraint?
    var mapXConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        SetSubviews()
        ActivateLayouts()
        print(MaterialFunctions().calculate())
    }
}





extension RecyclingController: SwitcherDelegate {
    func ShowStats() {
        Vibration.soft()
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.mapView.center.x = self.view.center.x
//            self.statsView.center.x = self.view.center.x
            self.recyclingView.center.x = -self.view.center.x
        }, completion: { (_) in
            self.mapXConstraint?.constant = 0
//            self.statsXConstraint?.constant = 0
            self.recyclingXConstraint?.constant = -3*self.view.center.x
        })
    }
    
    func ShowRecycling() {
        Vibration.soft()
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.statsView.center.x = 3 * self.view.center.x
            self.recyclingView.center.x = self.view.center.x
        }, completion: { (_) in
            self.statsXConstraint?.constant = 3 * self.view.center.x
            self.recyclingXConstraint?.constant = 0
        })
    }
}






extension RecyclingController: StatsDelegate {
    func HideTopBar(_ should: Bool) {
        if (should) {
            guard (self.switcherView.center.y > 0) else { return }
            UIView.animate(withDuration: 0.5, animations: {
                self.switcherView.center.y = -2 * self.switcherView.center.y
                self.topView.center.y =  -2 * self.topView.center.y
            }, completion: { (result) in })
        } else {
            guard (self.switcherView.center.y < 0) else { return }
            UIView.animate(withDuration: 0.5, animations: {
                self.switcherView.center.y = -0.5 * self.switcherView.center.y
                self.topView.center.y =  -0.5 * self.topView.center.y
            }, completion: { (result) in })
        }
    }
    
}


extension RecyclingController: RecyclingDelegate {
    func Add() {
        Vibration.soft()
        let newVC = AddTrashController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        newVC.recyclingDelegate = recyclingView
        newVC.statsDelegate = statsView
        present(newVC, animated: true, completion: nil)
    }
}




extension RecyclingController {
    func SetSubviews(){
        view.addSubview(recyclingView)
        view.addSubview(statsView)
        view.addSubview(mapView)
        view.addSubview(topView)
        view.addSubview(switcherView)
    }
        
    func ActivateLayouts(){
        let switcherTopConst: CGFloat = {
            if MainConstants.screenHeight == 736 { return 30 }
            else { return 50 }
        }()
        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            
            switcherView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: switcherTopConst),
            switcherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcherView.widthAnchor.constraint(equalToConstant: switcherView.frame.width),
            switcherView.heightAnchor.constraint(equalToConstant: switcherView.frame.height),
            
            // centerXAnchor constrain in the bottom of the function.
            recyclingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recyclingView.widthAnchor.constraint(equalToConstant: recyclingView.frame.width),
            recyclingView.heightAnchor.constraint(equalToConstant: recyclingView.frame.height),
            
            // centerXAnchor constrain in the bottom of the function.
            statsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statsView.widthAnchor.constraint(equalToConstant: statsView.frame.width),
            statsView.heightAnchor.constraint(equalToConstant: statsView.frame.height),
            
            // centerXAnchor constrain in the bottom of the function.
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.widthAnchor.constraint(equalToConstant: mapView.frame.width),
            mapView.heightAnchor.constraint(equalToConstant: mapView.frame.height),
        ])
        
        recyclingXConstraint = recyclingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        statsXConstraint = statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width)
        mapXConstraint = mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2*view.frame.width)
        recyclingXConstraint?.isActive = true
        statsXConstraint?.isActive = true
        mapXConstraint?.isActive = true
    }
}

