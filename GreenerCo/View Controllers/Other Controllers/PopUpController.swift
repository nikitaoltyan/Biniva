//
//  PopUpController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 30.12.2020.
//

import UIKit

class PopUpController: UIViewController {
    
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
    
    let achieveImage: UIImageView = {
        let imageScale: CGFloat = 120
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: imageScale, height: imageScale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "5-02.2-s")
        return image
    }()
    
    let achieveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "New Achieve Completed"
        label.font = UIFont(name: "SFPro-Medium", size: 25)
        return label
    }()
    
    let achieveDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "Some Custome description about completed new Achievement. Congratulations!"
        label.font = UIFont(name: "SFPro", size: 16)
        return label
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
    
    
    @objc func DismissAction(_ sender: UIPanGestureRecognizer){
        let touchPoint = sender.location(in: view)
        let closePoint: CGFloat = MainConstants.screenHeight - mainView.frame.height/2
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed  {
            mainView.frame = CGRect(x: mainView.frame.minX, y: touchPoint.y, width: mainView.frame.size.width, height: mainView.frame.size.height)
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y > closePoint{
                Dismiss()
            } else {
                ReturnToStartPosition(closePoint: closePoint)
            }
        }
    }

    
    func ReturnToStartPosition(closePoint: CGFloat){
        UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
            self.mainView.frame = CGRect(x: self.mainView.frame.minX, y: closePoint - self.mainView.frame.height/1.5, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
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




extension PopUpController {
    func SetSubviews(){
        view.addSubview(mainView)
        mainView.addSubview(closeImage)
        mainView.addSubview(achieveImage)
        mainView.addSubview(achieveLabel)
        mainView.addSubview(achieveDesc)
        closeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        mainView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DismissAction(_:))))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height),
            mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width),
            
            closeImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 17),
            closeImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 17),
            closeImage.heightAnchor.constraint(equalToConstant: closeImage.frame.height),
            closeImage.widthAnchor.constraint(equalToConstant: closeImage.frame.width),
            
            achieveImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            achieveImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 40),
            achieveImage.heightAnchor.constraint(equalToConstant: achieveImage.frame.height),
            achieveImage.widthAnchor.constraint(equalToConstant: achieveImage.frame.width),
            
            achieveLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            achieveLabel.topAnchor.constraint(equalTo: achieveImage.bottomAnchor, constant: 20),
            
            achieveDesc.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            achieveDesc.topAnchor.constraint(equalTo: achieveLabel.bottomAnchor, constant: 12),
            achieveDesc.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            achieveDesc.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20)
        ])
    }
}

