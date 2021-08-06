//
//  PaywallController.swift
//  Biniva
//
//  Created by Никита Олтян on 01.08.2021.
//

import UIKit

protocol paywallDelegate {
    func close()
}


class PaywallController: UIViewController {
    
    lazy var paywallView: PaywallView = {
        let view = PaywallView()
            .with(autolayout: false)
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

}




extension PaywallController: paywallDelegate {
    func close() {
        dismiss(animated: true, completion: nil)
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
