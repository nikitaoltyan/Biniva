//
//  StatsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsController: UIViewController {
    
    var tableHeightConstraint: NSLayoutConstraint?
    
    lazy var scrollView: UIScrollView = {
        let scrollViewContentHeight = 1500 as CGFloat
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollViewContentHeight)
        scroll.delegate = self
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let topView: RegularTopView = {
        let view = RegularTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.imageButton.isHidden = true
        view.pageLabel.text = "Статистика"
        return view
    }()

    let statsView: StatsView = {
        let width: CGFloat = MainConstants.screenWidth - 60
        let height: CGFloat = 350
        let view = StatsView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            .with(bgColor: .clear)
            .with(cornerRadius: 25)
            .with(borderWidth: 2, color: MainConstants.orange.cgColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loggedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = MainConstants.nearBlack
        label.text = "Записанные события"
        label.font = UIFont.init(name: "SFPro-Bold", size: 25.0)
        return label
    }()
    
    lazy var statsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = MainConstants.white
        table.register(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        table.register(EmptyStatsCell.self, forCellReuseIdentifier: "EmptyStatsCell")
        return table
    }()
    
    let editLoggedView: EditLoggedView = {
        let view = EditLoggedView(frame: CGRect(x: 0, y: 0, width: MainConstants.screenWidth-30, height: 300))
            .with(cornerRadius: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let scrollBorder = 48 as CGFloat
    let screenHeight = UIScreen.main.bounds.height
    var scrollChangePoint: CGFloat!
    var loggedData: Array<Dictionary<String,Any>> = []
    var indayKeys: Array<[String]> = [[],[],[],[],[],[],[]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { self.GetLoggedData() }
        title = "Статистика"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    
    func GetLoggedData(){
        Server.GetLastSevenDaysLoggedData(forUserId: Defaults.GetUserId(), data: { result in
            self.loggedData.append(result)
            guard (self.loggedData.count == 7) else { return }
            self.loggedData.reverse()
//            Maybe that think can't be implemented in some cases without exaptions. Not good at all.
            if (self.statsTable.window != nil) { self.statsTable.reloadData() }
            self.statsTable.reloadData()
            self.UpdateScrollHeight()
        })
    }

    
    func UpdateScrollHeight() {
        print("Timer fired!")
        var tableViewHeight: CGFloat {
            statsTable.layoutIfNeeded()
            return statsTable.contentSize.height
        }
        let setHeight = statsTable.frame.minY + tableViewHeight
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: setHeight)
        tableHeightConstraint?.constant = tableViewHeight
        statsTable.layoutIfNeeded()
    }

}





extension StatsController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return loggedData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let useDay = loggedData[section]["day"] as? String ?? "Day"
        let view = OtherHeaderView()
        view.label.text = useDay
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfLogged = loggedData[section]["logged_materials"] as? Dictionary<String,Any> ?? [:]
        guard (numberOfLogged.count != 0) else { return 1 }
        return numberOfLogged.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfLogged = loggedData[indexPath.section]["logged_materials"] as? Dictionary<String,Any> ?? [:]
        guard (numberOfLogged.count != 0) else {
            let cell = ReturnEmptyCell(forIndexPath: indexPath)
            return cell
        }
        let cell = ReturnStatsCell(forData: loggedData[indexPath.section],
                                   section: indexPath.section,
                                   indexPath: indexPath,
                                   andKeys: indayKeys[indexPath.section])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, handler) in
            Vibration.Heavy()
            let id = self.indayKeys[indexPath.section][indexPath.row] as String
            self.indayKeys[indexPath.section].remove(at: indexPath.row)
            if var data = self.loggedData[indexPath.section]["logged_materials"] as? Dictionary<String,Any>{
                data.removeValue(forKey: id)
                self.loggedData[indexPath.section]["logged_materials"] = data
            }
            let useDay = self.loggedData[indexPath.section]["day"] as? String
            ServerMaterials.DeleteLoggedData(forUserId: Defaults.GetUserId(), day: useDay, andLoggedId: id)
            self.statsTable.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        let editAction = UIContextualAction(style: .normal, title: "Изменить") { (action, view, handler) in
            print("Edit Action Tapped")
            self.editLoggedView.isHidden = false
            
        }
        editAction.backgroundColor = MainConstants.orange
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
    func ReturnStatsCell(forData data: Dictionary<String,Any>, section: Int, indexPath: IndexPath, andKeys keys: [String]) -> StatsCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
        let logged = data["logged_materials"] as? Dictionary<String,Any> ?? [:]
        var useKeys: Array<String> = []
        if keys.count == 0 {
            useKeys = [String](logged.keys)
            indayKeys[section] = useKeys
        } else {
            useKeys = keys
        }
        let useKey = useKeys[indexPath.row]
        let useData = logged[useKey] as? Dictionary<String,Any> ?? [:]
        DispatchQueue.main.async {
            cell.SetCell(withData: useData)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func ReturnEmptyCell(forIndexPath indexPath: IndexPath) -> EmptyStatsCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "EmptyStatsCell", for: indexPath) as! EmptyStatsCell
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        return cell
    }
}







extension StatsController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            statsTable.isScrollEnabled = (self.scrollView.contentOffset.y >=  600)
        }
        if scrollView == self.statsTable {
            statsTable.isScrollEnabled = (statsTable.contentOffset.y > 0)
        }
    }
}





extension StatsController: StatsDelegate {
    func OpenAchievements() {
        print("Open achievements")
    }
}





extension StatsController {
    
    func SetSubviews(){
        view.addSubview(scrollView)
//        scrollView.addSubview(topView)
        scrollView.addSubview(statsView)
        scrollView.addSubview(loggedLabel)
        scrollView.addSubview(statsTable)
        view.addSubview(editLoggedView)
        
        editLoggedView.isHidden = true
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            topView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -scrollBorder),
//            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            topView.heightAnchor.constraint(equalToConstant: 150),
            
            statsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsView.widthAnchor.constraint(equalToConstant: statsView.frame.width),
            statsView.heightAnchor.constraint(equalToConstant: statsView.frame.height),
            
            loggedLabel.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 20),
            loggedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
//              statsTable height constraint in the bottom of the function.
            statsTable.topAnchor.constraint(equalTo: loggedLabel.bottomAnchor, constant: 10),
            statsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            statsTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            editLoggedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            editLoggedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editLoggedView.widthAnchor.constraint(equalToConstant: editLoggedView.frame.width),
            editLoggedView.heightAnchor.constraint(equalToConstant: editLoggedView.frame.height),
        ])
        
        tableHeightConstraint = statsTable.heightAnchor.constraint(equalToConstant: 250)
        tableHeightConstraint?.isActive = true
    }
}
