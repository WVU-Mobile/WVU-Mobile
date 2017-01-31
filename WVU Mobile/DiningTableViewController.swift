//
//  DiningTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class DiningTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DateSelectorViewControllerDelegate {
    @IBOutlet weak var menuTable: UITableView!
    
    var noInfoAvailableLabel: UILabel!
    var progressIndicator: UIActivityIndicatorView!
    
    var menu = Menu(diningHall: .Arnold)
    var diningHall = DiningHall.Arnold
    
    var dateSelector: DateSelectorViewController!
    var gesture: UITapGestureRecognizer!
    
    var selectedDate = Date()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    private let gregorian = Calendar(identifier: .gregorian)
    private let calendarRange = 60.0 * 60.0 * 24.0 * 60.0 // one month
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.delegate = self
        menuTable.dataSource = self
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(EventsViewController.tap))
        
        noInfoAvailableLabel = UILabel(frame: view.frame)
        noInfoAvailableLabel.text = "No menu info is available."
        noInfoAvailableLabel.backgroundColor = UIColor.white
        noInfoAvailableLabel.textAlignment = .center
        
        dateSelector = DateSelectorViewController(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        dateSelector.delegate = self
        
        view.addSubview(dateSelector)
        
        progressIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 50))
        progressIndicator.color = UIColor.black
        progressIndicator.startAnimating()
        view.addSubview(progressIndicator)
        
        menu.diningHall = diningHall
        
        loadToday()

    }
    
    func loadToday() {
        DispatchQueue.global().async {
            MenuRequest.getMenu(on: self.selectedDate, at: self.diningHall, completion: { result in
                DispatchQueue.main.sync {
                    if let r = result {
                        print(r.menu)

                        self.menu = r
                    
                        if r.menu.count == 0 {
                            self.view.insertSubview(self.noInfoAvailableLabel, belowSubview: self.dateSelector)
                        } else {
                            self.noInfoAvailableLabel.removeFromSuperview()
                            self.menuTable.reloadData()
                        }
                    }
                    self.progressIndicator.isHidden = true
                    self.progressIndicator.stopAnimating()
                }
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.diningHall.meals.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.getMeal(meal: menu.diningHall.meals[section]).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu.diningHall.meals[section].name
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu-item", for: indexPath)
        
        cell.textLabel?.text = menu.getMeal(meal: menu.diningHall.meals[indexPath.section])[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tap() {
        self.dateSelector.dismissCalendar()
    }
    
    func didSelectNewDate(date: Date) {
        self.selectedDate = date
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
        loadToday()

    }
    
    func calendarDidAppear() {
        self.dateSelector.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 360)
        self.menuTable.addGestureRecognizer(gesture)
    }
    
    func calendarDidDisappear() {
        self.dateSelector.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        self.menuTable.removeGestureRecognizer(gesture)
    }
}
