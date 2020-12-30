//
//  StatsController.swift
//  GreenerCo
//
//  Created by Никита Олтян on 05.11.2020.
//

import UIKit

class StatsController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topBGView: StatsTopBGView!
    @IBOutlet weak var mainBGView: StatsMainBGView!
    @IBOutlet weak var statsView: StatsView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statsTable: UITableView!
    
    let scrollViewContentHeight = 1500 as CGFloat
    let scrollBorder = 48 as CGFloat
    let screenHeight = UIScreen.main.bounds.height
    var scrollChangePoint: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PerformLayers()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: scrollViewContentHeight)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        statsTable.isScrollEnabled = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            statsTable.isScrollEnabled = (self.scrollView.contentOffset.y >=  600)
        }
        if scrollView == self.statsTable {
            statsTable.isScrollEnabled = (statsTable.contentOffset.y > 0)
        }
    }
    
    
    func PerformLayers(){
        TopView()
        MainView()
        StatsView()
        TableLayer()
        WeekMonthSelection()
        LogedLabel()
    }

    func TopView(){
        topBGView.translatesAutoresizingMaskIntoConstraints = false
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                topBGView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -50),
                topBGView.leftAnchor.constraint(equalTo: view.leftAnchor),
                topBGView.rightAnchor.constraint(equalTo: view.rightAnchor),
                topBGView.heightAnchor.constraint(equalToConstant: 200)
            ])
        } else {
            const.append(contentsOf: [
                topBGView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
                topBGView.leftAnchor.constraint(equalTo: view.leftAnchor),
                topBGView.rightAnchor.constraint(equalTo: view.rightAnchor),
                topBGView.heightAnchor.constraint(equalToConstant: 120)
            ])
        }
        NSLayoutConstraint.activate(const)
    }
    
    func MainView(){
        mainBGView.translatesAutoresizingMaskIntoConstraints = false
        var const: Array<NSLayoutConstraint> = []
        if MainConstants.screenHeight > 700 {
            const.append(contentsOf: [
                mainBGView.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: -103),
                mainBGView.leftAnchor.constraint(equalTo: view.leftAnchor),
                mainBGView.rightAnchor.constraint(equalTo: view.rightAnchor),
                mainBGView.heightAnchor.constraint(equalToConstant: scrollViewContentHeight)
            ])
        } else {
            const.append(contentsOf: [
                mainBGView.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: -25),
                mainBGView.leftAnchor.constraint(equalTo: view.leftAnchor),
                mainBGView.rightAnchor.constraint(equalTo: view.rightAnchor),
                mainBGView.heightAnchor.constraint(equalToConstant: scrollViewContentHeight)
            ])
        }
        NSLayoutConstraint.activate(const)
    }
    
    func StatsView(){
        statsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 150),
            statsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            statsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            statsView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func TableLayer(){
        statsTable.backgroundColor = MainConstants.white
        statsTable.register(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        statsTable.translatesAutoresizingMaskIntoConstraints = false
        let tableHeight = scrollViewContentHeight - statsView.layer.position.x - CGFloat(350+100) + 48
        scrollChangePoint = statsView.layer.position.y + 350 + 200 - scrollBorder
        print("Table height: \(tableHeight) and scrollChangePoint: \(scrollChangePoint!)")
        NSLayoutConstraint.activate([
            statsTable.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 100),
            statsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            statsTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            statsTable.heightAnchor.constraint(equalToConstant: tableHeight)
        ])
        statsTable.showsVerticalScrollIndicator = false
    }
    
    func LogedLabel(){
        let label = UILabel()
        view.addSubview(label)
        label.textColor = .darkGray
        label.text = "Записанные события"
        label.font = UIFont.init(name: "Palatino Bold", size: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: statsTable.topAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            label.rightAnchor.constraint(equalTo: view.rightAnchor),
            label.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    func WeekMonthSelection(){
        
    }
    
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
