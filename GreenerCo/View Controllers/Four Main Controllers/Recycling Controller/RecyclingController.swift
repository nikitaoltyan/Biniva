//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class RecyclingController: UIViewController {
    
    lazy var topView: RegularTopView = {
        let view = RegularTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.recyclingDelegate = self
        view.imageButton.isHidden = false
        view.pageLabel.text = "Переработка"
        view.pageName = "recycling"
        return view
    }()

    let plusView: CompletePlusView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 65}}()
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(bgColor: MainConstants.green)
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.horizontalView.backgroundColor = MainConstants.white
        view.verticalView.backgroundColor = MainConstants.white
        return view
    }()
    
    let addFirstItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 65}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addSecondItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 65}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addThirdItemView: AddItemView = {
        let width: CGFloat = {if MainConstants.screenHeight > 700 {return 70} else {return 65}}()
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let openCustomView: CustomPickerOpenView = {
        let scale: CGFloat = 35
        let view = CustomPickerOpenView(frame: CGRect(x: 0, y: 0, width: scale, height: scale))
        return view
    }()
    
    lazy var progressView: ProgressImageView = {
        let view = ProgressImageView()
        view.image.tintColor = MainConstants.white
        view.progressView.frame = CGRect(x: 0, y: 0, width: 0, height: 200)
        view.loggedLabel.text = "\(UserDefaults.standard.integer(forKey: "loggedData")) гр"
        view.recyclingDelegate = self
        view.layoutIfNeeded()
        return view
    }()
    
    let numberView: SetResultView = {
        let scale: CGFloat = 65
        let view = SetResultView(frame: CGRect(x: 0, y: 0, width: scale, height: scale+10))
            .with(bgColor: MainConstants.nearWhite)
            .with(cornerRadius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isForRecyclingController = true
        view.SetForRecyclingController()
        return view
    }()
    
    lazy var customAddView: CustomAddView = {
        let viewHeight: CGFloat = {
            if MainConstants.screenHeight == 736 { return MainConstants.screenHeight/1.9 }
            else if MainConstants.screenHeight > 700 { return MainConstants.screenHeight/1.9-40 }
            else { return MainConstants.screenHeight/1.9+40 }}()
        let view = CustomAddView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: viewHeight))
            .with(cornerRadius: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.delegate = self
        return view
    }()
    
    let dimView: UIView = {
        let view = UIView()
            .with(bgColor: UIColor.black.withAlphaComponent(0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var materials = [MaterialsObject]()
    var isAddMenuActivated: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Переработка"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        view.backgroundColor = MainConstants.white
        PopulateMaterialsObject()
        SetSubviews()
        ActivateLayouts()
        GetUserProgress()
    }
    
    
//    func setupNav
    
    
    
    @objc func OpenProfile(){
        print("Open profile function")
    }
    
    
    @objc func ShowPopUpController() {
        sleep(1)
        let newVC = PopUpController()
        newVC.modalPresentationStyle = .overFullScreen
        self.present(newVC, animated: false, completion: nil)
    }
    
    
    @objc func ActivateThreeMainViews(){
        Vibration.Light()
        let movement = plusView.frame.width * 1.72
        if (isAddMenuActivated){
            AnimateDismissThreeViews()
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
        let addedSize: Int = 200
        ServerMaterials.AddLoggedEvent(addedSize: addedSize,
                                       forUserID: UserDefaults.standard.string(forKey: "uid")!,
                                       material: "Пластик")
        AnimateDismissThreeViews()
        SetProgressHeight(addedSize: addedSize)
    }
    
    
    @objc func AddSecondItem(){
        print("Add second item")
        let addedSize: Int = 200
        ServerMaterials.AddLoggedEvent(addedSize: addedSize,
                                       forUserID: UserDefaults.standard.string(forKey: "uid")!,
                                       material: "Органика")
        AnimateDismissThreeViews()
        SetProgressHeight(addedSize: addedSize)
    }
    
    
    @objc func AddThirdItem(){
        print("Add third item")
        let addedSize: Int = 200
        ServerMaterials.AddLoggedEvent(addedSize: addedSize,
                                       forUserID: UserDefaults.standard.string(forKey: "uid")!,
                                       material: "Бумага")
        AnimateDismissThreeViews()
        SetProgressHeight(addedSize: addedSize)
    }
    
    
    @objc func ActivateCustomView(){
        Vibration.Light()
        let tabBarHeight: CGFloat = self.tabBarController?.tabBar.frame.size.height ?? 49
        customAddView.center.y = MainConstants.screenHeight + customAddView.frame.height/2 - tabBarHeight
        customAddView.isHidden = false
        dimView.isHidden = false
        plusView.isHidden = true
        openCustomView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.dimView.backgroundColor = self.dimView.backgroundColor?.withAlphaComponent(0.2)
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
                AnimateDismissCustomAddView()
            default:
                return
            }
        }
    }
    
    
    func PopulateMaterialsObject(){
        for count in 0...MaterialsObjectItems.color.count-1 {
            let toList = MaterialsObject()
            toList.color = MaterialsObjectItems.color[count]
            toList.image = MaterialsObjectItems.image[count]
            toList.name = MaterialsObjectItems.name[count]
            materials.append(toList)
        }
        customAddView.PopulateMaterials(materialsObjectToPass: materials as NSObject)
    }
    
    
    func GetUserProgress(){
        Defaults.CheckLastLogged(alreadyLogged: { result in
            print("Already logged from defaults: \(result)")
            if (result > 1500) {
                let setHeight: CGFloat = self.progressView.heightOfProgressView
                self.progressView.progressHeightAnchor?.constant = CGFloat(setHeight)
                self.progressView.layoutIfNeeded()
            } else {
                let setHeight: CGFloat = 0.253 * CGFloat(result)
                self.progressView.progressHeightAnchor?.constant = CGFloat(setHeight)
                self.progressView.layoutIfNeeded()
            }
        })
    }
    
    
    func SetProgressHeight(addedSize add: Int){
        progressView.SetProgressHeight(addedSize: add)
    }

    
    func AnimateDismissThreeViews(){
        Vibration.Soft()
        let movement = plusView.frame.width * 1.72
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
    }
    
    
    func AnimateDismissCustomAddView(){
        Vibration.Light()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.customAddView.center.y += self.customAddView.frame.height
            self.progressView.backgroundColor = self.progressView.backgroundColor?.withAlphaComponent(0.1)
            self.dimView.backgroundColor = self.dimView.backgroundColor?.withAlphaComponent(0)
            self.progressView.progressView.backgroundColor = self.progressView.progressView.backgroundColor?.withAlphaComponent(1)
        }, completion: { finished in
            self.plusView.isHidden = false
            self.dimView.isHidden = true
            self.openCustomView.isHidden = false
            self.customAddView.isHidden = true
        })
    }
}





extension RecyclingController: RecyclingDelegate {
    func OpenTipsList() {
        print("Open tips list")
        let newVC = AchieveController()
        present(newVC, animated: false, completion: nil)
    }
    
    func LogValue(withSize size: Int, andMaterial material: String) {
        ServerMaterials.AddLoggedEvent(addedSize: size,
                                       forUserID: UserDefaults.standard.string(forKey: "uid")!,
                                       material: material)
        AnimateDismissCustomAddView()
        SetProgressHeight(addedSize: size)
    }
    
    func ChangeNumberViewColor() {
        numberView.backgroundColor = MainConstants.pink
        numberView.number.text = "Упс"
        numberView.label.text = "много"
    }
}




protocol RecyclingDelegate {
    func OpenTipsList()
    func LogValue(withSize size: Int, andMaterial material: String)
    func ChangeNumberViewColor()
}

