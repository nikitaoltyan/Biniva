//
//  CustomAddView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 02.11.2020.
//

import UIKit

class CustomAddView: UIView {
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        return view
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
//        slider.delegate = self
        slider.maximumValue = 20
        slider.minimumValue = 10
        slider.value = 15
        slider.tintColor = MainConstants.white
        return slider
    }()
    
    let selectedView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 40} else {return 35}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        view.backgroundColor = MaterialsColors.metalBeige
        view.image.image = MaterialsIcons.metal
        return view
    }()
    
    let plusView: CompletePlusView = {
        let scale: CGFloat = 40
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        view.layer.cornerRadius = 15
        view.backgroundColor = MainConstants.white
        view.horizontalView.backgroundColor = MainConstants.green
        view.verticalView.backgroundColor = MainConstants.green
        return view
    }()
    
    let closeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.white
        view.layer.cornerRadius = 2
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func AddItem(){
        print("Add item")
    }

}





extension CustomAddView{
    func SetSubviews(){
        self.addSubview(topView)
        self.addSubview(selectedView)
        self.addSubview(plusView)
        self.addSubview(slider)
        self.addSubview(closeView)
        
        plusView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddItem)))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topView.rightAnchor.constraint(equalTo: self.leftAnchor),
            topView.heightAnchor.constraint(equalToConstant: 70),
            
            plusView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            plusView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            plusView.heightAnchor.constraint(equalToConstant: plusView.frame.height),
            plusView.widthAnchor.constraint(equalToConstant: plusView.frame.width),
            
            slider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 95),
            slider.rightAnchor.constraint(equalTo: plusView.leftAnchor, constant: -10),
            slider.heightAnchor.constraint(equalToConstant: 50),
            
            closeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            closeView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            closeView.widthAnchor.constraint(equalToConstant: 30),
            closeView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
