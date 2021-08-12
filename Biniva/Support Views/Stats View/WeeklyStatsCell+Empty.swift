//
//  WeeklyStatsCell+Empty.swift
//  Biniva
//
//  Created by Nick Oltyan on 11.08.2021.
//

import UIKit

class WeeklyStatsCell_Empty: UICollectionViewCell {

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .brown
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}






extension WeeklyStatsCell_Empty {
    private
    func setSubviews(){
    }
    
    private
    func activateLayouts(){
        NSLayoutConstraint.activate([
            
        ])
    }
}
