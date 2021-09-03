//
//  AskForPointsFooter.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.09.2021.
//

import UIKit

class AskForPointsFooter: UIView {

    let desc: UILabel = {
        let label = UILabel()
            .with(autolayout: false)
            .with(color: Colors.darkGrayText)
            .with(alignment: .center)
            .with(numberOfLines: 0)
            .with(fontName: "Helvetica", size: 12)
        label.text = NSLocalizedString("ask_for_points_footer", comment: "")
        return label
    }()

    override init(frame: CGRect) {
        let useFrame = CGRect(x: 0, y: 0, width: MainConstants.screenWidth, height: 50)
        super.init(frame: useFrame)
        self.backgroundColor = Colors.background
        setSubviews()
        activateLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}






extension AskForPointsFooter {
    private
    func setSubviews() {
        self.addSubview(desc)
    }
    
    private
    func activateLayouts() {
        NSLayoutConstraint.activate([
            desc.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
        ])
    }
}
