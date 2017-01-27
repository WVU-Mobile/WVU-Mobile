//
//  SecondViewController.swift
//  WVU Mobile
//
//  Created by Richard Deal on 12/15/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DateSelectorViewControllerDelegate {

    @IBOutlet weak var events: EventsTable!
    var dateSelector: DateSelectorViewController!
    var gesture: UITapGestureRecognizer!
    
    var eventsByDate = [String:[RSSElement]]()
    var selectedDate = Date()
    
    var favoriteEvents: [String] {
        get {
            if let f = UserDefaults.standard.array(forKey: "favorite-events") {
                return f as! [String]
            }
            return []
        }
        
        set(value) {
            UserDefaults.standard.set(value, forKey: "favorite-events")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(EventsViewController.tap))
        
        dateSelector = DateSelectorViewController(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        dateSelector.delegate = self
        
        view.addSubview(dateSelector)
        
        loadToday()
        loadOtherDaysInBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.events.reloadData()
    }
    
    func loadToday() {
        let parser = RSSRequest()
        
        DispatchQueue.global().async {
            parser.getEvents(days: 1, completion: { events in
                DispatchQueue.main.sync {
                    for i in events {
                        if self.eventsByDate[i.date.day] == nil {
                            self.eventsByDate[i.date.day] = []
                        }
                        self.eventsByDate[i.date.day]?.append(i)
                    }
                    self.events.reloadData()
                }
            })
        }
    }
    
    func loadOtherDaysInBackground() {
        let parser = RSSRequest()
        var eventsDate = [String:[RSSElement]]()
        
        DispatchQueue.global().async {
            parser.getEvents(days: 60, completion: { events in
                DispatchQueue.main.sync {
                    for i in events {
                        if eventsDate[i.date.day] == nil {
                            eventsDate[i.date.day] = []
                        }
                        eventsDate[i.date.day]?.append(i)
                    }
                    self.eventsByDate = eventsDate
                }
            })
        }
    }
    
    func loadDay(date: Date) {
        if let _ = self.eventsByDate[date.day] {
            self.events.reloadData()
            return
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let e = eventsByDate[selectedDate.day] {
            return e.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! LargeEventsCell
        
        if let e = eventsByDate[selectedDate.day] {
            cell.details.text = e[indexPath.row].description
            
            if e[indexPath.row].date.hourPrint == "12:00 AM" {
                cell.time.text = "All Day"
            } else {
                cell.time.text = e[indexPath.row].date.hourPrint
            }
            
            cell.star.tag = indexPath.row
            
            let image: UIImage
            
            if favoriteEvents.contains(e[indexPath.row].identifier) {
                image = UIImage(named: "Star-Filled")!
            } else {
                image = UIImage(named: "Star")!
            }
            
            let tinted = image.withRenderingMode(.alwaysTemplate)
            
            cell.star.setImage(tinted, for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let e = eventsByDate[selectedDate.day] {
            let webView = WebViewController()
            webView.url = e[indexPath.row].link
            
            self.navigationController?.pushViewController(webView, animated: true)
            
            self.events.cellForRow(at: indexPath)?.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func didSelectStar(_ sender: UIButton) {
        if var e = eventsByDate[selectedDate.day] {
            if e[sender.tag].favorite {
                eventsByDate[selectedDate.day]![sender.tag].favorite = false
                if let remove = favoriteEvents.index(of: e[sender.tag].identifier) {
                    favoriteEvents.remove(at: remove)
                }
            } else {
                eventsByDate[selectedDate.day]![sender.tag].favorite = true
                favoriteEvents.append(e[sender.tag].identifier)
            }
            self.events.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tap() {
        self.dateSelector.dismissCalendar()
    }
    
    func didSelectNewDate(date: Date) {
        self.selectedDate = date
        self.events.reloadData()
    }
    
    func calendarDidAppear() {
        self.dateSelector.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 360)
        self.events.addGestureRecognizer(gesture)
    }
    
    func calendarDidDisappear() {
        self.dateSelector.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        self.events.removeGestureRecognizer(gesture)
    }

}
