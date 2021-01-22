//
//  ProgressImageView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 03.01.2021.
//

import UIKit

class ProgressImageView: UIView {
    
    let progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        view.layer.cornerRadius = 20
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "Recycling_bin")
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = MainConstants.nearWhite.withAlphaComponent(0.1)
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension ProgressImageView{
    func SetSubviews(){
        self.addSubview(progressView)
        self.addSubview(image)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 60),
            
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
