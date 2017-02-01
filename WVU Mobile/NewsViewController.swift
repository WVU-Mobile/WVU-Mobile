//
//  NewsViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/28/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    var news = [RSSElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.beginRefreshing()
        pullNews()
        
        self.refreshControl?.addTarget(self, action: #selector(pullNews), for: UIControlEvents.valueChanged)
    }
    
    func pullNews() {
        news = []
        let group = DispatchGroup()
        
        let request = RSSRequest()
        DispatchQueue.global().async(group: group) {
            request.getNews(source: .wvutoday, completion: { news in
                DispatchQueue.main.sync {
                    self.news += news
                }
            })
        }
        
        let request2 = RSSRequest()
        DispatchQueue.global().async(group: group) {
            request2.getNews(source: .da, completion: { news in
                DispatchQueue.main.sync {
                    self.news += news
                }
            })
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.news.sort(by: {$0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970})
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as! NewsCell
            cell.details.text = news[indexPath.row].description
            cell.title.text = news[indexPath.row].title
            cell.date.text = news[indexPath.row].date.timeAgo
            
            if let s = news[indexPath.row].source {
                cell.source.image = UIImage(named: s.image)
                cell.sourceName.text = s.name
            }
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = WebViewController()
        webView.url = news[indexPath.row].link
        webView.article = news[indexPath.row].title
        
        self.navigationController?.pushViewController(webView, animated: true)
        
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
