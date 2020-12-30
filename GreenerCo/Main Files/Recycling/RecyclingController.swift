//
//  RecyclingController.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 31.10.2020.
//

import UIKit

class RecyclingController: UIViewController {

    @IBOutlet weak var controllerLabel: UILabel!
    @IBOutlet weak var topBGView: UIView!
    @IBOutlet weak var mainView: UIView!

    let plusView: CompletePlusView = {
        var width: CGFloat!
        if MainConstants.screenHeight > 700 {width = 70} else {width = 58}
        let view = CompletePlusView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MainConstants.green
        view.layer.cornerRadius = width/3
        view.horizontalView.backgroundColor = MainConstants.white
        view.verticalView.backgroundColor = MainConstants.white
        return view
    }()
    
    let addFirstItemView: AddItemView = {
        var width: CGFloat!
        if MainConstants.screenHeight > 700 {width = 70} else {width = 58}
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    let addSecondItemView: AddItemView = {
        var width: CGFloat!
        if MainConstants.screenHeight > 700 {width = 70} else {width = 58}
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    let addThirdItemView: AddItemView = {
        var width: CGFloat!
        if MainConstants.screenHeight > 700 {width = 70} else {width = 58}
        let view = AddItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = width/3
        return view
    }()
    
    @IBOutlet weak var customAddView: CustomAddView!
    @IBOutlet weak var customTable: UITableView!
    var profileImage: UIImageView!
    var openCustomView: UIView!
    var pickedView: UIView!
    var pickedImage: UIImageView!
    var bgRecyclingBin: UIView!
    var fillRecylingBin: UIView!
    
    let screenHeight = UIScreen.main.bounds.height
    var materials = [MaterialsObject]()
    
    var isAddMenuActivated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View height: \(UIScreen.main.bounds.height)")
        PopulateMaterialsObject()
        controllerLabel.text = "Переработка"
        controllerLabel.font = UIFont.init(name: "Palatino-Bold", size: 35.0)
        PerformLayers()
    }
    
    func ChangeColor(){
        print("Change Color")
        view.backgroundColor = MaterialsColors.metalBeige
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
                self.bgRecyclingBin.backgroundColor = self.bgRecyclingBin.backgroundColor?.withAlphaComponent(0.1)
                self.fillRecylingBin.backgroundColor = self.fillRecylingBin.backgroundColor?.withAlphaComponent(1)
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
                self.bgRecyclingBin.backgroundColor = self.bgRecyclingBin.backgroundColor?.withAlphaComponent(0.05)
                self.fillRecylingBin.backgroundColor = self.fillRecylingBin.backgroundColor?.withAlphaComponent(0.2)
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
        customAddView.center.y = MainConstants.screenHeight + customAddView.frame.height/2 + 20
        customAddView.isHidden = false
        openCustomView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.customAddView?.center.y -= self.customAddView.frame.height
            self.bgRecyclingBin.backgroundColor = self.bgRecyclingBin.backgroundColor?.withAlphaComponent(0.05)
            self.fillRecylingBin.backgroundColor = self.fillRecylingBin.backgroundColor?.withAlphaComponent(0.2)
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
                    self.bgRecyclingBin.backgroundColor = self.bgRecyclingBin.backgroundColor?.withAlphaComponent(0.1)
                    self.fillRecylingBin.backgroundColor = self.fillRecylingBin.backgroundColor?.withAlphaComponent(1)
                }, completion: { finished in
                    self.openCustomView.isHidden = false
                    self.customAddView.isHidden = true
                })
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
        customTable.reloadData()
    }

}

extension RecyclingController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materials.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTable.dequeueReusableCell(withIdentifier: "CustomAddCell", for: indexPath) as! CustomAddCell
        cell.itemColorView.backgroundColor = materials[indexPath.row].color
        cell.itemImage.image = materials[indexPath.row].image
        cell.itemLabel.text = materials[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickedImage.image = materials[indexPath.row].image
        pickedView.backgroundColor = materials[indexPath.row].color
        print("View center position. y = \(customAddView.center.y), x = \(customAddView.center.x)")
    }
}

