//
//  CalendarView.swift
//  DateView
//
//  Created by Kaitlyn Landmesser on 1/11/17.
//  Copyright © 2017 Industrial Scientific. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate {
    func didSelectDate(date: Date)
}

class CalendarView: UIView, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var delegate: CalendarViewDelegate?
    var pageView: UIPageViewController!
    var selectedDate = Date()
    
    var centerViewController: MonthViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.min])
        pageView.delegate = self
        pageView.dataSource = self
        pageView.view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 340)
                
        self.addSubview(pageView.view)
    }
    
    func setCenter() {
        centerViewController = newViewController(date: selectedDate)

        pageView.setViewControllers([centerViewController],
                                        direction: .forward,
                                        animated: true,
                                        completion: nil)
        
        self.reloadInputViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newViewController(date: Date) -> MonthViewController {
        let new = MonthViewController()
        new.firstDayOfMonth = date.startOfMonth()
        new.selectedDay = selectedDate
        new.delegate = self
        return new
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let v = viewController as! MonthViewController
        print("\(v.firstDayOfMonth) and next \(v.firstDayOfMonth.nextMonth())")
        return newViewController(date: v.firstDayOfMonth.nextMonth())
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let v = viewController as! MonthViewController
        print("\(v.firstDayOfMonth) and prev \(v.firstDayOfMonth.previousMonth())")

        return newViewController(date: v.firstDayOfMonth.previousMonth())
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finished animating")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .min
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension CalendarView: MonthViewControllerDelegate {
    func didSelectDate(date: Date) {
        selectedDate = date
        self.delegate?.didSelectDate(date: date)
    }
}
