//
//  AboutUsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 11.01.2021.
//

import UIKit

class AboutUsController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1650)
        scroll.delegate = self
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    let backImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 25))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        image.image = UIImage(systemName: "chevron.left")
        return image
    }()
    
    let figureOne: UIView = {
        let scale = MainConstants.screenWidth+50
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.yellow
        view.layer.cornerRadius = 70
        view.transform = CGAffineTransform(rotationAngle: 1.93)
        return view
    }()
    
    let figureTwo: UIView = {
        let scale = MainConstants.screenWidth+50
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        view.layer.cornerRadius = 70
        view.transform = CGAffineTransform(rotationAngle: .pi/3)
        return view
    }()
    
    let figureThree: UIView = {
        let scale = MainConstants.screenWidth/2
        let view = UIView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.yellow
        view.layer.cornerRadius = scale/2
        return view
    }()
    
    let aboutUsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "О нас"
        label.font = UIFont(name: "SFPro-Heavy", size: 35)
        return label
    }()
    
    let nikitaImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 370))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Nikita_humaaans")
        return image
    }()
    
    let mashaImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 370))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Masha_humaaans")
        return image
    }()
    
    let nikitaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "Никита"
        label.font = UIFont(name: "SFPro-Bold", size: 26)
        return label
    }()
    
    let nikitaDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "Здесь будет небольшое описание какой Никита молодец!"
        label.font = UIFont(name: "SFPro", size: 18)
        return label
    }()
    
    let mashaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = MainConstants.nearBlack
        label.text = "Маша"
        label.font = UIFont(name: "SFPro-Bold", size: 26)
        return label
    }()
    
    let mashaDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = MainConstants.nearBlack
        label.text = "Здесь будет небольшое описание какая Маша молодец!"
        label.font = UIFont(name: "SFPro", size: 18)
        return label
    }()
    
    let mainAboutUsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = MainConstants.nearBlack
        label.text = "О Greener"
        label.font = UIFont(name: "SFPro-Bold", size: 30)
        return label
    }()
    
    let mainAboutUsDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = MainConstants.nearBlack
        label.text = "Здесь будет очень большое и милое описание того, почему мы сделали Гринер и вообще какие мы тут все молодцы. И кто читает тоже молодец!"
        label.font = UIFont(name: "SFPro", size: 18)
        return label
    }()
    
    let instImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "Inst_icon")
        return image
    }()
    
    let tapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "(Тапни)"
        label.font = UIFont(name: "SFPro", size: 7)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    
    @objc func Back(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    @objc func OpenInst(){
        print("Open Inst")
        let instagramHooks = "instagram://user?username=gr.ner"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
//            UIApplication.shared.openURL(instagramUrl! as URL)
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://instagram.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
}





extension AboutUsController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 250 {
            let point: CGFloat = scrollView.contentOffset.y
            let rotaton: CGFloat = 0.00177*point + 1.1312
            figureOne.transform = CGAffineTransform(rotationAngle: rotaton)
        } else if scrollView.contentOffset.y < 450 {
            let pointOne: CGFloat = scrollView.contentOffset.y
            let rotatonOne: CGFloat = 0.00177*pointOne + 1.1312
            figureOne.transform = CGAffineTransform(rotationAngle: rotatonOne)
            let pointTwo: CGFloat = scrollView.contentOffset.y
            let rotatonTwo: CGFloat = -0.0025*pointTwo + 1.67742
            figureTwo.transform = CGAffineTransform(rotationAngle: rotatonTwo)
        } else if scrollView.contentOffset.y < 530{
            let point: CGFloat = scrollView.contentOffset.y
            let rotaton: CGFloat = -0.0025*point + 1.67742
            figureTwo.transform = CGAffineTransform(rotationAngle: rotaton)
        } else if scrollView.contentOffset.y < 820 {
            let point: CGFloat = scrollView.contentOffset.y
            let transform: CGFloat = 0.0092*point - 3.9074
            figureThree.transform = CGAffineTransform(scaleX: transform, y: transform)
        }
    }
}





extension AboutUsController{
    
