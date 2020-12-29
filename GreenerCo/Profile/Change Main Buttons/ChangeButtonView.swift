//
//  ChangeButtonView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.11.2020.
//

import UIKit

class ChangeButtonView: UIView {

    override func awakeFromNib() {
        AddCloseView()
    }
    
    func AddCloseView(){
        let closeView = UIView()
        self.addSubview(closeView)
        closeView.backgroundColor = .darkGray
        closeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            closeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeView.widthAnchor.constraint(equalToConstant: 30),
            closeView.heightAnchor.constraint(equalToConstant: 5)
        ])
        closeView.layer.cornerRadius = 2
    }
}
