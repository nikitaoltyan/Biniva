//
//  StatsView.swift
//  GreenerCo
//
//  Created by Никита Олтян on 19.04.2021.
//

import UIKit

protocol Test {
    func update()
}


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
    
//    let timeTitle: UILabel = {
//        let label = UILabel()
//            .with(color: Colors.darkGrayText)
//            .with(alignment: .center)
//            .with(numberOfLines: 2)
//            .with(fontName: "SFPro-Medium", size: 14)
//            .with(autolayout: false)
//        label.text = "максимальное значение за день"
//        return label
//    }()
    
    lazy var statsTable: UITableView = {
        let table = UITableView()
            .with(bgColor: .clear)
            .with(cornerRadius: 30)
            .with(borderWidth: 2, color: Colors.topGradient.cgColor)
            .with(autolayout: false)
        
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.register(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        return table
    }()
    
    let privacyPolicyLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 15)
            .with(autolayout: false)
        label.isUserInteractionEnabled = true
        label.text = "Политика конфиденциальности"
        return label
    }()
    
    var delegate: StatsDelegate?
    let dataFunction = DataFunction()
    var model: [Model]?
    
    var statsTableHeightConst: NSLayoutConstraint?
    
    override init(frame: CGRect){
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: MainConstants.screenHeight)
        super.init(frame: useFrame)
        self.backgroundColor = .clear
        SetSubviews()
        ActivateLayouts()
        fetchData()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func fetchData(){
        model?.removeAll()
        statsTable.reloadData()
        model = dataFunction.fetchData()
        model?.reverse()
        statsTable.reloadData()
        updateConst()
        updateLabel()
    }
    
    func updateConst(){
        var height: CGFloat {
                    statsTable.layoutIfNeeded()
                    return statsTable.contentSize.height
                }
        statsTableHeightConst?.constant = height
        statsTable.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: 450 + height)
    }
    
    func updateLabel(){
        DataFunction().getTotalLogged(result: { sum in
            let formatted = String(format: "%.1f", Double(sum)/1000.0)
            self.weightLabel.text = "\(formatted) кг"
        })
    }
    
    @objc func openPrivacyPolicy() {
        // Add link here
        print("Privacy policy")
    }
}




extension StatsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (scrollView == self.scrollView) else { return }
        if scrollView.contentOffset.y < 22 {
            delegate?.HideTopBar(false)
        } else {
            delegate?.HideTopBar(true)
        }
    }
}


extension StatsView: Test {
    func update(){ fetchData() }
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
//        scrollView.addSubview(timeTitle)
        scrollView.addSubview(statsTable)
        scrollView.addSubview(privacyPolicyLabel)
        
        privacyPolicyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPrivacyPolicy)))
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
            
//            timeTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 6),
//            timeTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
//            statsTable height was setted in the bottom of the function.
            statsTable.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 50),
            statsTable.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statsTable.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth - 50),
            
            privacyPolicyLabel.topAnchor.constraint(equalTo: statsTable.bottomAnchor, constant: 45),
            privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        statsTableHeightConst = statsTable.heightAnchor.constraint(equalToConstant: 100)
        statsTableHeightConst?.isActive = true
    }
}
