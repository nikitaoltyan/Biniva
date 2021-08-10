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
    
    let measure = Measure()

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
        label.text = NSLocalizedString("stats_subtitle", comment: "The whole view subtitle")
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
    
    let eventsTitle: UILabel = {
        let label = UILabel()
            .with(color: MainConstants.nearBlack)
            .with(alignment: .left)
            .with(numberOfLines: 1)
            .with(fontName: "SFPro-Bold", size: 22)
            .with(autolayout: false)
        label.text = NSLocalizedString("stats_events_title", comment: "Just a title before whole stats table")
        return label
    }()
    
    let materialStatsView: MaterialStatView = {
        let view = MaterialStatView()
            .with(autolayout: false)
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()
    
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
        table.register(EmptyStatsCell.self, forCellReuseIdentifier: "EmptyStatsCell")
        return table
    }()
    
    let instaLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 15)
            .with(autolayout: false)
        label.isUserInteractionEnabled = true
        label.text = "Instagram"
        return label
    }()
    
    let privacyPolicyLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .center)
            .with(fontName: "SFPro-Medium", size: 15)
            .with(autolayout: false)
        label.isUserInteractionEnabled = true
        label.text = NSLocalizedString("privacy_policy", comment: "Title for Privacy Policy link")
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
        setSubviews()
        activateLayouts()
        fetchData()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    func fetchData(){
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
        scrollView.contentSize = CGSize(width: MainConstants.screenWidth, height: 735 + height)
    }
    
    func updateLabel(){
        DataFunction().getTotalLogged(result: { sum in
            self.weightLabel.text = self.measure.getMeasurementString(weight: sum, forNeededType: .kilogramm)
        })
    }
    
    @objc
    func openInst() {
        let instagramHooks = "instagram://user?username=biniva_app"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            print("Open Biniva Inst page")
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
        } else {
            print("Open Ordinary Inst page")
            UIApplication.shared.open(NSURL(string: "http://instagram.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc
    func openPrivacyPolicy() {
        if let url = URL(string: "http://greener.tilda.ws/privacy_policy") {
            UIApplication.shared.open(url)
        }
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
    func update(){
        materialStatsView.update()
        fetchData()
    }
}



extension StatsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model?.count {
        case 0, nil:
            return 1
        default:
            return model?.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model?.count {
        case 0, nil:
            let cell = statsTable.dequeueReusableCell(withIdentifier: "EmptyStatsCell") as! EmptyStatsCell
            return cell
        default:
            let cell = statsTable.dequeueReusableCell(withIdentifier: "StatsCell") as! StatsCell
            cell.dateLabel.text = model?[indexPath.row].day?.inString
            cell.updateData(logSizes: model?[indexPath.row].logSize,
                            logMaterials: model?[indexPath.row].logMaterial)
            return cell
        }
    }
}





extension StatsView {
    private
    func setSubviews(){
        self.addSubview(scrollView)
        scrollView.addSubview(weightLabel)
        scrollView.addSubview(subtitle)
//        scrollView.addSubview(timeTitle)
        scrollView.addSubview(eventsTitle)
        scrollView.addSubview(materialStatsView)
        scrollView.addSubview(statsTable)
        scrollView.addSubview(instaLabel)
        scrollView.addSubview(privacyPolicyLabel)
        
        instaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInst)))
        privacyPolicyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPrivacyPolicy)))
    }
    
    private
    func activateLayouts(){
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
            
            materialStatsView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 37),
            materialStatsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            materialStatsView.widthAnchor.constraint(equalToConstant: materialStatsView.frame.width),
            materialStatsView.heightAnchor.constraint(equalToConstant: materialStatsView.frame.height),
            
//            statsTable height was setted in the bottom of the function.
            statsTable.topAnchor.constraint(equalTo: materialStatsView.bottomAnchor, constant: 85),
            statsTable.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statsTable.widthAnchor.constraint(equalToConstant: MainConstants.screenWidth - 50),
            
            eventsTitle.bottomAnchor.constraint(equalTo: statsTable.topAnchor, constant: -8),
            eventsTitle.leftAnchor.constraint(equalTo: statsTable.leftAnchor),
            
            instaLabel.topAnchor.constraint(equalTo: statsTable.bottomAnchor, constant: 45),
            instaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            privacyPolicyLabel.topAnchor.constraint(equalTo: instaLabel.bottomAnchor, constant: 12),
            privacyPolicyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        statsTableHeightConst = statsTable.heightAnchor.constraint(equalToConstant: 100)
        statsTableHeightConst?.isActive = true
    }
}
