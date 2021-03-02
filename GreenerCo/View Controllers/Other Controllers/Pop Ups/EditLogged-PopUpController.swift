//
//  EditLogged-PopUpController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.03.2021.
//

import UIKit

class EditLoggedPopUpController: UIViewController {
    
    let mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-24, height: 320))
        view.backgroundColor = MainConstants.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        return view
    }()
    
    let closeImage: UIImageView = {
        let imageScale: CGFloat = 24
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "xmark")
        image.tintColor = MainConstants.nearBlack
        return image
    }()
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        print("Pop up controller was initiated")
        
        SetSubviews()
        ActivateLayouts()
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ShowView), userInfo: nil, repeats: false)
    }
    
    

    
    @objc func ShowView(){
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            print("Animate")
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.24)
            self.mainView.center.y -= 400
        }, completion: { finished in
        })
    }
    
    @objc func Dismiss(){
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.view.backgroundColor = .clear
            self.mainView.center.y += self.mainView.frame.height
        }, completion: { finished in
            self.dismiss(animated: true, completion: nil)
        })
    }

}




extension EditLoggedPopUpController {
    func SetSubviews(){
        view.addSubview(mainView)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height),
            mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
        ])
    }
}
