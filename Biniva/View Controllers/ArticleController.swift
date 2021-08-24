//
//  ArticleController.swift
//  Biniva
//
//  Created by Biniva on 12.07.2021.
//

import UIKit

protocol articleHeaderDelegate {
    func backAction()
}

class ArticleController: UITableViewController {
    
    let materialFunction = MaterialFunctions()
    let parser = Parser()
    
    enum type {
        case text
        case image
    }
    
    var articleID: String?
    var text: [(String, type)] = []
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.background
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(ArticleTextCell.self, forCellReuseIdentifier: "ArticleTextCell")
        tableView.register(ArticleImageCell.self, forCellReuseIdentifier: "ArticleImageCell")
        
        let headerView: ArticleHeaderView = {
            let view = ArticleHeaderView()
            view.delegate = self
            return view
        }()
        
        tableView.tableHeaderView = headerView
        prepareText()
    }
    
    private
    func prepareText() {
        print("prepareText")
//        if Defaults.getIsSubscribed() {
//
//        } else {
//
//        }
        var images = 0
        var texts = 0
        DispatchQueue.main.async {
            let articleTexts = self.materialFunction.getArticleText()
            
            for text in articleTexts {
                for part in self.parser.tabParser(text: text) {
                    self.text.append((part, .text))
                }
                
                print("texts:\(texts) images:\(images)")
                if (texts == 1 || texts == 3) && images < 2{
                    let randomNumber = Int.random(in: 0...15)
                    self.text.append(("article_\(randomNumber)", .image))
                    images += 1
                }
                texts += 1
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let (_, type) = text[indexPath.row]
        if type == .image { return MainConstants.screenWidth/1.7 }
        else { return tableView.rowHeight }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (text, type) = text[indexPath.row]
        if type == .text {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTextCell", for: indexPath) as! ArticleTextCell
            cell.setText(text: text)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleImageCell", for: indexPath) as! ArticleImageCell
            cell.image.image = UIImage(named: text)
            return cell
        }
    }
}






extension ArticleController: articleHeaderDelegate {
    func backAction() {
        dismiss(animated: true, completion: nil)
    }
}
