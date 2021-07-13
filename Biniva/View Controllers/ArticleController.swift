//
//  ArticleController.swift
//  Biniva
//
//  Created by Никита Олтян on 12.07.2021.
//

import UIKit

class ArticleController: UITableViewController {
    
    let parser = Parser()
    let server = Server()
    
    
    var articleID: String?
    var text: [String] = []
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(ArticleTextCell.self, forCellReuseIdentifier: "ArticleTextCell")
        tableView.register(ArticleImageCell.self, forCellReuseIdentifier: "ArticleImageCell")
        prepareText()
    }
    
    private
    func prepareText() {
        print("prepareText")
//        if let aid = articleID {
            server.getArticleText(forArtcileWithID: "aid", completion: { (text) in
                self.text = self.parser.tabParser(text: text)
                self.tableView.reloadData()
            })
//        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ArticleHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTextCell", for: indexPath) as! ArticleTextCell
        cell.setText(text: text[indexPath.row])
        return cell
    }
}
