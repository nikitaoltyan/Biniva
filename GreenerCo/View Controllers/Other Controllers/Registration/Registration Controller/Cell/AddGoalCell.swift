//
//  AddGoalCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import UIKit

class AddGoalCell: UICollectionViewCell {
    
    let back: UIButton = {
        let scale: CGFloat = 30
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = MainConstants.nearBlack
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Bold", size: 35)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressView: ProgressImageView = {
        let view = ProgressImageView()
        view.isUserInteractionEnabled = true
        view.progressView.isUserInteractionEnabled = true
        return view
    }()
    
    let numberView: SetResultView = {
        let scale: CGFloat = 65
        let view = SetResultView(frame: CGRect(x: 0, y: 0, width: scale, height: scale+10))
            .with(bgColor: MainConstants.nearWhite)
            .with(cornerRadius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cellNumber: Int?
    var delegate: RegistrationDelegate?
    var numberViewBottomConstraint: NSLayoutConstraint?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    @objc func ScrollBack() {
        delegate?.Scroll(slide: (cellNumber ?? 4) - 1)
    }
 
}






extension AddGoalCell: AddGoalDelegate {
    func PassFrame(height: CGFloat, minY: CGFloat) {
        if minY > 65 {
            numberViewBottomConstraint?.constant = -height
            numberView.backgroundColor = MainConstants.nearWhite
        } else {
            numberViewBottomConstraint?.constant = -height+65
            numberView.backgroundColor = MainConstants.pink
        }
        numberView.layoutIfNeeded()
        
        let setNumber: CGFloat = -2.6315 * minY + 1000
        let nearest = Int(round(setNumber/5)*5)
        numberView.number.text = String(nearest)
        
        if (Int(round(setNumber)) % 5 == 0) { Vibration.Soft() }
    }
}







extension AddGoalCell {
    
    func SetSubviews(){
        progressView.delegate = self
        
        self.addSubview(mainLabel)
        self.addSubview(progressView)
        self.addSubview(back)
        self.addSubview(numberView)
        
        back.addTarget(self, action: #selector(ScrollBack), for: .touchUpInside)
    }
    
    func ActivateLayouts(){
        let heightOfProgressView: CGFloat = {if MainConstants.screenHeight>700 { return 400 } else { return 360 }}()
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 95),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            mainLabel.widthAnchor.constraint(equalToConstant: 250),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            back.rightAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width),
            
            progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: 195),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-160),
            progressView.heightAnchor.constraint(equalToConstant: heightOfProgressView),
            
//             numberView bottom constraint on the bottom of the function.
            numberView.rightAnchor.constraint(equalTo: progressView.leftAnchor, constant: -5),
            numberView.heightAnchor.constraint(equalToConstant: numberView.frame.height),
            numberView.widthAnchor.constraint(equalToConstant: numberView.frame.width),
        ])
        numberViewBottomConstraint = numberView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -20)
        numberViewBottomConstraint?.isActive = true
    }
}




protocol AddGoalDelegate {
    func PassFrame(height: CGFloat, minY: CGFloat)
}
