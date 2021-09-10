//
//  AskForPointsController.swift
//  Biniva
//
//  Created by Nick Oltyan on 02.09.2021.
//

import UIKit

class AskForPointsController: UITableViewController {
    
    let coreDatabase = DataFunction()

    var askForPointsSet: Set<AskForPoints> = []
    var askForPoints: [AskForPoints] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        tableView.register(AskForPointCell.self, forCellReuseIdentifier: "AskForPointCell")
        tableView.backgroundColor = Colors.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        
        let headerView: AskForPointsHeader = {
            let view = AskForPointsHeader()
            view.delegate = self
            view.set(title: NSLocalizedString("settings_ask_for_points", comment: ""),
                     description: NSLocalizedString("ask_for_points_header_desc", comment: ""))
            return view
        }()
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = AskForPointsFooter()
        
        coreDatabase.getAllAskForPoints(completion: { points in
            for point in points {
                self.askForPointsSet.insert(point)
            }
            self.askForPoints =  Array(self.askForPointsSet)
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return askForPoints.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AskForPointCell", for: indexPath) as! AskForPointCell
        cell.update(latitude: askForPoints[indexPath.row].latitude,
                    longitude: askForPoints[indexPath.row].longitude,
                    status: askForPoints[indexPath.row].status)
        return cell
    }
}






extension AskForPointsController: settingsHeaderDelegate {
    func backAction() {
        dismiss(animated: true, completion: nil)
    }
}

