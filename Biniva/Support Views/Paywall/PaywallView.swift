//
//  PaywallView.swift
//  Biniva
//
//  Created by Никита Олтян on 01.08.2021.
//

import UIKit
import Adapty

class PaywallView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()

    let closeButton: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(alignment: .center)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 16)
        label.text = "Закрыть"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let titleBlack: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 26
            case 736: return 26
            default: return 28
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: textSize)
        label.text = "Поддержи проект эко-карты Biniva"
        return label
    }()
    
    let subtitle_1: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 23)
        label.text = "Помоги нам развиваться и позволь большему количеству людей переработать мусор"
        return label
    }()
    
    let subtitle_1_image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 21))
            .with(autolayout: false)
        image.image = UIImage(systemName: "person.3.fill")
        image.tintColor = Colors.topGradient
        return image
    }()
    
    let subtitle_2: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 23)
        label.text = "Открой доступ к расширеной статистике и эксклюзивным советам по Zero Waste"
        return label
    }()
    
    let subtitle_2_image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
            .with(autolayout: false)
        image.image = UIImage(systemName: "checkmark.seal.fill")
        image.tintColor = Colors.topGradient
        return image
    }()
    
    let subtitle_3: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 23)
        label.text = "Помоги сделать мир чище!"
        return label
    }()
    
    let subtitle_3_image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 26, height: 22))
            .with(autolayout: false)
        image.image = UIImage(systemName: "megaphone.fill")
        image.tintColor = Colors.topGradient
        return image
    }()
    
    let annualPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-20, height: 225))
            .with(autolayout: false)
            .with(cornerRadius: 16)
            .with(borderWidth: 3, color: Colors.topGradient.cgColor)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
    lazy var annualGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.annualPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let annualTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 15)
        label.text = "Годовая поддержка проекта позволит:"
        return label
    }()
    
    let annualText: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 15)
        label.text = "80 новым людям найти место переработки мусора рядом с домом.\n\nДополнительно сдать на переработку 3.2 тонны мусора в год."
        return label
    }()
    
    let annualPrice: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 16)
        label.text = "$29.99 per year"
        return label
    }()
    
    let monthlyPlateView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth/2-20, height: 225))
            .with(autolayout: false)
            .with(cornerRadius: 16)
            .with(borderWidth: 0, color: Colors.topGradient.cgColor)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()

    lazy var monthlyGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.monthlyPlateView.frame
        gradient.colors = [Colors.background.cgColor,
                           Colors.sliderGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y:-0.3)
        gradient.endPoint = CGPoint(x: 0.6, y: 1.25)
        return gradient
    }()
    
    let monthlyTitle: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Medium", size: 15)
        label.text = "Ежемесячная поддержка проекта позволит:"
        label.alpha = 0
        return label
    }()
    
    let monthlyText: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 15)
        label.text = "120 новым людям найти место переработки мусора рядом с домом.\n\nДополнительно сдать на переработку 4.8 тонны мусора в год."
        return label
    }()
    
    let monthlyPrice: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 16)
        label.text = "$3.99 per month"
        return label
    }()
    
    let continueButton: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = NSLocalizedString("onboarding_next", comment: "the Continue label")
        return view
    }()
    
    let restoreButton: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(alignment: .center)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 16)
        label.text = "Восстановить покупки"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let skipButton: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(alignment: .center)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 16)
        label.text = "Пропустить"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    enum subscriptionType {
        case monthly
        case annual
    }
    
    var choosedSubscriptionType: subscriptionType = .annual
    var annualProduct: ProductModel?
    var monthlyProduct: ProductModel?
    
    override init(frame: CGRect) {
        let useFrame: CGRect = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        prepareSubscriptions()
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private
    func prepareSubscriptions() {
        var paywall: PaywallModel?
        Adapty.getPaywalls { (paywalls, _, error) in
            guard error == nil else  { return }
            paywall = paywalls?.first(where: { $0.developerId == "001" }) //001 is my Paywall ID
            guard let paywall = paywall else { return }
            
            self.annualProduct = paywall.products.first
            self.monthlyProduct = paywall.products[1]
            Adapty.logShowPaywall(paywall)
            print("Subscriptions were prepared")
        }
    }
    
    
    @objc
    func closeAction() {
        Vibration.soft()
        closeButton.tap(completion: { _ in
            // TODO
            print("Close")
        })
    }
    
    @objc
    func chooseAnnualAction() {
        guard annualPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        choosedSubscriptionType = .annual
        UIView.animate(withDuration: 0.1, animations: {
            self.annualPlateView.layer.borderWidth = 3
            self.monthlyPlateView.layer.borderWidth = 0
            self.annualTitle.alpha = 1
            self.monthlyTitle.alpha = 0
        })
    }
    
    
    @objc
    func chooseMonthlyAction() {
        guard monthlyPlateView.layer.borderWidth == 0 else {
            return
        }
        Vibration.soft()
        choosedSubscriptionType = .monthly
        UIView.animate(withDuration: 0.1, animations: {
            self.monthlyPlateView.layer.borderWidth = 3
            self.annualPlateView.layer.borderWidth = 0
            self.monthlyTitle.alpha = 1
            self.annualTitle.alpha = 0
        })
    }
    
    @objc
    func continueAction() {
        Vibration.soft()
        continueButton.tap(completion: { _ in
            print("BUY SUBSCRIPTION")
            print("choosedSubscriptionType: \(self.choosedSubscriptionType)")
            
            switch self.choosedSubscriptionType {
            case .annual:
                guard let product = self.annualProduct else { return }
                Adapty.makePurchase(product: product) { (purchaserInfo, receipt, appleValidationResult, product, error) in
                    if error == nil {
                        // successful purchase
                        // TODO
                    } else {
                        print("Error: \(error!)")
                    }
                }

            case .monthly:
                guard let product = self.monthlyProduct else { return }
                Adapty.makePurchase(product: product) { (purchaserInfo, receipt, appleValidationResult, product, error) in
                    if error == nil {
                        // successful purchase
                        // TODO
                    } else {
                        print("Error: \(error!)")
                    }
                }
            }
        })
    }
    
    @objc
    func restoreAction() {
        Vibration.soft()
        restoreButton.tap(completion: { _ in
            print("Restore purchases")
            Adapty.restorePurchases { (purchaserInfo, receipt, appleValidationResult, error) in
                if error == nil {
                    // successful restore
                    // TODO
                }
            }
        })
    }
    
    @objc
    func skipAction() {
        Vibration.soft()
        skipButton.tap(completion: { _ in
            // TODO
            print("Close")
        })
    }
}







