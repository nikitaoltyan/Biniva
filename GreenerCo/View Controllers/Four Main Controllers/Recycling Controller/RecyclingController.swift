//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class RecyclingController: UIViewController {
    
    let topView: TopView = {
        let view = TopView()
            .with(bgColor: Colors.background)
            .with(autolayout: false)
        view.title.text = "Переработка"
        view.subtitle.text = "поможем сегодня природе?"
        return view
    }()
    
    let progressView: ProgressView = {
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            .with(bgColor: .white)
            .with(autolayout: false)
        return view
    }()
    
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        SetSubviews()
        ActivateLayouts()
    }
}







extension RecyclingController {
    func SetSubviews(){
        view.addSubview(topView)
        view.addSubview(progressView)
        view.addSubview(button)
    }
        
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: topView.frame.height),
            topView.widthAnchor.constraint(equalToConstant: topView.frame.width),
            
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: progressView.frame.width),
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
            button.widthAnchor.constraint(equalToConstant: button.frame.width)
        ])
    }
}

