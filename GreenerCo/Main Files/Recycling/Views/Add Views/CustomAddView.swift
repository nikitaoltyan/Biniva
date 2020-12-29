//
//  CustomAddView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddView: UIView {
    
    var selectedImage: UIImageView?
    var plus: UIView!

    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
//        AddImage()
        AddPlusView()
        AddSlider()
        AddCloseView()
    }
    
    func ChangeSelectedImage(image: UIImage){
        print("Function from another class was called")
        print("Current image: \(selectedImage)")
        print("Change image to \(image)")
    }
    
    @objc func AddItem(){
        print("Add item")
    }
    
    
    func AddSlider(){
        let slider = UISlider()
        self.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            slider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 95),
            slider.rightAnchor.constraint(equalTo: plus.leftAnchor, constant: -10),
            slider.heightAnchor.constraint(equalToConstant: 50)
        ])
        slider.maximumValue = 20
        slider.minimumValue = 10
        slider.value = 15
        slider.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func AddCloseView(){
        let closeView = UIView()
        self.addSubview(closeView)
        closeView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        closeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            closeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeView.widthAnchor.constraint(equalToConstant: 30),
            closeView.heightAnchor.constraint(equalToConstant: 5)
        ])
        closeView.layer.cornerRadius = 2
    }
    
    func AddPlusView(){
        let plusView = UIView()
        self.addSubview(plusView)
        plusView.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        plusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            plusView.heightAnchor.constraint(equalToConstant: 40),
            plusView.widthAnchor.constraint(equalToConstant: 40)
        ])
        plus = plusView
        AddPlusLines()
        plus.layer.cornerRadius = 15
        plus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddItem)))
    }
    
    func AddPlusLines(){
        let vert = UIView()
        let horiz = UIView()
        plus.addSubview(vert)
        plus.addSubview(horiz)
        vert.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        horiz.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        vert.translatesAutoresizingMaskIntoConstraints = false
        horiz.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vert.topAnchor.constraint(equalTo: plus.topAnchor, constant: 4),
            vert.centerXAnchor.constraint(equalTo: plus.centerXAnchor),
            vert.widthAnchor.constraint(equalToConstant: 8),
            vert.bottomAnchor.constraint(equalTo: plus.bottomAnchor, constant: -4)
        ])
        NSLayoutConstraint.activate([
            horiz.leftAnchor.constraint(equalTo: plus.leftAnchor, constant: 4),
            horiz.centerYAnchor.constraint(equalTo: plus.centerYAnchor),
            horiz.heightAnchor.constraint(equalToConstant: 8),
            horiz.rightAnchor.constraint(equalTo: plus.rightAnchor, constant: -4)
        ])
        let cornerRadius = 3 as CGFloat
        horiz.layer.cornerRadius = cornerRadius
        vert.layer.cornerRadius = cornerRadius
    }

}

protocol abc {
    func xyz()
}
