//
//  OnboardingController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 18.01.2021.
//

import UIKit

class OnboardingController: UIViewController {

    let personImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 230, height: 280))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "person_sitting")
        return image
    }()
    
    let plantOneImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 150))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "plant_2")
        return image
    }()
    let plantTwoImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 150))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "plant_1")
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }

}





extension OnboardingController {
    
    func SetSubviews(){
        view.addSubview(personImage)
        view.addSubview(plantOneImage)
        view.addSubview(plantTwoImage)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            personImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            personImage.heightAnchor.constraint(equalToConstant: personImage.frame.height),
            personImage.widthAnchor.constraint(equalToConstant: personImage.frame.width),
            
            plantOneImage.bottomAnchor.constraint(equalTo: personImage.bottomAnchor),
            plantOneImage.leftAnchor.constraint(equalTo: personImage.leftAnchor),
            plantOneImage.heightAnchor.constraint(equalToConstant: plantOneImage.frame.height),
            plantOneImage.widthAnchor.constraint(equalToConstant: plantOneImage.frame.width),
            
            plantTwoImage.bottomAnchor.constraint(equalTo: personImage.bottomAnchor),
            plantTwoImage.leftAnchor.constraint(equalTo: personImage.rightAnchor),
            plantTwoImage.heightAnchor.constraint(equalToConstant: plantTwoImage.frame.height),
            plantTwoImage.widthAnchor.constraint(equalToConstant: plantTwoImage.frame.width),
        ])
    }
}
