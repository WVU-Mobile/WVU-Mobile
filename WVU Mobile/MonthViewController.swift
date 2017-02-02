//
//  MonthViewController.swift
//  DateView
//
//  Created by Kaitlyn Landmesser on 1/11/17.
//  Copyright © 2017 Industrial Scientific. All rights reserved.
//

import UIKit

private let genericCell = "generic"
private let todayCell = "today"
private let selectedCell = "selected"
private let otherMonthCell = "otherMonth"

protocol MonthViewControllerDelegate {
    func didSelectDate(date: Date)
}
class MonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var delegate: MonthViewControllerDelegate?
    
    var monthLabel: UILabel!
    var collectionView: UICollectionView!
    
    var firstDayOfMonth: Date!
    var selectedDay: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        monthLabel.text = "\(firstDayOfMonth.headerFormat)"
        monthLabel.textAlignment = .center
        
        view.addSubview(monthLabel)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.bounds.width - 110)/7, height: (view.bounds.width - 110)/7)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 230), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: genericCell)
        collectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: todayCell)
        collectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: selectedCell)
        collectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: otherMonthCell)

        collectionView.isOpaque = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func getDate(for indexPath: IndexPath) -> Date? {
        if indexPath.section == 0 {
            return nil // it's one of the weekday headers
        }
        
        let cal = Calendar(identifier: .gregorian)

        let dayOffset = cal.component(.weekday, from: firstDayOfMonth) - 1
        let daysInMonth = cal.component(.day, from: firstDayOfMonth.endOfMonth())
        
        let todaysDay = ( (indexPath.section - 1) * 7 ) + (indexPath.row + 1) - dayOffset
        
        if todaysDay > daysInMonth {
            return cal.date(bySetting: .day, value: todaysDay - daysInMonth, of: firstDayOfMonth.nextMonth())
        } else if todaysDay < 1 {
            let lastMonthDate = firstDayOfMonth.previousMonth()
            let daysInLastMonth = cal.component(.day, from: lastMonthDate.endOfMonth())
            
            return cal.date(bySetting: .day, value: todaysDay + daysInLastMonth, of: lastMonthDate)
        }
        
        return cal.date(bySetting: .day, value: todaysDay, of: firstDayOfMonth)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: genericCell, for: indexPath) as! CalendarDayCollectionViewCell
        
        if indexPath.section == 0 {
            let days = ["S","M","T","W","T","F","S"]
            cell.day.text = days[indexPath.row]
            return cell
        }

        if let date = getDate(for: indexPath) {
            if !firstDayOfMonth.sameMonth(date: date) {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherMonthCell, for: indexPath) as! CalendarDayCollectionViewCell
                cell.day.textColor = UIColor.gray
            }
            
            if date.isToday {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCell, for: indexPath) as! CalendarDayCollectionViewCell
                let background = UIView()
                background.layer.cornerRadius = (cell.bounds.width)/2
                background.layer.borderWidth = 1
                background.layer.borderColor = Colors.homeDarkBlue.cgColor
                
                cell.backgroundView = background
            }
            
            if let s = selectedDay {
                if s.sameDay(date: date) {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedCell, for: indexPath) as! CalendarDayCollectionViewCell
                    
                    let background = UIView()
                    background.backgroundColor = Colors.homeYellow
                    background.layer.cornerRadius = (cell.bounds.width)/2
                    
                    cell.backgroundView = background
                    
                    cell.isSelected = false
                }
            }
            
            cell.day.text = date.d
        }
        
        let selectionView = UIView()
        selectionView.backgroundColor = Colors.homeYellow
        selectionView.layer.cornerRadius = (cell.bounds.width)/2
        
        cell.selectedBackgroundView = selectionView
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let date = getDate(for: indexPath) {
            self.delegate?.didSelectDate(date: date)
        }
    }
}
