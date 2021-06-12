//
//  ThreeImagesView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 15.01.2021.
//

import UIKit

class WhoJoinedView: UIView {
    
    let scale: CGFloat = 25
    
    lazy var imageOne: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    lazy var imageTwo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    lazy var imageThree: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.borderColor = MainConstants.white.cgColor
        image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = scale/2
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(fontName: "SFPro-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leftLabelConstraint: NSLayoutConstraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    func ShowJoinedUsers(withMid mid: String){
//        Server.GetMeetingJoinedArray(withMeetingId: mid, result: { result in
//            switch result?.count {
//            case 0:
//                self.imageOne.isHidden = true
//                self.imageTwo.isHidden = true
//                self.imageThree.isHidden = true
//                self.label.isHidden = true
//            case 1:
//                self.imageTwo.isHidden = true
//                self.imageThree.isHidden = true
//                self.leftLabelConstraint?.constant = 30
//            case 2:
//                self.imageThree.isHidden = true
//                self.label.text = "2 участника"
//                self.leftLabelConstraint?.constant = 48
//            default:
//                self.label.text = "3+ участника"
//                self.leftLabelConstraint?.constant = 65
//            }
//            self.GetImagesAndNames(uidArray: result)
//        })
    }
    
    
    func GetImagesAndNames(uidArray: Array<String>?){
//        guard (uidArray?.count != 0) else { return }
//        var useArr = uidArray
//        switch uidArray?.count {
//        case 1:
//            let res = useArr?.randomElements(numberOfElements: 1)
//            Server.ReturnUserData(userId: res![0], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageOne.downloadImage(from: details["image"] as? String)
//                    self.label.text = "\(details["username"] as! String) присоединился"
//                }
//            })
//        case 2:
//            let res = useArr?.randomElements(numberOfElements: 2)
//            Server.ReturnUserData(userId: res![0], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageOne.downloadImage(from: details["image"] as? String)
//                }
//            })
//            Server.ReturnUserData(userId: res![1], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageTwo.downloadImage(from: details["image"] as? String)
//                    self.label.text = "\(details["username"] as! String) +1 присоединились"
//                }
//            })
//        default:
//            let res = useArr?.randomElements(numberOfElements: 3)
//            Server.ReturnUserData(userId: res![0], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageOne.downloadImage(from: details["image"] as? String)
//                }
//            })
//            Server.ReturnUserData(userId: res![1], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageTwo.downloadImage(from: details["image"] as? String)
//                }
//            })
//            Server.ReturnUserData(userId: res![2], userDetails: { details in
//                DispatchQueue.main.async {
//                    self.imageThree.downloadImage(from: details["image"] as? String)
//                    self.label.text = "\(details["username"] as! String) +\(uidArray!.count-1) присоединились"
//                }
//            })
//        }
    }
}







extension WhoJoinedView {
    
    func SetSubviews(){
        self.addSubview(imageOne)
        self.addSubview(imageTwo)
        self.addSubview(imageThree)
        self.addSubview(label)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            imageOne.topAnchor.constraint(equalTo: self.topAnchor),
            imageOne.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageOne.heightAnchor.constraint(equalToConstant: imageOne.frame.height),
            imageOne.widthAnchor.constraint(equalToConstant: imageOne.frame.width),
            
            imageTwo.topAnchor.constraint(equalTo: imageOne.topAnchor),
            imageTwo.leftAnchor.constraint(equalTo: imageOne.centerXAnchor, constant: 5),
            imageTwo.heightAnchor.constraint(equalToConstant: imageTwo.frame.height),
            imageTwo.widthAnchor.constraint(equalToConstant: imageTwo.frame.width),
            
            imageThree.topAnchor.constraint(equalTo: imageOne.topAnchor),
            imageThree.leftAnchor.constraint(equalTo: imageTwo.centerXAnchor, constant: 5),
            imageThree.heightAnchor.constraint(equalToConstant: imageThree.frame.height),
            imageThree.widthAnchor.constraint(equalToConstant: imageThree.frame.width),
            
            label.centerYAnchor.constraint(equalTo: imageOne.centerYAnchor)
        ])
        leftLabelConstraint = label.leftAnchor.constraint(equalTo: imageOne.leftAnchor, constant: 65)
        leftLabelConstraint?.isActive = true
    }
}

