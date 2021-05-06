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
        if let useImage = UIImage(named: "Recycling_bin") {
            let tintableImage = useImage.withRenderingMode(.alwaysTemplate)
            image.image = tintableImage
        }
        return image
    }()
    
    lazy var loggedLabel: UILabel = {
        let label = UILabel()
            .with(alignment: .center)
            .with(color: MaterialDefaults.GetTextColor(alreadyLogged: loggedData))
            .with(fontName: "SFPro", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dashedLine: UIView = {
        let view = UIView()
            .with(bgColor: MainConstants.orange)
        view.withDashedBorder(lineWidth: 2,
                              withColor: MainConstants.orange,
                              lineDashesPattern: [7,6],
                              Y: MaterialDefaults.YForDashedLine(dailyNorm: dailyNorm))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var loggedData: Int = 0
//    Daily norm after loggin not ready and app use 0
    let dailyNorm: Int = Defaults.GetUserDailyNorm(userId: Defaults.GetUserId())
    let heightOfProgressView: CGFloat = {if MainConstants.screenHeight>700{return 400}else{return 360}}()
    var progressHeightAnchor: NSLayoutConstraint?
    var delegate: AddGoalDelegate?
//    var recyclingDelegate: RecyclingDelegate?
    var database = DataFunction()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = MainConstants.nearWhite.withAlphaComponent(0.1)
        database.getTotalLogged(forDate: Date().onlyDate, result: { result in
            print("Already logged for that day: \(result)")
            self.loggedData = result
            self.loggedLabel.text = "\(result) гр"
        })
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
    func SetProgressHeight(addedSize add: Int) {
        let totalLogged = loggedData + add
        guard (totalLogged < 1500) else {
            SetProgressForFullData(logged: totalLogged)
            return
        }
        let setHeight: CGFloat = MaterialDefaults.LinearFunction(viewSize: self.frame.height, addedSize: add)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.progressHeightAnchor?.constant += setHeight
            self.loggedLabel.textColor = MaterialDefaults.GetTextColor(alreadyLogged: self.loggedData)
            self.layoutIfNeeded()
        }, completion: { finished in
            self.loggedLabel.text = "\(totalLogged) гр"
            self.CheckDailyNorm(currentLoged: totalLogged)
        })
    }
    
    
    func CheckDailyNorm(currentLoged size: Int){
        guard (size > dailyNorm) else { return }
//        recyclingDelegate?.ChangeNumberViewColor()
    }
    
    
    func SetProgressForFullData(logged: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.progressHeightAnchor?.constant = self.heightOfProgressView
            self.layoutIfNeeded()
        }, completion: { finished in
            self.loggedLabel.text = "\(logged) гр"
            self.CheckDailyNorm(currentLoged: logged)
        })
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
        self.addSubview(dashedLine)
        self.addSubview(image)
        self.addSubview(loggedLabel)
        
        progressView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(PanGesture(_:))))
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
//            progressView height anchor on the bootom of the function.
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            loggedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loggedLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -13),
        ])
        
        progressHeightAnchor =
            progressView.heightAnchor.constraint(equalToConstant: progressView.frame.height)
        progressHeightAnchor?.isActive = true
    }
}
