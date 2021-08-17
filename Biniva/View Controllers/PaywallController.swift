//
//  PaywallController.swift
//  Biniva
//
//  Created by Никита Олтян on 01.08.2021.
//

import UIKit

protocol paywallDelegate {
    func close()
    func showAlert(withTitle title: String, andSubtitle subtitle: String)
}


class PaywallController: UIViewController {
    
    let analytics = ServerAnalytics()
    
    lazy var paywallView: PaywallView = {
        let view = PaywallView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.logOpenPaywall()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? RecyclingController {
            DispatchQueue.main.async {
                firstVC.updateDataAfterPaywall()
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
