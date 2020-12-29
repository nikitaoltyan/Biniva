//
//  ProfileController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 03.11.2020.
//

import UIKit

class ProfileController: UIViewController {

    var profImage: UIImageView!
    let back: UIButton = {
        let button = UIButton()
        button.tintColor = MainConstants.white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var userName: UILabel!
    var cityLabel: UILabel!
    var firstLine: UIView!
    var secondLine: UIView!
    var thirdLine: UIView!
    var fourthLine: UIView!
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    let buttonsSize = 19 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 38/255, green: 74/255, blue: 54/255, alpha: 1)
        PerformAllSubviews()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DismissAction(_:))))
    }
    
    @objc func BackAction(sender: UIButton!) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    
    @objc func OpenUserSettings(){
        print("Open user's settings")
    }

    @objc func OpenMeetings(){
        print("Open meetings")
    }
    
    @objc func OpenContact(){
        print("Open contact section")
        let newVC: ContactUsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "ContactUsController") as! ContactUsController
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
    
    @objc func OpenCustomization(){
        print("Open customization")
        let newVC: ChangeButtonsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "ChangeButtonsController") as! ChangeButtonsController
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
    
    @objc func OpenAboutUs(){
        print("Open About us")
        let newVC: AboutUsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "AboutUsController") as! AboutUsController
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
    
    @objc func DismissAction(_ sender: UIPanGestureRecognizer){
        print("Dismiss action")
        let touchPoint = sender.location(in: self.view.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.x - initialTouchPoint.x > 0 {
                self.view.frame = CGRect(x: touchPoint.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled{
            if touchPoint.x - initialTouchPoint.x > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }, completion: { finished in
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func PerformAllSubviews(){
        ProfileImage()
        BackButton()
        UserName()
        CityLabel()
        UserSettingsButton()
        MeetingHistory()
        ContactUs()
        SetUpCustomButton()
        AboutUsButton()
    }
    
    func ProfileImage(){
        let scale = MainConstants.screenWidth/2.2
        let profileImage: UIImageView = {
            let image = UIImageView()
            image.layer.masksToBounds = true
            image.layer.cornerRadius = scale/2
            image.image = #imageLiteral(resourceName: "justin-kauffman-7_tRMnxWsUg-unsplash")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        view.addSubview(profileImage)
        profImage = profileImage
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                profImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                profImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profImage.heightAnchor.constraint(equalToConstant: scale),
                profImage.widthAnchor.constraint(equalToConstant: scale)
            ])
        } else {
            const.append(contentsOf: [
                profImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                profImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profImage.heightAnchor.constraint(equalToConstant: scale),
                profImage.widthAnchor.constraint(equalToConstant: scale)
            ])
        }
        NSLayoutConstraint.activate(const)
    }
    
    func BackButton(){
        view.addSubview(back)
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            back.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            back.heightAnchor.constraint(equalToConstant: 30),
            back.widthAnchor.constraint(equalToConstant: 30)
        ])
        back.addTarget(self, action: #selector(BackAction), for: .touchUpInside)
    }
    
    func UserName(){
        let name = UILabel()
        view.addSubview(name)
        userName = name
        userName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profImage.bottomAnchor, constant: 25),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        userName.text = "Мария Вичентиевич"
        userName.font = UIFont(name: "Palatino", size: 26)
        userName.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func CityLabel(){
        let city = UILabel()
        view.addSubview(city)
        cityLabel = city
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        cityLabel.text = "Москва"
        cityLabel.font = UIFont(name: "Palatino", size: 18)
        cityLabel.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func UserSettingsButton(){
        let profileImage = UIImageView()
        let useImage = UIImage(systemName: "person.circle")
        view.addSubview(profileImage)
        let scale = 25 as CGFloat
        profileImage.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 45),
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            profileImage.heightAnchor.constraint(equalToConstant: scale),
            profileImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        profileImage.image = useImage
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenUserSettings)))
        
        let profSetButton = UILabel()
        view.addSubview(profSetButton)
        profSetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profSetButton.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 2),
            profSetButton.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15),
            profSetButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            profSetButton.heightAnchor.constraint(equalToConstant: scale)
        ])
        profSetButton.text = "Настройки пользователя"
        profSetButton.font = UIFont(name: "SFPro", size: buttonsSize)
        profSetButton.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        profSetButton.isUserInteractionEnabled = true
        profSetButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenUserSettings)))
        
        let line = UIView()
        view.addSubview(line)
        firstLine = line
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLine.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            firstLine.leftAnchor.constraint(equalTo: profileImage.leftAnchor),
            firstLine.rightAnchor.constraint(equalTo: profSetButton.rightAnchor),
            firstLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        firstLine.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func MeetingHistory(){
        let meetingImage = UIImageView()
        let useImage = UIImage(systemName: "person.3.fill")
        view.addSubview(meetingImage)
        let scale = 25 as CGFloat
        meetingImage.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        meetingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            meetingImage.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 8),
            meetingImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            meetingImage.heightAnchor.constraint(equalToConstant: scale),
            meetingImage.widthAnchor.constraint(equalToConstant: scale+5)
        ])
        meetingImage.image = useImage
        meetingImage.isUserInteractionEnabled = true
        meetingImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenMeetings)))
        
        let setButton = UILabel()
        view.addSubview(setButton)
        setButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setButton.topAnchor.constraint(equalTo: meetingImage.topAnchor, constant: 2),
            setButton.leftAnchor.constraint(equalTo: meetingImage.rightAnchor, constant: 10),
            setButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            setButton.heightAnchor.constraint(equalToConstant: scale)
        ])
        setButton.text = "История встреч"
        setButton.font = UIFont(name: "SFPro", size: buttonsSize)
        setButton.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        setButton.isUserInteractionEnabled = true
        setButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenMeetings)))
        
        let line = UIView()
        view.addSubview(line)
        secondLine = line
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLine.topAnchor.constraint(equalTo: meetingImage.bottomAnchor, constant: 8),
            secondLine.leftAnchor.constraint(equalTo: meetingImage.leftAnchor),
            secondLine.rightAnchor.constraint(equalTo: setButton.rightAnchor),
            secondLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        secondLine.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func ContactUs(){
        let contactImage = UIImageView()
        let useImage = UIImage(systemName: "paperplane.fill")
        view.addSubview(contactImage)
        let scale = 25 as CGFloat
        contactImage.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        contactImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImage.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 8),
            contactImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            contactImage.heightAnchor.constraint(equalToConstant: scale),
            contactImage.widthAnchor.constraint(equalToConstant: scale)
        ])
        contactImage.image = useImage
        contactImage.isUserInteractionEnabled = true
        contactImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenContact)))
        
        let setButton = UILabel()
        view.addSubview(setButton)
        setButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setButton.topAnchor.constraint(equalTo: contactImage.topAnchor, constant: 2),
            setButton.leftAnchor.constraint(equalTo: contactImage.rightAnchor, constant: 15),
            setButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            setButton.heightAnchor.constraint(equalToConstant: scale)
        ])
        setButton.text = "Свяжиться с разработчиками"
        setButton.font = UIFont(name: "SFPro", size: buttonsSize)
        setButton.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        setButton.isUserInteractionEnabled = true
        setButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenContact)))
        
        let line = UIView()
        view.addSubview(line)
        thirdLine = line
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdLine.topAnchor.constraint(equalTo: contactImage.bottomAnchor, constant: 8),
            thirdLine.leftAnchor.constraint(equalTo: contactImage.leftAnchor),
            thirdLine.rightAnchor.constraint(equalTo: setButton.rightAnchor),
            thirdLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        thirdLine.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func SetUpCustomButton(){
        let custom = UIImageView()
        let useImage = UIImage(systemName: "drop.fill")
        view.addSubview(custom)
        let scale = 25 as CGFloat
        custom.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        custom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            custom.topAnchor.constraint(equalTo: thirdLine.bottomAnchor, constant: 8),
            custom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            custom.heightAnchor.constraint(equalToConstant: scale),
            custom.widthAnchor.constraint(equalToConstant: scale)
        ])
        custom.image = useImage
        custom.isUserInteractionEnabled = true
        custom.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenCustomization)))
        
        let setButton = UILabel()
        view.addSubview(setButton)
        setButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setButton.topAnchor.constraint(equalTo: custom.topAnchor, constant: 2),
            setButton.leftAnchor.constraint(equalTo: custom.rightAnchor, constant: 15),
            setButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            setButton.heightAnchor.constraint(equalToConstant: scale)
        ])
        setButton.text = "Изменить быстрые кнопки"
        setButton.font = UIFont(name: "SFPro", size: buttonsSize)
        setButton.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        setButton.isUserInteractionEnabled = true
        setButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenCustomization)))
        
        let line = UIView()
        view.addSubview(line)
        fourthLine = line
        fourthLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthLine.topAnchor.constraint(equalTo: custom.bottomAnchor, constant: 8),
            fourthLine.leftAnchor.constraint(equalTo: custom.leftAnchor),
            fourthLine.rightAnchor.constraint(equalTo: setButton.rightAnchor),
            fourthLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        fourthLine.backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
    }
    
    func AboutUsButton(){
        let custom = UIImageView()
        let useImage = UIImage(systemName: "questionmark.circle")
        view.addSubview(custom)
        let scale = 25 as CGFloat
        custom.tintColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        custom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            custom.topAnchor.constraint(equalTo: fourthLine.bottomAnchor, constant: 8),
            custom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26),
            custom.heightAnchor.constraint(equalToConstant: scale),
            custom.widthAnchor.constraint(equalToConstant: scale)
        ])
        custom.image = useImage
        custom.isUserInteractionEnabled = true
        custom.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenAboutUs)))
        
        let setButton = UILabel()
        view.addSubview(setButton)
        setButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setButton.topAnchor.constraint(equalTo: custom.topAnchor, constant: 2),
            setButton.leftAnchor.constraint(equalTo: custom.rightAnchor, constant: 15),
            setButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            setButton.heightAnchor.constraint(equalToConstant: scale)
        ])
        setButton.text = "О Greener"
        setButton.font = UIFont(name: "SFPro", size: buttonsSize)
        setButton.textColor = UIColor(red: 245/255, green: 252/255, blue: 251/255, alpha: 1)
        setButton.isUserInteractionEnabled = true
        setButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OpenAboutUs)))
    }
    
}
