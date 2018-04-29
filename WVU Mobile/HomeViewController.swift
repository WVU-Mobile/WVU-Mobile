//
//  FirstViewController.swift
//  WVU Mobile
//
//  Created by Richard Deal on 12/15/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var prtView: PRTView!
    @IBOutlet var eventsView: LiteEventsView!
    @IBOutlet var diningMenu: LiteDiningMenu!
    @IBOutlet var favoriteDiningHallLabel: UILabel!
    
    var diningTableViewSource = LiteMenuTableViewController()
    
    var events = [RSSElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsView.eventsTable.dataSource = self
        eventsView.eventsTable.delegate = self

        diningMenu.menuTable.dataSource = diningTableViewSource
        diningMenu.menuTable.delegate = diningTableViewSource
        
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
    
    func loadDiningHall() {
        favoriteDiningHallLabel.text = "\(Global.favoriteDiningHall.name)'s Menu".uppercased()
        diningTableViewSource.menu = nil
        diningMenu.menuTable.reloadData()
        diningMenu.spinner.isHidden = false
        diningMenu.spinner.startAnimating()
        
        DispatchQueue.global().async {
            MenuRequest.getMenu(on: Date(), at: Global.favoriteDiningHall, completion: { [weak self] result in
                DispatchQueue.main.sync {
                    if let r = result {
                        self?.diningTableViewSource.menu = r
                        self?.diningMenu.menuTable.reloadData()
                    }
                    self?.diningMenu.spinner.stopAnimating()
                    self?.diningMenu.spinner.isHidden = true
                }
            })
        }
    }
    
    func loadPRT() {
        prtView.spinner.isHidden = false
        prtView.detailLabel.text = ""
        prtView.icon.image = nil
        prtView.spinner.startAnimating()
        
        DispatchQueue.global().async {
            PRTRequest.getPRTStatus(completion: { [weak self] result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self?.prtView.detailLabel.text = prt.status.statusWith(time: prt.time)
                        self?.prtView.icon.image = prt.status.prtImage
                    }
                    self?.prtView.spinner.stopAnimating()
                    self?.prtView.spinner.isHidden = true
                }
            })
        }
    }
    
    func loadEvents() {
        let parser = RSSRequest()
        eventsView.spinner.startAnimating()
        
        DispatchQueue.global().async {
            parser.getEvents(days: 1, completion: { [weak self] events in
                DispatchQueue.main.sync {
                    self?.events = events.compactMap({ Calendar.autoupdatingCurrent.isDateInToday($0.date) ? $0 : nil })

                    self?.eventsView.eventsTable.reloadData()
                    self?.eventsView.spinner.stopAnimating()
                    self?.eventsView.spinner.isHidden = true
                }
            })
        }
    }

    @IBAction func prtTapped(_ sender: Any) {
        loadPRT()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventsView.eventsTable.dequeueReusableCell(withIdentifier: "eventLite", for: indexPath) as? LiteEventCell else {
            return UITableViewCell()
        }
        
        cell.time.text = events[indexPath.row].date.hourPrint == "12:00 AM" ? "All Day" : events[indexPath.row].date.hourPrint
        cell.title.text = events[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = WebViewController()
        webView.data = WebViewData(urlString: events[indexPath.row].link)
            
        navigationController?.pushViewController(webView, animated: true)
        eventsView.eventsTable.cellForRow(at: indexPath)?.isSelected = false
    }
    
}
