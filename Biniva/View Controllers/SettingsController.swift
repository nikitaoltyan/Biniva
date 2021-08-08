//
//  SettingsController.swift
//  Biniva
//
//  Created by Nick Oltyan on 06.08.2021.
//

import UIKit


protocol settingsHeaderDelegate {
    func backAction()
}

class SettingsController: UITableViewController {
    
    lazy var settingsTable: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                style: .insetGrouped)
            .with(bgColor: .clear)
            .with(borderWidth: 2, color: Colors.topGradient.cgColor)
            .with(autolayout: false)
        
        table.allowsSelection = true
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
        
        // Setting header for table
        var headerView: SettingsTableHeaderView = {
            let view = SettingsTableHeaderView()
            view.delegate = self
            return view
        }()
        
        table.tableHeaderView = headerView
        table.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = Colors.background
        tableView.separatorStyle = .singleLine
        
        let headerView: SettingsTableHeaderView = {
            let view = SettingsTableHeaderView()
            view.delegate = self
            return view
        }()
        
        tableView.tableHeaderView = headerView
//        setSubviews()
//        activateLayout()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Colors.background
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return 5
            default: return 18
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 4
            case 1: return 2
            case 2: return 3
            default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTable.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
//        let numberOfRows: Int = settingsTable.numberOfRows(inSection: indexPath.section)
//        cell.setCell(forRowNumber: indexPath.row, rowsInSection: numberOfRows)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.title.text = "Geolocation"
            case 1: cell.title.text = "Notification"
            case 2: cell.title.text = "Camera"
            default: cell.title.text = "Subscription"
            }
        case 1:
            switch indexPath.row {
            case 0: cell.title.text = "Measurement System"
            default: cell.title.text = "Daily Goal"
            }
        case 2:
            switch indexPath.row {
            case 0: cell.title.text = "Instagram"
            case 1: cell.title.text = "Privacy Policy"
            default: cell.title.text = "Terms of Use"
            }
        default:
            cell.title.text = "Leave a comment"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 3: openSubscription()
            default: openAppSettings()
            }
//        case 1:
//            switch indexPath.row {
//            case 0: cell.title.text = "Measurement System"
//            default: cell.title.text = "Daily Goal"
//            }
//        case 2:
//            switch indexPath.row {
//            case 0: cell.title.text = "Instagram"
//            case 1: cell.title.text = "Privacy Policy"
//            default: cell.title.text = "Terms of Use"
//            }
        default:
//            cell.title.text = "Leave a comment"
            print("Leave a comment")
        }
    
    }
}





extension SettingsController: settingsHeaderDelegate {
    func backAction() {
        dismiss(animated: true, completion: nil)
    }
}





/// Private functions to extend from TableView
extension SettingsController {
    private
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private
    func openSubscription() {
        guard Defaults.getSubscriptionStatus() else {
            let newVC = PaywallController()
            newVC.modalPresentationStyle = .overFullScreen
            newVC.modalTransitionStyle = .coverVertical
            present(newVC, animated: true, completion: nil)
            return
        }
        
        guard let subscriptionUrl = URL(string: "https://apps.apple.com/account/subscriptions") else {
            return
        }

        if UIApplication.shared.canOpenURL(subscriptionUrl) {
            UIApplication.shared.open(subscriptionUrl, completionHandler: { (_) in })
        }
    }
}




extension SettingsController {
    private
    func setSubviews() {
        view.addSubview(settingsTable)
    }
    
    private
    func activateLayout() {
        NSLayoutConstraint.activate([
            settingsTable.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            settingsTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            settingsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
