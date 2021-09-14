//
//  StatsCell.swift
//  GreenerCo
//
//  Created by Nick Oltyan on 26.04.2021.
//

import UIKit

class StatsCell: UITableViewCell {
    
    let measure = Measure()

    let dateLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(fontName: "SFPro-Bold", size: 20)
            .with(numberOfLines: 1)
            .with(autolayout: false)
        return label
    }()
    
    let loggedLabel: UILabel = {
        let label = UILabel()
            .with(color: Colors.nearBlack)
            .with(alignment: .left)
            .with(fontName: "SFPro", size: 17)
            .with(numberOfLines: 0)
            .with(autolayout: false)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setSubviews()
        activateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updateData(logSizes: [Int]?, logMaterials: [Int]?) {
        loggedLabel.text = ""
        guard (logSizes != nil && logMaterials != nil) else { return }
        
        for item in 0...(logSizes!.count-1) {
            let weightString = self.measure.getMeasurementString(weight: logSizes![item], forNeededType: .gramm)
            let logMaterial = MaterialDefaults().getMaterialName(id: logMaterials![item])
            let lastText = (loggedLabel.text ?? "") as String
            
            if (lastText.count == 0){
                loggedLabel.text = "\(weightString) \(logMaterial)"
            } else {
                loggedLabel.text = "\(lastText)\n\(weightString) \(logMaterial)"
            }
        }
    }
}





extension StatsCell {
    private
    func setSubviews(){
        self.addSubview(dateLabel)
        self.addSubview(loggedLabel)
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            loggedLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            loggedLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            loggedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
