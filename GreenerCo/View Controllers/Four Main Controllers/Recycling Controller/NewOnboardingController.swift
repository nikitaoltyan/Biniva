//
//  NewOnboardingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 11.05.2021.
//

import UIKit

class NewOnboardingController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(bgColor: Colors.background)
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1400)
        scroll.bounces = true
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    let bgViewOne: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 550, height: 550))
            .with(bgColor: Colors.topGradient.withAlphaComponent(0.3))
            .with(cornerRadius: 20)
            .with(autolayout: false)
        return view
    }()
    
    let bgViewTwo: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 600))
            .with(bgColor: Colors.sliderGray)
            .with(cornerRadius: 10)
            .with(autolayout: false)
        return view
    }()
    
    let bgViewThree: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            .with(bgColor: Colors.bottomGradient.withAlphaComponent(0.3))
            .with(cornerRadius: 30)
            .with(autolayout: false)
        return view
    }()
    
    let blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blur)
            .with(autolayout: false)
        return blurredEffectView
    }()
    
    let name: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 50)
            .with(autolayout: false)
        label.text = "Greener"
        return label
    }()
    
    let descOne: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "Это приложение поможет следить за уровнем создаваемого загрязнения."
        return label
    }()
    
    let descTwo: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "Просто добавляйте мусор, чтобы всегда быть в курсе, какой объем мусора вы создали. Это поможет вам лучше ориентироваться в уровне своего потребления и, по возможности, его снизить."
        return label
    }()
    
    let descThree: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(autolayout: false)
        label.text = "Заполняй круг за кругом!"
        return label
    }()
    
    let progressView: ProgressView = {
        let height: CGFloat = 350
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: height, height: height))
            .with(autolayout: false)
        return view
    }()
    
    let descFour: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "Мы понимаем, что люди выбрасывают разные материалы, поэтому максимально упростили процесс добавления мусора."
        return label
    }()
    
    let descFive: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 22)
            .with(autolayout: false)
        label.text = "Выбирай то, что тебе ближе!"
        return label
    }()
    
    let materialOne: UIImageView = {
        let size: CGFloat = 150
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: "plastic")
        return image
    }()
    
    let materialTwo: UIImageView = {
        let size: CGFloat = 150
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: "glass")
        return image
    }()
    
    let materialThree: UIImageView = {
        let size: CGFloat = 150
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: "organic")
        return image
    }()
    
    let materialFour: UIImageView = {
        let size: CGFloat = 150
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            .with(autolayout: false)
        image.image = UIImage(named: "paper")
        return image
    }()
    
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.label.text = "Начать!"
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        activateLayouts()
        setUpFisrtPositions()
    }

    func setUpFisrtPositions(){
        bgViewOne.transform = CGAffineTransform(rotationAngle: -.pi*2/3)
        bgViewTwo.transform = CGAffineTransform(rotationAngle: -.pi*2/3)
        bgViewThree.transform = CGAffineTransform(rotationAngle: -.pi*2/3)
        progressView.update(addWeight: 1095)
    }
    
    @objc
    func close(){
        Defaults.setHasLaunched(true)
        let newVC = RecyclingController()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }
}




extension NewOnboardingController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // add animations for scrolling.
        materialOne.transform = CGAffineTransform(translationX: scrollView.contentOffset.y/4, y: 0)
        materialTwo.transform = CGAffineTransform(translationX: scrollView.contentOffset.y/4, y: 0)
        materialThree.transform = CGAffineTransform(translationX: scrollView.contentOffset.y/4, y: 0)
        materialFour.transform = CGAffineTransform(translationX: scrollView.contentOffset.y/4, y: 0)
    }
}





extension NewOnboardingController {
    func setSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(bgViewOne)
        scrollView.addSubview(bgViewTwo)
        scrollView.addSubview(bgViewThree)
        scrollView.addSubview(blur)
        
        scrollView.addSubview(name)
        scrollView.addSubview(descOne)
        scrollView.addSubview(descTwo)
        scrollView.addSubview(descThree)
        scrollView.addSubview(progressView)
        scrollView.addSubview(descFour)
        scrollView.addSubview(descFive)
        