    func SetSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(figureOne)
        scrollView.addSubview(figureTwo)
        scrollView.addSubview(figureThree)
        scrollView.addSubview(nikitaImage)
        scrollView.addSubview(mashaImage)
        
        scrollView.addSubview(backImage)
        scrollView.addSubview(aboutUsLabel)
        scrollView.addSubview(nikitaLabel)
        scrollView.addSubview(nikitaDescLabel)
        scrollView.addSubview(mashaLabel)
        scrollView.addSubview(mashaDescLabel)
        scrollView.addSubview(mainAboutUsLabel)
        scrollView.addSubview(mainAboutUsDescLabel)
        scrollView.addSubview(instImage)
        scrollView.addSubview(tapLabel)
        
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Back)))
        instImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenInst)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            figureOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
            figureOne.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 260),
            figureOne.heightAnchor.constraint(equalToConstant: figureOne.frame.height),
            figureOne.widthAnchor.constraint(equalToConstant: figureOne.frame.width),
            
            figureTwo.topAnchor.constraint(equalTo: figureOne.bottomAnchor, constant: 0),
            figureTwo.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -260),
            figureTwo.heightAnchor.constraint(equalToConstant: figureTwo.frame.height),
            figureTwo.widthAnchor.constraint(equalToConstant: figureTwo.frame.width),
            
            figureThree.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            figureThree.topAnchor.constraint(equalTo: figureTwo.bottomAnchor, constant: 250),
            figureThree.heightAnchor.constraint(equalToConstant: figureThree.frame.height),
            figureThree.widthAnchor.constraint(equalToConstant: figureThree.frame.width),

            nikitaImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 115),
            nikitaImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 18),
            nikitaImage.heightAnchor.constraint(equalToConstant: nikitaImage.frame.height),
            nikitaImage.widthAnchor.constraint(equalToConstant: nikitaImage.frame.width),
            
            mashaImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 670),
            mashaImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            mashaImage.heightAnchor.constraint(equalToConstant: mashaImage.frame.height),
            mashaImage.widthAnchor.constraint(equalToConstant: mashaImage.frame.width),
            
            backImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            backImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            backImage.heightAnchor.constraint(equalToConstant: backImage.frame.height),
            backImage.widthAnchor.constraint(equalToConstant: backImage.frame.width),
            
            aboutUsLabel.centerYAnchor.constraint(equalTo: backImage.centerYAnchor),
            aboutUsLabel.leftAnchor.constraint(equalTo: backImage.rightAnchor, constant: 15),
            
            nikitaLabel.topAnchor.constraint(equalTo: nikitaImage.topAnchor, constant: 60),
            nikitaLabel.leftAnchor.constraint(equalTo: nikitaImage.rightAnchor),
            
            nikitaDescLabel.topAnchor.constraint(equalTo: nikitaLabel.bottomAnchor, constant: 10),
            nikitaDescLabel.leftAnchor.constraint(equalTo: nikitaLabel.leftAnchor),
            nikitaDescLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            mashaLabel.topAnchor.constraint(equalTo: mashaImage.topAnchor, constant: 60),
            mashaLabel.rightAnchor.constraint(equalTo: mashaImage.leftAnchor),
            
            mashaDescLabel.topAnchor.constraint(equalTo: mashaLabel.bottomAnchor, constant: 10),
            mashaDescLabel.rightAnchor.constraint(equalTo: mashaLabel.rightAnchor),
            mashaDescLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            mainAboutUsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainAboutUsLabel.topAnchor.constraint(equalTo: mashaImage.bottomAnchor, constant: 220),
            
            mainAboutUsDescLabel.topAnchor.constraint(equalTo: mainAboutUsLabel.bottomAnchor, constant: 18),
            mainAboutUsDescLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            mainAboutUsDescLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            
            instImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instImage.topAnchor.constraint(equalTo: mainAboutUsDescLabel.bottomAnchor, constant: 30),
            instImage.heightAnchor.constraint(equalToConstant: instImage.frame.height),
            instImage.widthAnchor.constraint(equalToConstant: instImage.frame.width),
            
            tapLabel.topAnchor.constraint(equalTo: instImage.bottomAnchor, constant: 5),
            tapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
}
