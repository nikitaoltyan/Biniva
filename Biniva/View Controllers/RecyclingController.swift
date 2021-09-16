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
    func hideTopBar(_ should: Bool)
    func openArticle()
    func openAskForComment()
}


protocol RecyclingDelegate {
    func add()
    func openCamera()
    func openMaterialInfo()
}

protocol mapDelegate: AnyObject {
    func openAddNewPoint()
    func showPaywall()
    func showActivityController()
    func showImageShower(withImages images: [String], open: Int)
    func showPopUp(title: String, subtitle: String, image: UIImage?, andButtonText buttonText: String)
}

protocol TopViewDelegate {
    func updateTitles(isRecylcing: Bool)
}

protocol topViewDelegate { // WTF. Used for delegates methonds from TopView to RecyclingController.
    func openSettings()
    func openPaywall()
}



class RecyclingController: UIViewController {
    
    let server = Server()
    let appTransparency = AppTransparency()
    let analytics = ServerAnalytics()
    
    lazy var topView: TopView = {
        let view = TopView()
            .with(bgColor: Colors.background)
            .with(autolayout: false)
        view.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("Recycling Controller Will Appear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        appTransparency.requestPermission()
        NotificationCenter.default.addObserver(self, selector: #selector(updateMap), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func updateDataAfterSettings() {
        recyclingView.progressView.setUpInitial()
        statsView.updateLabel()
        statsView.statsTable.reloadData()
    }
    
    func updateDataAfterPaywall() {
        topView.updatePaywallButton()
        mapView.updatePaywallButton()
        statsView.updateAfterPaywall()
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
    
    @objc
    func updateMap() {
        self.mapView.setUserLocation()
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
        analytics.logOpenMap()
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
    func hideTopBar(_ should: Bool) {
        if (should) {
            guard (self.switcherView.center.y > 0) else { return }
            switcherView.isHidden = false
            topView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.switcherView.center.y = -2 * self.switcherView.center.y
                self.topView.center.y =  -2 * self.topView.center.y
            }, completion: { (result) in
                self.switcherView.isHidden = true
                self.topView.isHidden = true
            })
        } else {
            guard (self.switcherView.isHidden) else { return }
            switcherView.isHidden = false
            topView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.switcherView.center.y = -0.5 * self.switcherView.center.y
                self.topView.center.y =  -0.5 * self.topView.center.y
            }, completion: { (result) in })
        }
    }
    
    func openArticle() {
        let newVC = ArticleController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
    
    func openAskForComment() {
        let newVC = LeaveCommentController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
}




extension RecyclingController: RecyclingDelegate {
    func add() {
        Vibration.soft()
        let newVC = AddTrashController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        newVC.recyclingDelegate = recyclingView
        newVC.statsDelegate = statsView
        present(newVC, animated: true, completion: nil)
    }
    
    func openCamera() {
        Vibration.soft()
        let newVC = CameraController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        newVC.recyclingDelegate = recyclingView
        newVC.statsDelegate = statsView
        newVC.popUpDelegate = self
        present(newVC, animated: true, completion: nil)
    }
    
    func openMaterialInfo() {
        Vibration.soft()
        let newVC = MaterialsInfoController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
}





extension RecyclingController: mapDelegate {
    func openAddNewPoint() {
        let newVC = AddPointController()
        newVC.delegate = self
        present(newVC, animated: true, completion: nil)
    }
    
    func showPopUp(title: String, subtitle: String, image: UIImage?, andButtonText buttonText: String) {
        Vibration.soft()
        self.showPopUp(withTitle: title, subtitle: subtitle, image: image, andButtonText: buttonText)
    }
    
    func showActivityController() {
        Vibration.soft()
        guard let image = UIImage(named: "ask_for_comment") else { return }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    
    func showImageShower(withImages images: [String], open: Int) {
        let newVC = ImageShowerController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        newVC.update(arrayOfImages: images)
        present(newVC, animated: true, completion: {
            newVC.open(image: open)
        })
    }
    
    func showPaywall() {
        let newVC = PaywallController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
}




extension RecyclingController: topViewDelegate {
    func openSettings() {
        Vibration.soft()
        let newVC = SettingsController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
    
    func openPaywall() {
        let newVC = PaywallController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
}




extension RecyclingController {
    private
    func setSubviews(){
        view.addSubview(recyclingView)
        view.addSubview(statsView)
        view.addSubview(mapView)
        view.addSubview(topView)
        view.addSubview(switcherView)
    }
    
    private
    func activateLayouts(){
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