        scrollView.addSubview(materialOne)
        scrollView.addSubview(materialTwo)
        scrollView.addSubview(materialThree)
        scrollView.addSubview(materialFour)
        scrollView.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    
    func activateLayouts(){
//        let buttonBottomConst: CGFloat = {
//            if MainConstants.screenHeight == 736 { return -40 }
//            else if MainConstants.screenHeight > 700 { return -66 }
//            else { return -30 }
//        }()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bgViewOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 130),
            bgViewOne.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: -50),
            bgViewOne.heightAnchor.constraint(equalToConstant: bgViewOne.frame.height),
            bgViewOne.widthAnchor.constraint(equalToConstant: bgViewOne.frame.width),

            bgViewTwo.topAnchor.constraint(equalTo: bgViewOne.topAnchor),
            bgViewTwo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            bgViewTwo.heightAnchor.constraint(equalToConstant: bgViewTwo.frame.height),
            bgViewTwo.widthAnchor.constraint(equalToConstant: bgViewTwo.frame.width),
            
            bgViewThree.topAnchor.constraint(equalTo: bgViewTwo.bottomAnchor, constant: 130),
            bgViewThree.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgViewThree.heightAnchor.constraint(equalToConstant: bgViewThree.frame.height),
            bgViewThree.widthAnchor.constraint(equalToConstant: bgViewThree.frame.width),
            
            blur.topAnchor.constraint(equalTo: view.topAnchor),
            blur.leftAnchor.constraint(equalTo: view.leftAnchor),
            blur.rightAnchor.constraint(equalTo: view.rightAnchor),
            blur.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            name.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            
            descOne.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            descOne.leftAnchor.constraint(equalTo: name.leftAnchor),
            descOne.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            descTwo.topAnchor.constraint(equalTo: descOne.bottomAnchor, constant: 20),
            descTwo.leftAnchor.constraint(equalTo: descOne.leftAnchor),
            descTwo.rightAnchor.constraint(equalTo: descOne.rightAnchor),
            
            descThree.topAnchor.constraint(equalTo: descTwo.bottomAnchor, constant: 35),
            descThree.leftAnchor.constraint(equalTo: descOne.leftAnchor),
            descThree.rightAnchor.constraint(equalTo: descOne.rightAnchor),
            
            progressView.topAnchor.constraint(equalTo: descThree.bottomAnchor, constant: 20),
            progressView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            
            descFour.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 35),
            descFour.leftAnchor.constraint(equalTo: descOne.leftAnchor),
            descFour.rightAnchor.constraint(equalTo: descOne.rightAnchor),
            
            descFive.topAnchor.constraint(equalTo: descFour.bottomAnchor, constant: 20),
            descFive.leftAnchor.constraint(equalTo: descOne.leftAnchor),
            descFive.rightAnchor.constraint(equalTo: descOne.rightAnchor),
            
            materialOne.topAnchor.constraint(equalTo: descFive.bottomAnchor, constant: 45),
            materialOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -175),
            materialOne.heightAnchor.constraint(equalToConstant: materialOne.frame.height),
            materialOne.widthAnchor.constraint(equalToConstant: materialOne.frame.width),
            
            materialTwo.topAnchor.constraint(equalTo: materialOne.topAnchor),
            materialTwo.leftAnchor.constraint(equalTo: materialOne.rightAnchor),
            materialTwo.heightAnchor.constraint(equalToConstant: materialTwo.frame.height),
            materialTwo.widthAnchor.constraint(equalToConstant: materialTwo.frame.width),
            
            materialThree.topAnchor.constraint(equalTo: materialTwo.topAnchor),
            materialThree.leftAnchor.constraint(equalTo: materialTwo.rightAnchor),
            materialThree.heightAnchor.constraint(equalToConstant: materialThree.frame.height),
            materialThree.widthAnchor.constraint(equalToConstant: materialThree.frame.width),
            
            materialFour.topAnchor.constraint(equalTo: materialThree.topAnchor),
            materialFour.leftAnchor.constraint(equalTo: materialThree.rightAnchor),
            materialFour.heightAnchor.constraint(equalToConstant: materialFour.frame.height),
            materialFour.widthAnchor.constraint(equalToConstant: materialFour.frame.width),
            
            button.topAnchor.constraint(equalTo: materialFour.bottomAnchor, constant: 80),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width)
        ])
    }
}
