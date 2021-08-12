//
//  WeeklyStatsCell.swift
//  Biniva
//
//  Created by Nick Oltyan on 11.08.2021.
//

import UIKit

class WeeklyStatsCell: UICollectionViewCell {

    let percent: UILabel = {
        let label = UILabel()
            .with(color: Colors.background)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 11)
            .with(autolayout: false)
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 70))
            .with(bgColor: .orange)
            .with(autolayout: false)
            .with(cornerRadius: 3)
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 14)
            .with(autolayout: false)
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            .with(autolayout: false)
        return image
    }()
    
    var colorViewBottom: NSLayoutConstraint?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateHeight(height: CGFloat) {
        self.layoutIfNeeded()
        colorViewBottom?.constant = height
    }
    
    func updateMaterial(id: Int) {
        colorView.backgroundColor = materials.statsColors[id]
        title.text = materials.name[id]
    }
    
    func updateArrow(direction: direction) {
        switch direction {
        case .up:
            arrowImage.image = UIImage(systemName: "arrow.up.square.fill")
            arrowImage.tintColor = Colors.arrowUpRed
        case .down:
            arrowImage.image = UIImage(systemName: "arrow.down.square.fill")
            arrowImage.tintColor = Colors.arrowDownGreen
        }
    }
    
}





extension WeeklyStatsCell {
    private
    func setSubviews(){
        self.addSubview(title)
        self.addSubview(arrowImage)
        self.addSubview(colorView)
        colorView.addSubview(percent)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // colorView height constrain in the bottom of the function.
            colorView.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -6),
            colorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: colorView.frame.width),
            
            percent.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -5),
            percent.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            
            arrowImage.bottomAnchor.constraint(equalTo: colorView.topAnchor, constant: -4),
            arrowImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: arrowImage.frame.width),
            arrowImage.heightAnchor.constraint(equalToConstant: arrowImage.frame.height)
        ])
        colorViewBottom = colorView.heightAnchor.constraint(equalToConstant: colorView.frame.height)
        colorViewBottom?.isActive = true
    }
}
