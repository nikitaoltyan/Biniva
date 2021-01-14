//
//  TopProgressView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 29.12.2020.
//

import UIKit

class TopProgressView: UIView {
    
    let backImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 25))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        return image
    }()
    
    let nextImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 25))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.tintColor = MainConstants.nearBlack
        return image
    }()
    
    let progressViewHorizontal: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.nearWhite
        return view
    }()
    
    let progressPassed: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        return view
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "1 из 2"
        label.font = UIFont.init(name: "SFPro", size: 11.0)
        return label
    }()
    
    var delegate: TopProgressDelegate?
    var slide: Int!
    var progressWidthConstraint: NSLayoutConstraint?
    var prevImageWidthConstraint: NSLayoutConstraint?
    var nextImageWidthConstraint: NSLayoutConstraint?
    var progressWidthConstant: CGFloat?
    
    let closeMark = "xmark"
    let backMark = "chevron.left"
    let nextMark = "chevron.right"
    let paperplaneMark = "paperplane"

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetSubview()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    func ChangeImage(){
        switch slide!{
        case 0:
            backImage.image = UIImage(systemName: closeMark)
            nextImage.image = UIImage(systemName: nextMark)
            nextImage.isHidden = false
            progressLabel.text = "1 из 2"
            prevImageWidthConstraint?.constant = 25
            nextImageWidthConstraint?.constant = 18
            self.layoutIfNeeded()
        default:
            backImage.image = UIImage(systemName: backMark)
            nextImage.isHidden = true
//            Add in other updates this button.
//            nextImage.image = UIImage(systemName: paperplaneMark)
            progressLabel.text = "2 из 2"
            prevImageWidthConstraint?.constant = 18
            nextImageWidthConstraint?.constant = 25
            self.layoutIfNeeded()
        }
    }

    @objc func PrevSlideOrClose(){
        switch slide!{
        case 0:
            delegate?.CloseView()
        default:
            AnimateMinus()
            slide -= 1
            delegate?.Scroll(slide: slide)
            ChangeImage()
        }
    }
    
    @objc func NextSlideOrSent(){
        switch slide!{
        case 1:
            Sent()
        default:
            AnimatePlus()
            slide += 1
            delegate?.Scroll(slide: slide)
            ChangeImage()
        }
    }
    
    @objc func Sent(){
        print("Sent function")
    }
    
    func AnimatePlus(){
        self.progressWidthConstraint?.constant += progressWidthConstant!
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
        }, completion: {finished in})
    }
    
    func AnimateMinus(){
        self.progressWidthConstraint?.constant -= progressWidthConstant!
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: {finished in})
    }
}





extension TopProgressView {
    
    func SetSubview(){
        self.addSubview(backImage)
        self.addSubview(progressViewHorizontal)
        self.addSubview(progressPassed)
        self.addSubview(nextImage)
        self.addSubview(progressLabel)
        
        backImage.image = UIImage(systemName: closeMark)
        nextImage.image = UIImage(systemName: nextMark)
        
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PrevSlideOrClose)))
        nextImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NextSlideOrSent)))
    }
    
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            backImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            backImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            backImage.heightAnchor.constraint(equalToConstant: backImage.frame.height),
            
            nextImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            nextImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            nextImage.heightAnchor.constraint(equalToConstant: nextImage.frame.height),
            
            progressViewHorizontal.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressViewHorizontal.centerYAnchor.constraint(equalTo: backImage.centerYAnchor, constant: 4),
            progressViewHorizontal.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth*2/3),
            progressViewHorizontal.heightAnchor.constraint(equalToConstant: 5),
            
            progressPassed.leftAnchor.constraint(equalTo: progressViewHorizontal.leftAnchor),
            progressPassed.centerYAnchor.constraint(equalTo: progressViewHorizontal.centerYAnchor),
            progressPassed.heightAnchor.constraint(equalTo: progressViewHorizontal.heightAnchor),
            
            progressLabel.centerXAnchor.constraint(equalTo: progressViewHorizontal.centerXAnchor),
            progressLabel.bottomAnchor.constraint(equalTo: progressViewHorizontal.topAnchor, constant: -3),
        ])
        
        prevImageWidthConstraint = backImage.widthAnchor.constraint(equalToConstant: backImage.frame.height)
        nextImageWidthConstraint = nextImage.widthAnchor.constraint(equalToConstant: nextImage.frame.width)
        progressWidthConstraint = progressPassed.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth*1/3)
        
        progressWidthConstraint?.isActive = true
        prevImageWidthConstraint?.isActive = true
        nextImageWidthConstraint?.isActive = true
        
        progressWidthConstant = progressWidthConstraint?.constant
    }
    
}
