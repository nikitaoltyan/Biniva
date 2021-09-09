//
//  MaterialInfoCell.swift
//  Biniva
//
//  Created by Nick Oltyan on 07.09.2021.
//

import UIKit

class MaterialInfoCell: UITableViewCell {
    
    let function = MaterialFunctions()
    
    let circle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
            .with(autolayout: false)
            .with(cornerRadius: 55)
        return view
    }()
    
    let circleImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 85, height: 85))
            .with(autolayout: false)
        image.tintColor = Colors.background
        return image
    }()
    
    let materialImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 130))
            .with(autolayout: false)
        return image
    }()

    let title: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Semibold", size: 20)
            .with(autolayout: false)
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .left)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 17)
            .with(autolayout: false)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setCell(forMaterial material: Int) {
        circle.backgroundColor = function.colorByRowValue(material)
        let useImage = function.iconByRowValue(material)
        circleImage.image = useImage.withRenderingMode(.alwaysTemplate)
        materialImage.image = function.imageByRowValue(material)
        title.text = function.titleByRowValue(material)
        desc.text = function.descByRowValue(material)
    }
}







extension MaterialInfoCell {
    private
    func setSubviews(){
        self.addSubview(circle)
        circle.addSubview(circleImage)
        self.addSubview(materialImage)
        self.addSubview(title)
        self.addSubview(desc)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            circle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            circle.heightAnchor.constraint(equalToConstant: circle.frame.height),
            circle.widthAnchor.constraint(equalToConstant: circle.frame.width),
            
            circleImage.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            circleImage.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            circleImage.heightAnchor.constraint(equalToConstant: circleImage.frame.height),
            circleImage.widthAnchor.constraint(equalToConstant: circleImage.frame.width),
            
            title.topAnchor.constraint(equalTo: circle.topAnchor),
            title.leftAnchor.constraint(equalTo: circle.rightAnchor, constant: 45),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            desc.leftAnchor.constraint(equalTo: title.leftAnchor),
            desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
//            desc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            materialImage.topAnchor.constraint(equalTo: circle.topAnchor, constant: 38),
            materialImage.leftAnchor.constraint(equalTo: circle.leftAnchor, constant: 20),
            materialImage.heightAnchor.constraint(equalToConstant: materialImage.frame.height),
            materialImage.widthAnchor.constraint(equalToConstant: materialImage.frame.width),
        ])
    }
}
