//
//  PaywallView.swift
//  Biniva
//
//  Created by Никита Олтян on 01.08.2021.
//

import UIKit
import Adapty

class PaywallView: UIView {
    
    let defaults = Defaults()
    
    lazy var scrollView: UIScrollView = {
        let scrollHeight: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 910
            default: return 1000
            }
        }()
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: scrollHeight)
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
        label.text = NSLocalizedString("paywall_close_button", comment: "Close title for that button")
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
        label.text = NSLocalizedString("paywall_title", comment: "The whole view title")
        return label
    }()
    
    let subtitle_1: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 23
            default: return 23
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: textSize)
        label.text = NSLocalizedString("paywall_subtitle_1", comment: "The reason of purchase 1")
        return label
    }()
    
    let subtitle_1_image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            .with(autolayout: false)
        image.image = UIImage(systemName: "person.3.fill")
        image.tintColor = Colors.topGradient
        return image
    }()
    
    let subtitle_2: UILabel = {
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 23
            default: return 23
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: textSize)
        label.text = NSLocalizedString("paywall_subtitle_2", comment: "The reason of purchase 2")
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
        let textSize: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 23
            default: return 23
            }
        }()
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: textSize)
        label.text = NSLocalizedString("paywall_subtitle_3", comment: "The reason of purchase 3")
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
        label.text = NSLocalizedString("paywall_annual_title", comment: "Title for annual plate")
        return label
    }()
    
    let annualText: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 14)
        label.text = NSLocalizedString("paywall_annual_text", comment: "In-plate text")
        return label
    }()
    
    let annualPrice: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 16)
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
        label.text = NSLocalizedString("paywall_monthly_title", comment: "Title for monthly plate")
        label.alpha = 0
        return label
    }()
    
    let monthlyText: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 14)
        label.text = NSLocalizedString("paywall_monthly_text", comment: "In-plate text")
        return label
    }()
    
    let monthlyPrice: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro-Bold", size: 16)
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
        label.text = NSLocalizedString("paywall_restore_purchases", comment: "Restore purchases")
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
        label.text = NSLocalizedString("paywall_skip", comment: "Skip")
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let descGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = NSLocalizedString("paywall_description_1", comment: "description before conditions")
        return label
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 12)
        label.isUserInteractionEnabled = true
        label.text = NSLocalizedString("paywall_conditions", comment: "Conditions")
        return label
    }()
    
    let privacyPolicyLabel: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 12)
        label.isUserInteractionEnabled = true
        label.text = NSLocalizedString("paywall_privacy_policy", comment: "Privacy Policy")
        return label
    }()
    
    let descVolumesGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = NSLocalizedString("paywall_description_2", comment: "Description about used numbers in Plates")
        return label
    }()
    
    var delegate: paywallDelegate?
    
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
            
            print("Subscription was prepared")
            self.annualProduct = paywall.products.first
            self.monthlyProduct = paywall.products[1]
            Adapty.logShowPaywall(paywall)
            
            // Setting prices that were got from the product
            self.annualPrice.text = "\(self.annualProduct?.currencySymbol ?? "NaN")\(self.annualProduct?.price ?? 0)\(NSLocalizedString("paywall_annual_price_tag", comment: "tag for annual"))"
            self.monthlyPrice.text = "\(self.monthlyProduct?.currencySymbol ?? "NaN")\(self.monthlyProduct?.price ?? 0)\(NSLocalizedString("paywall_monthly_price_tag", comment: "tag for annual"))"
        }
    }
    
    
    @objc
    func closeAction() {
        Vibration.soft()
        closeButton.tap(completion: { _ in
            print("Close")
            self.delegate?.close()
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
                        print("successful purchase")
                        self.defaults.setSubscriptionStatus()
                        self.closeAction()
                    } else {
                        print("Error: \(error!)")
                        self.defaults.setSubscriptionStatus()
                        self.showErrorAlert()
                    }
                }

            case .monthly:
                guard let product = self.monthlyProduct else { return }
                Adapty.makePurchase(product: product) { (purchaserInfo, receipt, appleValidationResult, product, error) in
                    if error == nil {
                        // successful purchase
                        print("successful purchase")
                        self.defaults.setSubscriptionStatus()
                        self.closeAction()
                    } else {
                        print("Error: \(error!)")
                        self.defaults.setSubscriptionStatus()
                        self.showErrorAlert()
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
                    print("Subscription restored")
                    self.defaults.setSubscriptionStatus()
                    self.closeAction()
                }
            }
        })
    }
    
    @objc
    func skipAction() {
        Vibration.soft()
        skipButton.tap(completion: { _ in
            print("Close")
            self.delegate?.close()
        })
    }
    
    @objc
    func conditionsAction() {
        conditionsLabel.tap(completion: { _ in
            if let url = URL(string: NSLocalizedString("paywall_terms_of_use_url", comment: "terms of use link")) {
                UIApplication.shared.open(url)
            }
        })
    }
    
    @objc private
    func privacyPolicyAction() {
        privacyPolicyLabel.tap(completion: { _ in
            if let url = URL(string: NSLocalizedString("paywall_privacy_policy_url", comment: "privacy policy link")) {
                UIApplication.shared.open(url)
            }
        })
    }
    
    private
    func showErrorAlert() {
        delegate?.showAlert(withTitle: "Error", andSubtitle: "Error subtitle")
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
        scrollView.addSubview(descGray)
        scrollView.addSubview(conditionsLabel)
        scrollView.addSubview(privacyPolicyLabel)
        scrollView.addSubview(descVolumesGray)
        
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAction)))
        annualPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAnnualAction)))
        monthlyPlateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseMonthlyAction)))
        continueButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(continueAction)))
        restoreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restoreAction)))
        skipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipAction)))
        conditionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(conditionsAction)))
        privacyPolicyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyPolicyAction)))
    }
    
    private
    func activateLayouts() {
        let titleBlackTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 15
            case 736: return 20
            default: return 37
            }
        }()
        let subtitle_1TopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 17
            case 736: return 20
            default: return 35
            }
        }()
        let subtitlesTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 12
            case 736: return 20
            default: return 25
            }
        }()
        let plateTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 70
            case 736: return 78
            default: return 84
            }
        }()
        let continueButtonTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 17
            case 736: return 25
            default: return 30
            }
        }()
        let restoreTopConstant: CGFloat = {
            switch MainConstants.screenHeight {
            case ...700: return 10
            default: return 15
            }
        }()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            titleBlack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: titleBlackTopConstant),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -90),
            
            subtitle_1.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: subtitle_1TopConstant),
            subtitle_1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            subtitle_1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75),
            
            subtitle_1_image.rightAnchor.constraint(equalTo: subtitle_1.leftAnchor, constant: -20),
            subtitle_1_image.centerYAnchor.constraint(equalTo: subtitle_1.centerYAnchor),
            subtitle_1_image.widthAnchor.constraint(equalToConstant: subtitle_1_image.frame.width),
            subtitle_1_image.heightAnchor.constraint(equalToConstant: subtitle_1_image.frame.height),
            
            subtitle_2.topAnchor.constraint(equalTo: subtitle_1.bottomAnchor, constant: subtitlesTopConstant),
            subtitle_2.rightAnchor.constraint(equalTo: subtitle_1.rightAnchor),
            subtitle_2.leftAnchor.constraint(equalTo: subtitle_1.leftAnchor),
            
            subtitle_2_image.rightAnchor.constraint(equalTo: subtitle_1_image.rightAnchor),
            subtitle_2_image.centerYAnchor.constraint(equalTo: subtitle_2.centerYAnchor),
            subtitle_2_image.widthAnchor.constraint(equalToConstant: subtitle_2_image.frame.width),
            subtitle_2_image.heightAnchor.constraint(equalToConstant: subtitle_2_image.frame.height),
            
            subtitle_3.topAnchor.constraint(equalTo: subtitle_2.bottomAnchor, constant: subtitlesTopConstant),
            subtitle_3.rightAnchor.constraint(equalTo: subtitle_1.rightAnchor),
            subtitle_3.leftAnchor.constraint(equalTo: subtitle_1.leftAnchor),
            
            subtitle_3_image.rightAnchor.constraint(equalTo: subtitle_1_image.rightAnchor),
            subtitle_3_image.centerYAnchor.constraint(equalTo: subtitle_3.centerYAnchor),
            subtitle_3_image.widthAnchor.constraint(equalToConstant: subtitle_3_image.frame.width),
            subtitle_3_image.heightAnchor.constraint(equalToConstant: subtitle_3_image.frame.height),
            
            annualPlateView.topAnchor.constraint(equalTo: subtitle_3.bottomAnchor, constant: plateTopConstant),
            annualPlateView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 13),
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
            monthlyPlateView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -13),
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
            
            continueButton.topAnchor.constraint(equalTo: annualPlateView.bottomAnchor, constant: continueButtonTopConstant),
            continueButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: continueButton.frame.width),
            continueButton.heightAnchor.constraint(equalToConstant: continueButton.frame.height),
            
            restoreButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: restoreTopConstant),
            restoreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            skipButton.topAnchor.constraint(equalTo: restoreButton.bottomAnchor, constant: restoreTopConstant),
            skipButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descGray.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 12),
            descGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            descGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            conditionsLabel.topAnchor.constraint(equalTo: descGray.bottomAnchor, constant: 3),
            conditionsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -70),
            
            privacyPolicyLabel.topAnchor.constraint(equalTo: descGray.bottomAnchor, constant: 3),
            privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 64),
            
            descVolumesGray.topAnchor.constraint(equalTo: privacyPolicyLabel.bottomAnchor, constant: 14),
            descVolumesGray.leftAnchor.constraint(equalTo: descGray.leftAnchor),
            descVolumesGray.rightAnchor.constraint(equalTo: descGray.rightAnchor),
        ])
    }
}
