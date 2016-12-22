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
    @IBOutlet weak var eventsTable: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsTable.dataSource = self
        self.eventsTable.delegate = self
        
        events.append(Event(title: "Testing this isn't it cool.", description: "", link: "", guid: "", date: Date()))
        events.append(Event(title: "Christmas tree lighting.", description: "", link: "", guid: "", date: Date()))
        
        let parser = EventRequest()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.time.text = events[indexPath.row].date.hourPrint
        cell.title.text = events[indexPath.row].title
        
        return cell
    }
}

