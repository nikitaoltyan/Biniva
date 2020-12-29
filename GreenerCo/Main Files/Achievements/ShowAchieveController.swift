//
//  ShowAchieveController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 11.11.2020.
//

import UIKit

class ShowAchieveController: UIViewController {

    var back: UIButton!
    var achieveImage: UIImageView!
    var name: UILabel!
    var desc: UILabel!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 252/255, blue: 250/255, alpha: 1)
        BackButton()
        AchieveImage()
        AchieveName()
        AchieveDescription()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DismissAction(_:))))
    }
    
    @objc func BackAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func DismissAction(_ sender: UIPanGestureRecognizer){
        print("Dismiss action")
        let touchPoint = sender.location(in: self.view.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.x - initialTouchPoint.x > 0 {
                self.view.frame = CGRect(x: touchPoint.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled{
            if touchPoint.x - initialTouchPoint.x > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }, completion: { finished in
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func BackButton(){
        let backButton = UIButton()
        backButton.tintColor = UIColor.darkGray
        view.addSubview(backButton)
        let useImage = UIImage(systemName: "chevron.left")
        backButton.setImage(useImage, for: .normal)
        back = backButton
        back.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            back.heightAnchor.constraint(equalToConstant: 30),
            back.widthAnchor.constraint(equalToConstant: 30)
        ])
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    func AchieveImage(){
        let image = UIImageView()
        view.addSubview(image)
        achieveImage = image
        let size = 200 as CGFloat
        achieveImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            achieveImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            achieveImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            achieveImage.widthAnchor.constraint(equalToConstant: size),
            achieveImage.heightAnchor.constraint(equalToConstant: size)
        ])
        achieveImage.layer.masksToBounds = true
        achieveImage.layer.cornerRadius = 7
        achieveImage.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
    }
    
    func AchieveName(){
        let label = UILabel()
        view.addSubview(label)
        name = label
        name.numberOfLines = 0
        name.textAlignment = .center
        name.textColor = .darkGray
        name.text = "Achieve Name"
        name.font = UIFont.init(name: "Palatino Bold", size: 25.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: achieveImage.bottomAnchor, constant: 39),
            name.leftAnchor.constraint(equalTo: view.leftAnchor),
            name.rightAnchor.constraint(equalTo: view.rightAnchor),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    func AchieveDescription(){
        let label = UILabel()
        view.addSubview(label)
        desc = label
        desc.numberOfLines = 0
        desc.textColor = .darkGray
        desc.textAlignment = .left
        desc.text = "Achieve description. \nWe can add here some custom text."
        desc.font = UIFont.init(name: "Palatino", size: 20.0)
        desc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            desc.topAnchor.constraint(equalTo: achieveImage.bottomAnchor, constant: 39),
            desc.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 50),
            desc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            desc.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}
