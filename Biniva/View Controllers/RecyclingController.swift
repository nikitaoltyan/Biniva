//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

protocol SwitcherDelegate {
    func showStats()
    func showRecycling()
    func showMap()
//    func hideTopView(_ hide: Bool)
}


protocol StatsDelegate {
    func HideTopBar(_ should: Bool)
}


protocol RecyclingDelegate {
    func Add()
}

protocol mapDelegate {
    func openAddNewPoint()
    func showPopUp()
}

protocol TopViewDelegate {
    func UpdateTitles(isRecylcing: Bool)
}



class RecyclingController: UIViewController {
    
    let server = Server()
    
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
        view.delegate = self
        return view
    }()

    
    var isTopViewHidden: Bool = false
    var topViewYConstraint: NSLayoutConstraint?
    var switcherTopConstraint: NSLayoutConstraint?
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
    
    func hideTopView(_ hide: Bool) {
        if (hide) {
            guard (isTopViewHidden == false) else { return }
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations: {
                self.topView.center.y =  -2 * self.topView.center.y
                self.switcherView.center.y = 0.4 * self.switcherView.center.y
            }, completion: { (result) in
                self.topViewYConstraint?.constant = -self.topView.frame.height/2
                self.topView.layoutIfNeeded()
                self.isTopViewHidden = true
            })
        } else {
            guard (isTopViewHidden) else { return }
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations: {
                self.topView.center.y =  self.topView.frame.height/2
                self.switcherView.center.y = 2.75 * self.switcherView.center.y
            }, completion: { (result) in
                self.topViewYConstraint?.constant = self.topView.frame.height/2
                self.topView.layoutIfNeeded()
                self.isTopViewHidden = false
            })
        }
    }
}





extension RecyclingController: SwitcherDelegate {
    func showRecycling() {
        Vibration.soft()
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.recyclingView.center.x = self.view.center.x
            self.statsView.center.x = 3 * self.view.center.x
            self.mapView.center.x = 5 * self.view.center.x
        }, completion: { (_) in 
            self.recyclingXConstraint?.constant = 0
            self.statsXConstraint?.constant = 3 * self.view.center.x
            self.mapXConstraint?.constant = 5 * self.view.center.x
            self.hideTopView(false)
        })
    }
    
    
    func showStats() {
        Vibration.soft() 
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.statsView.center.x = self.view.center.x
            self.recyclingView.center.x = -self.view.center.x
            self.mapView.center.x = 3*self.view.center.x
        }, completion: { (_) in
            self.statsXConstraint?.constant = 0
            self.recyclingXConstraint?.constant = -3*self.view.center.x
            self.mapXConstraint?.constant = 3*self.view.center.x
            self.hideTopView(false)
        })
    }

    
    func showMap() {
        Vibration.soft()
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.mapView.center.x = self.view.center.x
            self.statsView.center.x = -self.view.center.x
            self.recyclingView.center.x = -3*self.view.center.x
        }, completion: { (_) in
            self.mapXConstraint?.constant = 0
            self.statsXConstraint?.constant = -3*self.view.center.x
            self.recyclingXConstraint?.constant = -5*self.view.center.x
            self.hideTopView(true)
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





extension RecyclingController: mapDelegate {
    func openAddNewPoint() {
        let newVC = AddPointController()
        newVC.delegate = self
        present(newVC, animated: true, completion: nil)
    }
    
    func showPopUp() {
        Vibration.soft()
        let newVC = PointAddedPopUpController()
        newVC.modalPresentationStyle = .overFullScreen
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
        let switcherTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 20
            case 736: return 30
            default: return 50
            }
        }()
        
        NSLayoutConstraint.activate([
            // topViewYConstraint in the bottom of the function.
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            
            // switcherView top constrain in the bottom of the function.
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
        
        topViewYConstraint = topView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: topView.frame.height/2)
        switcherTopConstraint = switcherView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: switcherTopConstant)
        recyclingXConstraint = recyclingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        statsXConstraint = statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width)
        mapXConstraint = mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2*view.frame.width)
        topViewYConstraint?.isActive = true
        switcherTopConstraint?.isActive = true
        recyclingXConstraint?.isActive = true
        statsXConstraint?.isActive = true
        mapXConstraint?.isActive = true
    }
}

