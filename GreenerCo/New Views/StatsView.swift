//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 19.04.2021.
//

import UIKit

class StatsView: UIView {

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.bounces = true
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 36)
            .with(autolayout: false)
        label.text = "35 кг"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "всего собрано мусора"
        return label
    }()
    
    let timeTitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Medium", size: 14)
            .with(autolayout: false)
        label.text = "максимальное значение за день"
        return label
    }()
    
    var delegate: StatsDelegate?
    
    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}




extension StatsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            delegate?.HideTopBar(true)
        } else {
            delegate?.HideTopBar(false)
        }
    }
}





extension StatsView {
    func SetSubviews(){
        self.addSubview(scrollView)
        scrollView.addSubview(weightLabel)
        scrollView.addSubview(subtitle)
        scrollView.addSubview(timeTitle)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 250),
            weightLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            subtitle.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 9),
            subtitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            timeTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 6),
            timeTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
}
