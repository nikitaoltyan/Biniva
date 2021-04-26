//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 19.04.2021.
//

import UIKit

class StatsView: UIView {

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
            .with(autolayout: false)
        scroll.contentSize = CGSize(width: MainConstants.screenWidth, height: 1500)
        scroll.bounces = true
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 36)
            .with(autolayout: false)
        label.text = "35 кг"
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .center)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Medium", size: 18)
            .with(autolayout: false)
        label.text = "всего собрано мусора"
        return label
    }()
    
    let timeTitle: UILabel = {
        let label = UILabel()
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 2)
            .with(fontName: "SFPro-Medium", size: 14)
            .with(autolayout: false)
        label.text = "максимальное значение за день"
        return label
    }()
    
    lazy var statsTable: UITableView = {
        let table = UITableView()
            .with(bgColor: .clear)
            .with(cornerRadius: 30)
            .with(borderWidth: 2, color: Colors.topGradient.cgColor)
            .with(autolayout: false)
        
        table.delegate = self
        table.dataSource = self
        table.register(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        return table
    }()
    
    var delegate: StatsDelegate?
    let dataFunction = DataFunction()
    var model: [Model]?
    
    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        fetchData()
        SetSubviews()
        ActivateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func fetchData(){
        model = dataFunction.fetchData()
        model?.reverse()
        statsTable.reloadData()
    }
}




extension StatsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 25 {
            delegate?.HideTopBar(false)
        } else {
            delegate?.HideTopBar(true)
        }
    }
}




extension StatsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statsTable.dequeueReusableCell(withIdentifier: "StatsCell") as! StatsCell
        cell.dateLabel.text = model?[indexPath.row].day?.inString
        cell.updateData(logSizes: model?[indexPath.row].logSize,
                        logMaterials: model?[indexPath.row].logMaterial)
        return cell
    }
}





extension StatsView {
    func SetSubviews(){
        self.addSubview(scrollView)
        scrollView.addSubview(weightLabel)
        scrollView.addSubview(subtitle)
        scrollView.addSubview(timeTitle)
        scrollView.addSubview(statsTable)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 250),
            weightLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            subtitle.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 9),
            subtitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            timeTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 6),
            timeTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            statsTable.topAnchor.constraint(equalTo: timeTitle.bottomAnchor, constant: 50),
            statsTable.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statsTable.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth - 50),
            statsTable.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
}