extension PaywallView {
    private
    func setSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleBlack)
        
        scrollView.addSubview(subtitle_1)
        scrollView.addSubview(subtitle_1_image)
        scrollView.addSubview(subtitle_2)
        scrollView.addSubview(subtitle_2_image)
        scrollView.addSubview(subtitle_3)
        scrollView.addSubview(subtitle_3_image)
        
        scrollView.addSubview(annualPlateView)
        scrollView.addSubview(annualTitle)
        scrollView.addSubview(monthlyPlateView)
        scrollView.addSubview(monthlyTitle)
        
        annualPlateView.layer.addSublayer(annualGradient)
        annualPlateView.addSubview(annualText)
        annualPlateView.addSubview(annualPrice)
        monthlyPlateView.layer.addSublayer(monthlyGradient)
        monthlyPlateView.addSubview(monthlyText)
        monthlyPlateView.addSubview(monthlyPrice)
        
        scrollView.addSubview(continueButton)
        scrollView.addSubview(restoreButton)
        scrollView.addSubview(skipButton)
        
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        annualPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAnnualAction)))
        monthlyPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseMonthlyAction)))
        continueButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(continueAction)))
        restoreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restoreAction)))
        skipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipAction)))
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            titleBlack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -90),
            
            subtitle_1.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 40),
            subtitle_1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            subtitle_1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75),
            
            subtitle_1_image.rightAnchor.constraint(equalTo: subtitle_1.leftAnchor, constant: -20),
            subtitle_1_image.centerYAnchor.constraint(equalTo: subtitle_1.centerYAnchor),
            subtitle_1_image.widthAnchor.constraint(equalToConstant: subtitle_1_image.frame.width),
            subtitle_1_image.heightAnchor.constraint(equalToConstant: subtitle_1_image.frame.height),
            
            subtitle_2.topAnchor.constraint(equalTo: subtitle_1.bottomAnchor, constant: 25),
            subtitle_2.rightAnchor.constraint(equalTo: subtitle_1.rightAnchor),
            subtitle_2.leftAnchor.constraint(equalTo: subtitle_1.leftAnchor),
            
            subtitle_2_image.rightAnchor.constraint(equalTo: subtitle_1_image.rightAnchor),
            subtitle_2_image.centerYAnchor.constraint(equalTo: subtitle_2.centerYAnchor),
            subtitle_2_image.widthAnchor.constraint(equalToConstant: subtitle_2_image.frame.width),
            subtitle_2_image.heightAnchor.constraint(equalToConstant: subtitle_2_image.frame.height),
            
            subtitle_3.topAnchor.constraint(equalTo: subtitle_2.bottomAnchor, constant: 25),
            subtitle_3.rightAnchor.constraint(equalTo: subtitle_1.rightAnchor),
            subtitle_3.leftAnchor.constraint(equalTo: subtitle_1.leftAnchor),
            
            subtitle_3_image.rightAnchor.constraint(equalTo: subtitle_1_image.rightAnchor),
            subtitle_3_image.centerYAnchor.constraint(equalTo: subtitle_3.centerYAnchor),
            subtitle_3_image.widthAnchor.constraint(equalToConstant: subtitle_3_image.frame.width),
            subtitle_3_image.heightAnchor.constraint(equalToConstant: subtitle_3_image.frame.height),
            
            annualPlateView.topAnchor.constraint(equalTo: subtitle_3.bottomAnchor, constant: 84),
            annualPlateView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            annualPlateView.widthAnchor.constraint(equalToConstant: annualPlateView.frame.width),
            annualPlateView.heightAnchor.constraint(equalToConstant: annualPlateView.frame.height),
            
            annualTitle.leftAnchor.constraint(equalTo: annualPlateView.leftAnchor, constant: 4),
            annualTitle.rightAnchor.constraint(equalTo: annualPlateView.rightAnchor),
            annualTitle.bottomAnchor.constraint(equalTo: annualPlateView.topAnchor, constant: -10),
            
            annualText.topAnchor.constraint(equalTo: annualPlateView.topAnchor, constant: 14),
            annualText.leftAnchor.constraint(equalTo: annualPlateView.leftAnchor, constant: 11),
            annualText.rightAnchor.constraint(equalTo: annualPlateView.rightAnchor, constant: -11),
            
            annualPrice.bottomAnchor.constraint(equalTo: annualPlateView.bottomAnchor, constant: -15),
            annualPrice.centerXAnchor.constraint(equalTo: annualPlateView.centerXAnchor),
            
            monthlyPlateView.topAnchor.constraint(equalTo: annualPlateView.topAnchor),
            monthlyPlateView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            monthlyPlateView.widthAnchor.constraint(equalToConstant: monthlyPlateView.frame.width),
            monthlyPlateView.heightAnchor.constraint(equalToConstant: monthlyPlateView.frame.height),
            
            monthlyTitle.leftAnchor.constraint(equalTo: monthlyPlateView.leftAnchor, constant: 4),
            monthlyTitle.rightAnchor.constraint(equalTo: monthlyPlateView.rightAnchor),
            monthlyTitle.bottomAnchor.constraint(equalTo: monthlyPlateView.topAnchor, constant: -10),
            
            monthlyText.topAnchor.constraint(equalTo: monthlyPlateView.topAnchor, constant: 14),
            monthlyText.leftAnchor.constraint(equalTo: monthlyPlateView.leftAnchor, constant: 11),
            monthlyText.rightAnchor.constraint(equalTo: monthlyPlateView.rightAnchor, constant: -11),
            
            monthlyPrice.bottomAnchor.constraint(equalTo: monthlyPlateView.bottomAnchor, constant: -15),
            monthlyPrice.centerXAnchor.constraint(equalTo: monthlyPlateView.centerXAnchor),
            
            continueButton.topAnchor.constraint(equalTo: annualPlateView.bottomAnchor, constant: 30),
            continueButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: continueButton.frame.width),
            continueButton.heightAnchor.constraint(equalToConstant: continueButton.frame.height),
            
            restoreButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 15),
            restoreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            skipButton.topAnchor.constraint(equalTo: restoreButton.bottomAnchor, constant: 15),
            skipButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
