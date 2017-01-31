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
    
    var events = [RSSElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsView.eventsTable.dataSource = self
        self.eventsView.eventsTable.delegate = self
        
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
        
        self.prtView.spinner.startAnimating()
        DispatchQueue.global().async {
            PRTRequest.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.prtView.detailLabel.text = prt.status.statusWith(time: prt.time)
                        self.prtView.spinner.stopAnimating()
                        self.prtView.spinner.isHidden = true
                        self.prtView.icon.image = UIImage(named: "prt dark")
                    }
                }
            })
        }
        
        self.diningMenu.spinner.startAnimating()
        DispatchQueue.global().async {
            MenuRequest.getMenu(on: Date(), at: DiningHall.Boreman, completion: { result in
                DispatchQueue.main.sync {
                    if let r = result {
                        self.diningMenu.setMenu(menu: r, meal: Menu.Meal.breakfast)
                    }
                    self.diningMenu.spinner.stopAnimating()
                    self.diningMenu.spinner.isHidden = true
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func prtTapped(_ sender: Any) {
        print("pressed")
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
}

