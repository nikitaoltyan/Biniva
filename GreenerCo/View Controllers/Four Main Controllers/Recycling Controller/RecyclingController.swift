//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class RecyclingController: UIViewController {
    
    let topView: RegularTopView = {
        let view = RegularTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pageLabel.text = "Переработка"
        view.pageName = "recycling"
        return view
    }()

    let plusView: CompletePlusView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 58}}()
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        view.layer.cornerRadius = width/3
        view.horizontalView.backgroundColor = MainConstants.white
        view.verticalView.backgroundColor = MainConstants.white
        return view
    }()
    
    let addFirstItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 58}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    let addSecondItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 58}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    let addThirdItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 58}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    let openCustomView: CustomPickerOpenView = {
        let scale: CGFloat = 35
        let view = CustomPickerOpenView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        return view
    }()
    
    let progressView: ProgressImageView = {
        let view = ProgressImageView()
        return view
    }()
    
    let customAddView: CustomAddView = {
        let viewHeight: CGFloat = {if MainConstants.screenHeight > 700 {return MainConstants.screenHeight/1.9-80} else {return MainConstants.screenHeight/1.9}}()
        let view = CustomAddView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: viewHeight))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    var materials = [MaterialsObject]()
    
    var isAddMenuActivated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        PopulateMaterialsObject()
        SetSubviews()
        ActivateLayouts()
    }
    
    @objc func OpenProfile(){
        print("Open profile function")
        let newVC = AchieveController()
        newVC.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newVC, animated: false, completion: nil)
    }
    
    @objc func ActivateThreeMainViews(){
        let movement = plusView.frame.width * 1.72
        if (isAddMenuActivated){
            UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
                self.addFirstItemView.center.x += movement
                self.addSecondItemView.center.x -= movement
                self.addThirdItemView.center.y += movement
                self.plusView.horizontalView.transform = CGAffineTransform.identity
                self.plusView.verticalView.transform = CGAffineTransform.identity
                self.progressView.backgroundColor = self.progressView.backgroundColor?.withAlphaComponent(0.1)
                self.progressView.progressView.backgroundColor = self.progressView.progressView.backgroundColor?.withAlphaComponent(1)
            }, completion: { finished in
                self.addFirstItemView.isHidden = true
                self.addSecondItemView.isHidden = true
                self.addThirdItemView.isHidden = true
                self.openCustomView.isHidden = false
                self.isAddMenuActivated = false
                print("Animation completed")
            })
        } else {
            let center = plusView.center
            addFirstItemView.center = center
            addSecondItemView.center = center
            addThirdItemView.center = center
            addFirstItemView.isHidden = false
            addSecondItemView.isHidden = false
            addThirdItemView.isHidden = false
            openCustomView.isHidden = true
            UIView.animate(withDuration: 0.29, delay: 0, options: .curveEaseOut, animations: {
                self.addFirstItemView.center.x -= movement
                self.addSecondItemView.center.x += movement
                self.addThirdItemView.center.y -= movement
                self.plusView.horizontalView.transform = CGAffineTransform(rotationAngle: .pi/4)
                self.plusView.verticalView.transform = CGAffineTransform(rotationAngle: .pi/4)
                self.progressView.backgroundColor = self.progressView.backgroundColor?.withAlphaComponent(0.05)
                self.progressView.progressView.backgroundColor = self.progressView.progressView.backgroundColor?.withAlphaComponent(0.2)
            }, completion: { finished in
                self.isAddMenuActivated = true
                print("Animation completed")
            })
        }
    }
    

    @objc func AddFirstItem(){
        print("Add first item")
    }
    
    @objc func AddSecondItem(){
        print("Add second item")
    }
    
    @objc func AddThirdItem(){
        print("Add third item")
    }
    
    @objc func ActivateCustomView(){
        let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.size.height ?? 49
        customAddView.center.y = MainConstants.screenHeight + customAddView.frame.height/2 - tabBarHeight
        customAddView.isHidden = false
        plusView.isHidden = true
        openCustomView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.customAddView.center.y -= self.customAddView.frame.height
            self.progressView.backgroundColor = self.progressView.backgroundColor?.withAlphaComponent(0.05)
            self.progressView.progressView.backgroundColor = self.progressView.progressView.backgroundColor?.withAlphaComponent(0.2)
        }, completion: { finished in
            print("Animation completed")
        })
    }
    
    @objc func dismissView(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .down:
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                    self.customAddView.center.y += self.customAddView.frame.height
                    self.progressView.backgroundColor = self.progressView.backgroundColor?.withAlphaComponent(0.1)
                    self.progressView.progressView.backgroundColor = self.progressView.progressView.backgroundColor?.withAlphaComponent(1)
                }, completion: { finished in
                    self.plusView.isHidden = false
                    self.openCustomView.isHidden = false
                    self.customAddView.isHidden = true
                })
            default:
                return
            }
        }
    }
    
    func PopulateMaterialsObject(){
        print("Materials populating")
        for count in 0...MaterialsObjectItems.color.count-1 {
            let toList = MaterialsObject()
            toList.color = MaterialsObjectItems.color[count]
            toList.image = MaterialsObjectItems.image[count]
            toList.name = MaterialsObjectItems.name[count]
            materials.append(toList)
            print(materials.count)
        }
        customAddView.PopulateMaterials(materialsObjectToPass: materials as NSObject)
    }

}





extension RecyclingController: RecyclingDelegate {
    func OpenTipsList() {
        print("Open tips list")
    }
}
