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
    
    var menu: Menu?
    
    var dateSelector: DateSelectorViewController?
    var gesture: UITapGestureRecognizer?
    
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
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(DiningTableViewController.tap))
        
        noInfoAvailableLabel = UILabel(frame: view.frame)
        noInfoAvailableLabel.text = "No menu info is available."
        noInfoAvailableLabel.backgroundColor = UIColor.white
        noInfoAvailableLabel.textAlignment = .center
        
        dateSelector = DateSelectorViewController(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        dateSelector?.delegate = self
        
        guard let dateSelector = dateSelector else { return }
        view.addSubview(dateSelector)
        
        progressIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 50))
        progressIndicator.color = UIColor.black
        progressIndicator.startAnimating()
        view.addSubview(progressIndicator)
        
        loadToday()
    }
    
    func loadToday() {
        DispatchQueue.global().async {
            guard let menu = self.menu else { return }
            
            MenuRequest.getMenu(on: self.selectedDate, at: menu.diningHall, completion: { result in
                DispatchQueue.main.sync {
                    guard let dateSelector = self.dateSelector else { return }

                    if let menu = result {
                        self.menu = menu
                    
                        if menu.empty {
                            self.view.insertSubview(self.noInfoAvailableLabel, belowSubview: dateSelector)
                        } else {
                            self.noInfoAvailableLabel.removeFromSuperview()
                            self.menuTable.reloadData()
                        }
                    } else {
                        self.view.insertSubview(self.noInfoAvailableLabel, belowSubview: dateSelector)
                    }
                    self.progressIndicator.isHidden = true
                    self.progressIndicator.stopAnimating()
                }
            })
        }
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        if let m = menu {
            return m.diningHall.meals.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let m = menu {
            return m.getMeal(meal: m.diningHall.meals[section]).count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu?.diningHall.meals[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu-item", for: indexPath)
        
        if let meal = menu?.diningHall.meals[indexPath.section] {
            cell.textLabel?.text = menu?.getMeal(meal: meal)[indexPath.row]
        }
        
        return cell
    }
    
    @objc func tap() {
        dateSelector?.dismissCalendar()
    }
    
    func didSelectNewDate(date: Date) {
        selectedDate = date
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
        loadToday()
    }
    
    func calendarDidAppear() {
        guard let gesture = gesture else { return }

        dateSelector?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 360)
        menuTable.addGestureRecognizer(gesture)
    }
    
    func calendarDidDisappear() {
        guard let gesture = gesture else { return }

        dateSelector?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        menuTable.removeGestureRecognizer(gesture)
    }
    
}
