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
        view.dashedLine.isHidden = true
        view.image.tintColor = MainConstants.white
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
    
    let explainLabel: UILabel = {
        let label = UILabel()
            .with(color: .gray)
            .with(fontName: "SFPro", size: 15)
            .with(alignment: .left)
            .with(numberOfLines: 0)
        label.text = "Потяни за оранжевое"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: ButtonView = {
        let view = ButtonView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-90, height: 53))
            .with(borderWidth: 1.2, color: UIColor.lightGray.cgColor)
            .with(bgColor: .clear)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.label.text = "ПРОДОЛЖИТЬ"
        view.label.font = UIFont(name: "SFPro-Medium", size: 16)
        view.label.textColor = .lightGray
        view.isActive = false
        return view
    }()
    
    var cellNumber: Int?
    var delegate: RegistrationDelegate?
    var numberViewBottomConstraint: NSLayoutConstraint?
    var passDict: Dictionary<String, Int> = [:]
    
    
    
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
        delegate?.Scroll(slide: (cellNumber ?? 5) - 1)
    }
    
    
    @objc func NextSlide(){
        guard (nextButton.isActive) else { return }
        delegate?.PassDailyNorm(norm: passDict)
        delegate?.FinishRegistration()
    }
    
    
    func ActivateButton(){
        guard (nextButton.isActive) else { return }
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.backgroundColor = MainConstants.orange
            self.nextButton.layer.borderWidth = 0
            self.nextButton.label.textColor = MainConstants.white
            self.nextButton.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in })
    }
 
}






extension AddGoalCell: AddGoalDelegate {
    func PassFrame(height: CGFloat, minY: CGFloat) {
        explainLabel.isHidden = true
        nextButton.isActive = true
        ActivateButton()
        if minY > 80 {
            numberViewBottomConstraint?.constant = -height
            numberView.backgroundColor = MainConstants.nearWhite
        } else {
            numberViewBottomConstraint?.constant = -height+65
            numberView.backgroundColor = MainConstants.pink
        }
        numberView.layoutIfNeeded()
        
        let setNumber: CGFloat = -3.9473 * minY + 1500
        let nearest = Int(round(setNumber/5)*5)
        numberView.number.text = String(nearest)
        
        passDict = ["daily_norm": nearest]
        if CGFloat(nearest)-0.5...CGFloat(nearest)+0.5 ~= setNumber { Vibration.soft() }
    }
}







extension AddGoalCell {
    
    func SetSubviews(){
        progressView.delegate = self
        
        self.addSubview(mainLabel)
        self.addSubview(progressView)
        self.addSubview(back)
        self.addSubview(numberView)
        self.addSubview(nextButton)
        self.addSubview(explainLabel)
        
        back.addTarget(self, action: #selector(ScrollBack), for: .touchUpInside)
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlide)))
    }
    
    func ActivateLayouts(){
        let mainLabelTop: CGFloat = {
            if MainConstants.screenHeight == 736 { return 55 }
            else if MainConstants.screenHeight > 700 { return 95 }
            else { return 80 }}()
        let progressTop: CGFloat = {
            if MainConstants.screenHeight == 736 { return 142 }
            else { return 195 }}()
        let heightOfProgressView: CGFloat = {
            if MainConstants.screenHeight > 700 { return 400 }
            else { return 360 }}()
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: mainLabelTop),
            mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35),
            mainLabel.widthAnchor.constraint(equalToConstant: 250),
            
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            back.rightAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: back.frame.width/2),
            back.heightAnchor.constraint(equalToConstant: back.frame.height),
            back.widthAnchor.constraint(equalToConstant: back.frame.width),
            
            progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: progressTop),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth-160),
            progressView.heightAnchor.constraint(equalToConstant: heightOfProgressView),
            
//             numberView bottom constraint on the bottom of the function.
            numberView.rightAnchor.constraint(equalTo: progressView.leftAnchor, constant: -5),
            numberView.heightAnchor.constraint(equalToConstant: numberView.frame.height),
            numberView.widthAnchor.constraint(equalToConstant: numberView.frame.width),
            
            nextButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: nextButton.frame.height),
            nextButton.widthAnchor.constraint(equalToConstant: nextButton.frame.width),
            
            explainLabel.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -3),
            explainLabel.leftAnchor.constraint(equalTo: progressView.rightAnchor, constant: -15),
            explainLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1)
        ])
        
        numberViewBottomConstraint = numberView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -20)
        numberViewBottomConstraint?.isActive = true
    }
}




protocol AddGoalDelegate {
    func PassFrame(height: CGFloat, minY: CGFloat)
}
