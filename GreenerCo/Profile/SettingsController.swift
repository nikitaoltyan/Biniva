//
//  SettingsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 21.12.2020.
//

import UIKit

class SettingsController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MainConstants.white
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = MainConstants.white
            return view
        }()
        
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = MainConstants.nearBlack
            return label
        }()
        
        switch section {
        case 0:
            label.text = "Settings"
            label.font = UIFont(name: "SFPro-Heavy", size: 31)
        default:
            label.text = "Header"
            label.font = UIFont(name: "SFPro-Medium", size: 23)
        }
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100
        default:
            return 50
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        cell.backgroundColor = .white
        return cell
    }

}
