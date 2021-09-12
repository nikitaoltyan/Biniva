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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = Colors.background
        tableView.separatorStyle = .singleLine
        
        let headerView: SettingsTableHeaderView = {
            let view = SettingsTableHeaderView()
            view.setTitle(title: NSLocalizedString("settings_title", comment: ""))
            view.delegate = self
            return view
        }()
        
        tableView.tableHeaderView = headerView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? RecyclingController {
            DispatchQueue.main.async {
                firstVC.updateDataAfterSettings()
                firstVC.updateDataAfterPaywall() // In case when user bought subscription in settings.
            }
        }
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
            case 1:
                if Defaults.getIsSubscribed() {
                    return 3 // Return 3 to place SubStats here
                } else {
                    return 2
                }
            case 2: return 3
            default: return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.image.image = UIImage(systemName: "location")
                cell.title.text = NSLocalizedString("settings_geolocation", comment: "")
            case 1:
                cell.image.image = UIImage(systemName: "app.badge")
                cell.title.text = NSLocalizedString("settings_notification", comment: "")
            case 2:
                cell.image.image = UIImage(systemName: "camera.circle")
                cell.title.text = NSLocalizedString("settings_camers", comment: "")
            default:
                cell.image.image = UIImage(systemName: "dollarsign.circle")
                cell.title.text = NSLocalizedString("settings_subscription", comment: "")
            }
            
        case 1:
            if Defaults.getIsSubscribed() {
                switch indexPath.row {
                case 0:
                    cell.image.image = UIImage(systemName: "cube.transparent")
                    cell.title.text = NSLocalizedString("settings_measure", comment: "")
                case 1:
                    cell.image.image = UIImage(systemName: "crown.fill")
                    cell.title.text = NSLocalizedString("settings_sub_stats", comment: "")
                default:
                    cell.image.image = UIImage(systemName: "mappin.and.ellipse")
                    cell.title.text = NSLocalizedString("settings_ask_for_points", comment: "")
                }
            } else {
                switch indexPath.row {
                case 0:
                    cell.image.image = UIImage(systemName: "cube.transparent")
                    cell.title.text = NSLocalizedString("settings_measure", comment: "")
                default:
                    cell.image.image = UIImage(systemName: "mappin.and.ellipse")
                    cell.title.text = NSLocalizedString("settings_ask_for_points", comment: "")
                }
            }
        case 2:
            switch indexPath.row {
            case 0:
                cell.image.image = UIImage(systemName: "figure.wave.circle")
                cell.title.text = "Instagram"
            case 1:
                cell.image.image = UIImage(systemName: "hand.raised")
                cell.title.text = NSLocalizedString("privacy_policy", comment: "")
            default:
                cell.image.image = UIImage(systemName: "newspaper")
                cell.title.text = NSLocalizedString("paywall_conditions", comment: "")
            }
            
        default:
            switch indexPath.row {
            case 0:
                cell.image.image = UIImage(systemName: "paperplane.circle")
                cell.title.text = NSLocalizedString("settings_leave_comment", comment: "")
            default:
                cell.image.image = UIImage(systemName: "star")
                cell.title.text = NSLocalizedString("settings_mark_app", comment: "")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Vibration.soft()
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 3: openSubscription()
            default: openAppSettings()
            }
        case 1:
            if Defaults.getIsSubscribed() {
                switch indexPath.row {
                case 0:
                    openMeasureController()
                case 1: openSubStatsController()
                default: openAskForPoints()
                }
            } else {
                switch indexPath.row {
                case 0: openMeasureController()
                default: openAskForPoints()
                }
            }
        case 2:
            switch indexPath.row {
            case 0: openInstagram()
            case 1: openPrivacyPolicy()
            default: openTermsOfUse()
            }
        default:
            switch indexPath.row {
            case 0: openLeaveComment()
            default: openAppStore()
            }
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
    func openAskForPoints() {
        let newVC = AskForPointsController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
        return
    }
    
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
        guard Defaults.getIsSubscribed() else {
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
    
    private
    func openMeasureController() {
        // TODO:
        // VC should open from the right to left. (?)
        // Or may be fuck this thing for now?
        let newVC = WeightMeasureController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
    
    private
    func openSubStatsController() {
        let newVC = SubscriptionStatsController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
    
    private
    func openInstagram() {
        let instagramHooks = NSLocalizedString("instagram_link", comment: "")
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            print("Open Biniva Inst page")
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
        } else {
            print("Open Ordinary Inst page")
            UIApplication.shared.open(NSURL(string: "http://instagram.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    private
    func openPrivacyPolicy() {
        if let url = URL(string: NSLocalizedString("paywall_privacy_policy_url", comment: "privacy policy link")) {
            UIApplication.shared.open(url)
        }
    }
    
    private
    func openTermsOfUse() {
        if let url = URL(string: NSLocalizedString("paywall_terms_of_use_url", comment: "terms of use link")) {
            UIApplication.shared.open(url)
        }
    }
    
    private
    func openLeaveComment() {
        // TODO:
        // VC should open from the right to left. (?)
        // Or may be fuck this thing for now?
        let newVC = LeaveCommentController()
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .coverVertical
        present(newVC, animated: true, completion: nil)
    }
    
    private
    func openAppStore() {
        if let url = URL(string: "itms-apps://apple.com/app/id1551525911") {
            UIApplication.shared.open(url)
        }
    }
}
