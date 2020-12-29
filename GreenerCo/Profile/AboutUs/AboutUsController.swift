//
//  AboutUsController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 16.11.2020.
//

import UIKit

class AboutUsController: UIViewController {

    var back: UIButton!
    var mainTitle: UILabel!
    var firstImage: UIImageView!
    var secondImage: UIImageView!
    var labelTitle: UILabel!
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        BackButton()
        TitleLayer()
        ImagesLayer()
        LabelTitle()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DismissAction(_:))))
    }
    
    @objc func BackAction(sender: UIButton!) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
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
        backButton.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
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
    
    func TitleLayer(){
        let title = UILabel()
        view.addSubview(title)
        mainTitle = title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 30),
            mainTitle.widthAnchor.constraint(equalToConstant: 272)
        ])
        mainTitle.text = "О Greener"
        mainTitle.font = UIFont.init(name: "Palatino-Bold", size: 35.0)
        mainTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        print("title Layer")
    }
    
    func ImagesLayer(){
        let scale = 180 as CGFloat
        let firImage = UIImageView()
        view.addSubview(firImage)
        firstImage = firImage
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 70),
            firstImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            firstImage.heightAnchor.constraint(equalToConstant: scale),
            firstImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        firstImage.layer.masksToBounds = true
        firstImage.layer.cornerRadius = scale/2
        firstImage.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        
        let secImage = UIImageView()
        view.addSubview(secImage)
        secondImage = secImage
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondImage.topAnchor.constraint(equalTo: firstImage.topAnchor),
            secondImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            secondImage.heightAnchor.constraint(equalToConstant: scale),
            secondImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        secondImage.layer.masksToBounds = true
        secondImage.layer.cornerRadius = scale/2
        secondImage.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
    }
    
    func LabelTitle(){
        let title = UILabel()
        view.addSubview(title)
        labelTitle = title
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 55),
            labelTitle.leftAnchor.constraint(equalTo: back.rightAnchor),
            labelTitle.heightAnchor.constraint(equalToConstant: 200),
            labelTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55)
        ])
        labelTitle.text = MainConstants.aboutUs
        labelTitle.numberOfLines = 0
        labelTitle.font = UIFont.init(name: "SFPro", size: 20.0)
        labelTitle.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        print("title Layer")
    }
}
