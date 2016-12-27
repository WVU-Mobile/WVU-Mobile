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
    @IBOutlet weak var eventsTable: LiteEventsTable!
    @IBOutlet weak var diningMenu: LiteDiningMenu!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsTable.dataSource = self
        self.eventsTable.delegate = self
        
        let parser = EventRequest()
        
        self.eventsTable.spinner.startAnimating()
        DispatchQueue.global().async {
            parser.getEvents(days: 1, completion: { events in
                DispatchQueue.main.sync {
                    self.events = events
                    self.eventsTable.reloadData()
                    self.eventsTable.spinner.stopAnimating()
                    self.eventsTable.spinner.isHidden = true
                }
            })
        }
        
        self.prtView.spinner.startAnimating()
        DispatchQueue.global().async {
            PRTRequest.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.prtView.mainLabel.text = prt.status.overall
                        self.prtView.detailLabel.text = prt.status.statusWith(time: prt.time)
                        self.prtView.spinner.stopAnimating()
                        self.prtView.spinner.isHidden = true
                        self.prtView.icon.image = UIImage(named: "tram")
                    }
                }
            })
        }
        
        self.diningMenu.spinner.startAnimating()
        DispatchQueue.global().async {
            MenuRequest.getMenu(on: Date(), at: DiningHall.Boreman, completion: { result in
                DispatchQueue.main.sync {
                    if let r = result {
                        self.diningMenu.setMenu(menu: r, meal: Menu.Meal.dinner)
                        for i in r.menu {
                            print(i.string)
                        }
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
        self.prtView.press()
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
        let cell = eventsTable.dequeueReusableCell(withIdentifier: "eventLite", for: indexPath) as! LiteEventCell
        
        if events[indexPath.row].date.hourPrint == "12:00 AM" {
            cell.time.text = "All Day"
        } else {
            cell.time.text = events[indexPath.row].date.hourPrint
        }
        cell.title.text = events[indexPath.row].title
        
        return cell
    }
}

