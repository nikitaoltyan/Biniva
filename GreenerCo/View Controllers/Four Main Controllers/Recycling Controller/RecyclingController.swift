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
    
    
    var recyclingXConstraint: NSLayoutConstraint?
    var statsXConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        SetSubviews()
        ActivateLayouts()
    }
}





extension RecyclingController: SwitcherDelegate {
    func ShowStats() {
        Vibration.Soft()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.statsView.center.x = self.view.center.x
            self.recyclingView.center.x = -self.view.center.x
        }, completion: { (result) in })
    }
    
    func ShowRecycling() {
        Vibration.Soft()
        UIView.animate(withDuration: 0.4, animations: {
            self.statsView.center.x = 3 * self.view.center.x
            self.recyclingView.center.x = self.view.center.x
        }, completion: { (result) in })
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
        let newVC = AddTrashController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
}




extension RecyclingController {
    func SetSubviews(){
        view.addSubview(recyclingView)
        view.addSubview(statsView)
        view.addSubview(topView)
        view.addSubview(switcherView)
    }
        
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            
            switcherView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 50),
            switcherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcherView.widthAnchor.constraint(equalToConstant: switcherView.frame.width),
            switcherView.heightAnchor.constraint(equalToConstant: switcherView.frame.height),
            
            recyclingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            recyclingView.widthAnchor.constraint(equalToConstant: recyclingView.frame.width),
            recyclingView.heightAnchor.constraint(equalToConstant: recyclingView.frame.height),
            
            statsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statsView.widthAnchor.constraint(equalToConstant: statsView.frame.width),
            statsView.heightAnchor.constraint(equalToConstant: statsView.frame.height),
        ])
        
        recyclingXConstraint = recyclingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        statsXConstraint = statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width)
        recyclingXConstraint?.isActive = true
        statsXConstraint?.isActive = true
    }
}

