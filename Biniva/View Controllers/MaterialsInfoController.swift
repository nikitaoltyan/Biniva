//
//  MaterialsInfoController.swift
//  Biniva
//
//  Created by Nick Oltyan on 07.09.2021.
//

import UIKit

class MaterialsInfoController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        tableView.register(MaterialInfoCell.self, forCellReuseIdentifier: "MaterialInfoCell")
        tableView.backgroundColor = Colors.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
//        tableView.estimatedRowHeight = 250
//        tableView.rowHeight = UITableView.automaticDimension
        
        let headerView: SettingsTableHeaderView = {
            let view = SettingsTableHeaderView()
            view.setTitle(title: "Materials")
            view.delegate = self
            return view
        }()
        
        tableView.tableHeaderView = headerView
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialInfoCell", for: indexPath) as! MaterialInfoCell
        cell.setCell(forMaterial: indexPath.row)
        return cell
    }
    
}







extension MaterialsInfoController: settingsHeaderDelegate {
    func backAction() {
        dismiss(animated: true, completion: nil)
    }
}
