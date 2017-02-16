//
//  FirstViewController.swift
//  WVU Mobile
//
//  Created by Richard Deal on 12/15/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var prtView: PRTView!
    @IBOutlet weak var eventsView: LiteEventsView!
    @IBOutlet weak var diningMenu: LiteDiningMenu!
    @IBOutlet weak var favoriteDiningHallLabel: UILabel!
    
    var diningTableViewSource = LiteMenuTableViewController()
    
    var events = [RSSElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsView.eventsTable.dataSource = self
        self.eventsView.eventsTable.delegate = self

        self.diningMenu.menuTable.dataSource = self.diningTableViewSource
        self.diningMenu.menuTable.delegate = self.diningTableViewSource
        
        loadDiningHall()
        loadEvents()
        loadPRT()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if diningTableViewSource.menu?.diningHall != Global.favoriteDiningHall {
            loadDiningHall()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadDiningHall() {
        self.favoriteDiningHallLabel.text = "\(Global.favoriteDiningHall.name)'s Menu".uppercased()
        self.diningTableViewSource.menu = nil
        self.diningMenu.menuTable.reloadData()
        self.diningMenu.spinner.isHidden = false
        self.diningMenu.spinner.startAnimating()
        DispatchQueue.global().async {
            MenuRequest.getMenu(on: Date(), at: Global.favoriteDiningHall, completion: { result in
                DispatchQueue.main.sync {
                    if let r = result {
                        self.diningTableViewSource.menu = r
                        self.diningMenu.menuTable.reloadData()
                    }
                    self.diningMenu.spinner.stopAnimating()
                    self.diningMenu.spinner.isHidden = true
                }
            })
        }
    }
    
    func loadPRT() {
        self.prtView.spinner.isHidden = false
        self.prtView.detailLabel.text = ""
        self.prtView.icon.image = nil
        
        self.prtView.spinner.startAnimating()
        DispatchQueue.global().async {
            PRTRequest.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.prtView.detailLabel.text = prt.status.statusWith(time: prt.time)
                        self.prtView.icon.image = prt.status.prtImage
                    }
                    self.prtView.spinner.stopAnimating()
                    self.prtView.spinner.isHidden = true
                }
            })
        }
    }
    
    func loadEvents() {
        let parser = RSSRequest()

        self.eventsView.spinner.startAnimating()
        DispatchQueue.global().async {
            parser.getEvents(days: 1, completion: { events in
                DispatchQueue.main.sync {
                    let cal = Calendar.autoupdatingCurrent
                    var today = [RSSElement]()
                    
                    for e in events {
                        if cal.isDateInToday(e.date) {
                            today.append(e)
                        }
                    }
                    
                    self.events = today
                    self.eventsView.eventsTable.reloadData()
                    self.eventsView.spinner.stopAnimating()
                    self.eventsView.spinner.isHidden = true
                }
            })
        }
    }

    @IBAction func prtTapped(_ sender: Any) {
        loadPRT()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsView.eventsTable.dequeueReusableCell(withIdentifier: "eventLite", for: indexPath) as! LiteEventCell
        
        if events[indexPath.row].date.hourPrint == "12:00 AM" {
            cell.time.text = "All Day"
        } else {
            cell.time.text = events[indexPath.row].date.hourPrint
        }
        cell.title.text = events[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = WebViewController()
        webView.url = events[indexPath.row].link
            
        self.navigationController?.pushViewController(webView, animated: true)
            
        self.eventsView.eventsTable.cellForRow(at: indexPath)?.isSelected = false
    }
}

