//
//  AddPaperView.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class AddItemView: UIView {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(color: MainConstants.white)
            .with(fontName: "SFPro-Medium", size: 12)
            .with(numberOfLines: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "200 гр"
        return label
    }()
    
    var isLabelHidden: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubview()
        if (isLabelHidden == false){
            ActivateConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}





extension AddItemView {

    func SetSubview(){
        self.addSubview(image)
        self.addSubview(label)
    }

    func ActivateConstraints(){
        var gap: CGFloat!
        if MainConstants.screenHeight > 700 {gap = 8} else {gap = 6}
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: gap/1.2),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: self.frame.height-3*gap),
            image.widthAnchor.constraint(equalToConstant: self.frame.width-3*gap),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -1),
            label.centerXAnchor.constraint(equalTo: image.centerXAnchor)
        ])
    }

}
