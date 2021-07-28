//
//  ViewController Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.01.2021.
//

import Foundation
import UIKit



extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func prepareAlert(withTitle title: String, andSubtitle subtitle: String, closeAction close: String) -> UIAlertController {
        Vibration.soft()
        let alert = UIAlertController(title: title,
                                      message: subtitle,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: close,
                                      style: .cancel,
                                      handler: { (_) in }))

        return alert
    }
    
    
    func showPopUp(withTitle title: String, subtitle: String, andButtonText buttonText: String) {
        let newVC = PopUpController()
        newVC.setUpTitles(title: title,
                          description: subtitle,
                          buttonTitle: buttonText)
        newVC.modalPresentationStyle = .overFullScreen
        present(newVC, animated: true, completion: nil)
    }
}
