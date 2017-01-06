//
//  DiningHallContainerViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/4/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class DiningHallContainerViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pageViewContainer: UIView!
    
    var pager: UIPageViewController!
    var pages = [UIViewController]()
    
    var diningHall = DiningHall.Arnold // idk what to do if this is empty for some reason?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pager = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pager.dataSource = self
        pager.delegate = self
        
        self.addChildViewController(pager)
        
        self.pageViewContainer.frame = self.view.frame
        pager.view.frame = CGRect(x: 0, y: 0, width: pageViewContainer.frame.width, height: self.view.frame.height)
        self.pageViewContainer.addSubview(pager.view)
        pager.didMove(toParentViewController: self)
        
        let menuPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTable") as! DiningTableViewController
        menuPage.diningHall = diningHall
        
        let infoPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoView") as! DiningInfoViewController
        infoPage.diningHall = diningHall
        
        pages = [menuPage, infoPage]
        
        if let firstViewController = pages.first {
            pager.setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
       self.title = diningHall.name
        
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 1 {
            pager.setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)

        } else {
            pager.setViewControllers([pages[0]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < pages.count {
            return pages[nextIndex]
        }
    
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else {
            return nil
        }
        
        let previous = currentIndex - 1
        
        if previous >= 0 {
            return pages[previous]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        if self.segmentControl.selectedSegmentIndex == 0 {
            self.segmentControl.selectedSegmentIndex = 1
        } else {
            self.segmentControl.selectedSegmentIndex = 0
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pager.viewControllers?.first else {
            return 0
        }
        
        guard let firstViewControllerIndex = pages.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
}
