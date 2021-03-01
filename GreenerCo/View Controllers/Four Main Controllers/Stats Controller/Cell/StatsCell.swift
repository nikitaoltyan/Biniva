//
//  StatsCell.swift
//  GreenerCo
//
//  Created by Никита Олтян on 07.11.2020.
//

import UIKit

class StatsCell: UITableViewCell {

    var loggedView: ItemView = {
        let width: CGFloat = 65
        let view = ItemView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            .with(cornerRadius: width/3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = MainConstants.nearBlack
        label.font = UIFont.init(name: "SFPro", size: 22.0)
        return label
    }()
    
//    let dateAndTime: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.textColor = MainConstants.nearBlack
//        label.text = "15:08   6 Марта"
//        label.font = UIFont.init(name: "SFPro", size: 15.0)
//        return label
//    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = MainConstants.white
        SetSubviews()
        ActivateLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    
    func SetCell(withData data: Dictionary<String,Any>) {
        guard (data.count == 2) else {
            mainLabel.text = "No data available"
            return
        }
        let material = data["material"] as? String ?? "nil"
        let logged = data["logged"] as? Int ?? -69
        SetupLoggedView(forMaterial: material, weight: logged)
    }
    
    
    func SetupLoggedView(forMaterial material: String, weight: Int){
        switch material {
        case "Пластик":
            loggedView.image.image = MaterialsIcons.waterBottle
            loggedView.backgroundColor = MaterialsColors.waterBlue
            mainLabel.text = "\(weight)гр. пластика"
        case "Органика":
            loggedView.image.image = MaterialsIcons.organicLimone
            loggedView.backgroundColor = MaterialsColors.organicGreen
            mainLabel.text = "\(weight)гр. органики"
        case "Бумага":
            loggedView.image.image = MaterialsIcons.paper
            loggedView.backgroundColor = MaterialsColors.paperOrange
            mainLabel.text = "\(weight)гр. бумаги"
        default:
            loggedView.image.image = MaterialsIcons.metal
            loggedView.backgroundColor = MaterialsColors.metalBeige
            mainLabel.text = "\(weight)гр. металла"
        }
    }
}




extension StatsCell {
    
    func SetSubviews(){
        self.addSubview(loggedView)
        self.addSubview(mainLabel)
//        self.addSubview(dateAndTime)
    }
    
    func ActivateLayouts(){
        NSLayoutConstraint.activate([
            loggedView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loggedView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            loggedView.heightAnchor.constraint(equalToConstant: loggedView.frame.height),
            loggedView.widthAnchor.constraint(equalToConstant: loggedView.frame.width),
            
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainLabel.leftAnchor.constraint(equalTo: loggedView.rightAnchor, constant: 25),
            
//            dateAndTime.leftAnchor.constraint(equalTo: mainLabel.leftAnchor),
//            dateAndTime.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5)
        ])
    }
}
