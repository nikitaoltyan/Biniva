//
//  PaywallController.swift
//  Biniva
//
//  Created by Никита Олтян on 01.08.2021.
//

import UIKit

class PaywallController: UIViewController {
    
    
    let paywallView: PaywallView = {
        let view = PaywallView()
            .with(autolayout: false)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
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
