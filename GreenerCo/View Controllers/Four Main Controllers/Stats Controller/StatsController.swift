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
    
    
    let scrollBorder = 48 as CGFloat
    let screenHeight = UIScreen.main.bounds.height
    var scrollChangePoint: CGFloat!
    var loggedData: Array<Dictionary<String,Any>> = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Server.GetLastSevenDaysLoggedData(forUserId: Defaults.GetUserId(), data: { result in
            self.loggedData.append(result)
            guard (self.loggedData.count == 7) else { return }
            self.loggedData.reverse()
            self.statsTable.reloadData()
        })
        view.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
        _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }

    
    @objc func fireTimer() {
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfLogged = loggedData[indexPath.section]["logged_materials"] as? Dictionary<String,Any> ?? [:]
        guard (numberOfLogged.count != 0) else {
            let cell = ReturnEmptyCell(forIndexPath: indexPath)
            return cell
        }
        let cell = ReturnStatsCell(forData: loggedData[indexPath.section], andIndexPath: indexPath)
        return cell
    }
    
    
    
    func ReturnStatsCell(forData data: Dictionary<String,Any>, andIndexPath indexPath: IndexPath) -> StatsCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
        let logged = data["logged_materials"] as? Dictionary<String,Any> ?? [:]
        let keys = Array(logged.keys)
        let useKey = String(keys[indexPath.row])
        let useData = logged[useKey] as? Dictionary<String,Any> ?? [:]
        cell.SetCell(withData: useData)
        cell.selectionStyle = .none
        return cell
    }
    
    func ReturnEmptyCell(forIndexPath indexPath: IndexPath) -> EmptyStatsCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "EmptyStatsCell", for: indexPath) as! EmptyStatsCell
        cell.selectionStyle = .none
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
        scrollView.addSubview(topView)
        scrollView.addSubview(statsView)
        scrollView.addSubview(loggedLabel)
        scrollView.addSubview(statsTable)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -scrollBorder),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 150),
            
            statsView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsView.widthAnchor.constraint(equalToConstant: statsView.frame.width),
            statsView.heightAnchor.constraint(equalToConstant: statsView.frame.height),
            
            loggedLabel.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 20),
            loggedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
//              statsTable height constraint in the bottom of the function.
            statsTable.topAnchor.constraint(equalTo: loggedLabel.bottomAnchor, constant: 10),
            statsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            statsTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        tableHeightConstraint = statsTable.heightAnchor.constraint(equalToConstant: 250)
        tableHeightConstraint?.isActive = true
    }
}
