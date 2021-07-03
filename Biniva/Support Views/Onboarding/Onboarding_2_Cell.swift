//
//  Onboarding_2_Cell.swift
//  Biniva
//
//  Created by Никита Олтян on 03.07.2021.
//

import UIKit

class Onboarding_2_Cell: UICollectionViewCell {
    
    let functions = MaterialFunctions()
    
    let mapImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth - 60,
                                              height: MainConstants.screenHeight/2 - 40))
            .with(autolayout: false)
            .with(borderWidth: 1, color: Colors.topGradient.cgColor)
            .with(cornerRadius: 13)
        image.clipsToBounds = true
        image.image = UIImage(named: "onboarding_2")
        image.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.8
        image.layer.shadowOffset = CGSize(width: 0, height: 2)
        return image
    }()
    
    lazy var point_1: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            .with(autolayout: false)
            .with(cornerRadius: 18)
        image.image = drawRatio(forTypes: [.plastic, .organic, .paper])
        image.isHidden = true
        return image
    }()
    
    lazy var point_2: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            .with(autolayout: false)
            .with(cornerRadius: 18)
        image.image = drawRatio(forTypes: [.glass, .battery, .wood, .fabric])
        image.isHidden = true
        return image
    }()
    
    lazy var point_3: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            .with(autolayout: false)
            .with(cornerRadius: 18)
        image.image = drawRatio(forTypes: [.plastic, .glass, .paper, .metal, .organic, .wood])
        image.isHidden = true
        return image
    }()
    
    lazy var point_4: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            .with(autolayout: false)
            .with(cornerRadius: 18)
        image.image = drawRatio(forTypes: [.battery])
        image.isHidden = true
        return image
    }()
    
    let titleBlack: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Bold", size: 28)
        label.text = "Находи пункты переработки с помощью"
        return label
    }()
    
    let titleGreen: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.topGradient)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 32)
        label.text = "Biniva"
        return label
    }()
    
    let subtitleGray: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "SFPro", size: 16)
        label.text = "Карта, составленная самими пользователями!"
        return label
    }()
    
    let button: ButtonView = {
        let view = ButtonView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.label.text = "Продолжить"
        return view
    }()
    
    var delegate: OnbordingDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func animate() {
        let points: [UIImageView] = [point_1, point_2, point_3, point_4]
        for point in points {
            animatePoint(point)
        }
    }
    
    private
    func animatePoint(_ point: UIImageView) {
        point.isHidden = false
        point.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 1, animations: {
            point.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (_) in
            UIView.animate(withDuration: 1, animations: {
                point.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    private
    func drawRatio(forTypes types: [TrashType]) -> UIImage {
        let size: CGFloat = 36
        let delta: CGFloat = 10
        let rect = CGRect(x: delta/2, y: delta/2, width: size-delta, height: size-delta)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        
        return renderer.image { (_) in
            // Fill full circle with wholeColor
            let initColor: UIColor = functions.colorByRowValue(types[0].rawValue)
            initColor.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()

            // Fill pie with fractionColor
            for (item, type) in types.enumerated() {
                let fractionColor: UIColor = functions.colorByRowValue(type.rawValue)
                fractionColor.setFill()
                
                let piePath = UIBezierPath()
                piePath.addArc(withCenter: CGPoint(x: size/2, y: size/2), radius: size/2,
                               startAngle: (CGFloat.pi * 2.0 * CGFloat(item)) / CGFloat(types.count),
                               endAngle: (CGFloat.pi * 2.0 * CGFloat(item+1)) / CGFloat(types.count),
                               clockwise: true)
                
                piePath.addLine(to: CGPoint(x: size/2, y: size/2))
                piePath.close()
                piePath.fill()
            }

            let useImage = UIImage(systemName: "trash")?.withTintColor(Colors.background)
            useImage?.draw(in: rect)
        }
    }
    
    
    @objc
    func buttonTap() {
        button.tap(completion: { (_) in
            self.delegate?.next(slide: 2)
        })
    }
}




extension Onboarding_2_Cell {
    func setSubviews() {
        self.addSubview(mapImage)
        mapImage.addSubview(point_1)
        mapImage.addSubview(point_2)
        mapImage.addSubview(point_3)
        mapImage.addSubview(point_4)
        self.addSubview(titleBlack)
        self.addSubview(titleGreen)
        self.addSubview(subtitleGray)
        self.addSubview(button)
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    func activateLayouts() {
        NSLayoutConstraint.activate([
            mapImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 75),
            mapImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mapImage.widthAnchor.constraint(equalToConstant: mapImage.frame.width),
            mapImage.heightAnchor.constraint(equalToConstant: mapImage.frame.height),
            
            point_1.centerXAnchor.constraint(equalTo: mapImage.centerXAnchor),
            point_1.centerYAnchor.constraint(equalTo: mapImage.centerYAnchor),
            point_1.widthAnchor.constraint(equalToConstant: point_1.frame.width),
            point_1.heightAnchor.constraint(equalToConstant: point_1.frame.height),
            
            point_2.topAnchor.constraint(equalTo: mapImage.topAnchor, constant: 60),
            point_2.leftAnchor.constraint(equalTo: mapImage.leftAnchor, constant: 20),
            point_2.widthAnchor.constraint(equalToConstant: point_2.frame.width),
            point_2.heightAnchor.constraint(equalToConstant: point_2.frame.height),
            
            point_3.bottomAnchor.constraint(equalTo: mapImage.bottomAnchor, constant: -90),
            point_3.leftAnchor.constraint(equalTo: mapImage.leftAnchor, constant: 100),
            point_3.widthAnchor.constraint(equalToConstant: point_3.frame.width),
            point_3.heightAnchor.constraint(equalToConstant: point_3.frame.height),
            
            point_4.bottomAnchor.constraint(equalTo: mapImage.bottomAnchor, constant: -50),
            point_4.rightAnchor.constraint(equalTo: mapImage.rightAnchor, constant: -40),
            point_4.widthAnchor.constraint(equalToConstant: point_4.frame.width),
            point_4.heightAnchor.constraint(equalToConstant: point_4.frame.height),
            
            titleBlack.topAnchor.constraint(equalTo: mapImage.bottomAnchor, constant: 60),
            titleBlack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22),
            titleBlack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22),
            
            titleGreen.topAnchor.constraint(equalTo: titleBlack.bottomAnchor, constant: 10),
            titleGreen.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 5),
            
            subtitleGray.topAnchor.constraint(equalTo: titleGreen.bottomAnchor, constant: 25),
            subtitleGray.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45),
            subtitleGray.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -58),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: button.frame.width),
            button.heightAnchor.constraint(equalToConstant: button.frame.height),
        ])
    }
}