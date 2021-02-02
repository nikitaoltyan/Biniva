//
//  ProgressImageView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 03.01.2021.
//

import UIKit

class ProgressImageView: UIView {
    
    let progressView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.orange
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "Recycling_bin")
        return image
    }()
    
    var progressHeightAnchor: NSLayoutConstraint?
    var delegate: AddGoalDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = MainConstants.nearWhite.withAlphaComponent(0.1)
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func SetProgressHeight(addedSize add: Int) {
        let setHeight: CGFloat = 0.253 * CGFloat(add)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.progressHeightAnchor?.constant += setHeight
            self.layoutIfNeeded()
        }, completion: { finished in })
    }
    
    
    @objc func PanGesture(_ sender: UIPanGestureRecognizer){
        let touchPoint = sender.location(in: self)
        guard (touchPoint.y > image.frame.minY) else { return }
        guard (touchPoint.y < (progressView.frame.maxY-20)) else { return }
        if sender.state == UIGestureRecognizer.State.changed  {
            progressHeightAnchor?.constant = progressView.frame.maxY - touchPoint.y
            progressView.layoutIfNeeded()
            delegate?.PassFrame(height: progressView.frame.height, minY: progressView.frame.minY)
        }
    }
}





extension ProgressImageView{
    func SetSubviews(){
        self.addSubview(progressView)
        self.addSubview(image)
        
        
        progressView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGesture(_:))))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
//            progressView height anchor on the bootom os the function.
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        progressHeightAnchor =
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height)
        progressHeightAnchor?.isActive = true
    }
}
