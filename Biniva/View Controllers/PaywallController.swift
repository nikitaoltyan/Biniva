//
//  PaywallController.swift
//  Biniva
//
//  Created by Nick Oltyan on 01.08.2021.
//

import UIKit

protocol paywallDelegate {
    func close()
    func showAlert(withTitle title: String, andSubtitle subtitle: String)
    func shouldPopUpAfterPurchase(shouldShow show: Bool)
}


class PaywallController: UIViewController {
    
    let analytics = ServerAnalytics()
    
    lazy var paywallView: PaywallView = {
        let view = PaywallView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()
    
    var showPopUpAfterPurchase: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.logOpenPaywall()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if showPopUpAfterPurchase {
            if let firstVC = presentingViewController as? RecyclingController {
                DispatchQueue.main.async {
                    firstVC.updateDataAfterPaywall()
                    firstVC.showPopUp(withTitle: NSLocalizedString("paywall_pop_up_title", comment: ""),
                                      subtitle: NSLocalizedString("paywall_pop_up_desc", comment: ""),
                                      image: UIImage(named: "subscriprion_pop_up"),
                                      andButtonText: NSLocalizedString("paywall_pop_up_button", comment: ""))
                }
            }
            
            if let firstVC = presentingViewController as? SettingsController {
                DispatchQueue.main.async {
                    firstVC.tableView.reloadData()
                    firstVC.showPopUp(withTitle: NSLocalizedString("paywall_pop_up_title", comment: ""),
                                      subtitle: NSLocalizedString("paywall_pop_up_desc", comment: ""),
                                      image: UIImage(named: "subscriprion_pop_up"),
                                      andButtonText: NSLocalizedString("paywall_pop_up_button", comment: ""))
                }
            }
        }
    }
}




extension PaywallController: paywallDelegate {
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String, andSubtitle subtitle: String) {
        let alert = prepareAlert(withTitle: title,
                                 andSubtitle: subtitle,
                                 closeAction: NSLocalizedString("paywall_error_close", comment: ""))
        present(alert, animated: true, completion: nil)
    }
    
    func shouldPopUpAfterPurchase(shouldShow show: Bool) {
        showPopUpAfterPurchase = true
    }
}





extension PaywallController {
    private
    func setSubviews() {
        view.addSubview(paywallView)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            paywallView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paywallView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            paywallView.widthAnchor.constraint(equalToConstant: paywallView.frame.width),
            paywallView.heightAnchor.constraint(equalToConstant: paywallView.frame.height),
        ])
    }
}
