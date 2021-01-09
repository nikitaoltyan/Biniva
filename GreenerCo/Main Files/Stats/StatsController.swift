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
        view.pageLabel.text = "Stats"
        return view
    }()

    let statsView: StatsView = {
        let width: CGFloat = MainConstants.screenWidth - 60
        let height: CGFloat = 350
        let view = StatsView(frame: CGRect(x: 0, y: 0, width: width, height: height))
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
        return table
    }()
    
    
    let scrollBorder = 48 as CGFloat
    let screenHeight = UIScreen.main.bounds.height
    var scrollChangePoint: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
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
        
        statsTable.register(StatsCell.self, forCellReuseIdentifier: "StatsCell")
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
