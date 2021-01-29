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
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
