//
//  SettingsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 21.12.2020.
//

import UIKit

class SettingsController: UITableViewController {

    
    var uid: String? = Defaults.GetUserId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.headerColor
        tableView.separatorColor = MainConstants.nearWhite
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: "ProfileInfoCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = TopHeaderView()
            view.delegate = self
            return view
        case 1:
            let view = OtherHeaderView()
            view.label.text = "Профиль"
            return view
        case 2:
            let view = OtherHeaderView()
            view.label.text = "Переработка"
            return view
        case 3:
            let view = OtherHeaderView()
            view.label.text = "О нас"
            return view
        default:
            let view = OtherHeaderView()
            view.label.isHidden = true
            return view
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 150
        default:
            return 60
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell") as! ProfileInfoCell
            cell.UpdateData(userId: uid)
            cell.isUserInteractionEnabled = false
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
            return cell
        }
    }

}




extension SettingsController: HeaderDelegate {
    func Back(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}
