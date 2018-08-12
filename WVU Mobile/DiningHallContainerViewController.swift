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
    
    var pager: UIPageViewController?
    var pages = [UIViewController]()
    
    var diningHall = DiningHall.boreman

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let menuPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTable") as? DiningTableViewController,
              let infoPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoView") as? DiningInfoViewController else { return }
        
        menuPage.menu = Menu(diningHall: diningHall)
        infoPage.diningHall = diningHall
        
        pager = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        
        guard let pager = pager else { return }

        pager.dataSource = self
        pager.delegate = self
        
        pages = [menuPage, infoPage]
        pager.setViewControllers([menuPage], direction: .forward, animated: true, completion: nil)
        pager.didMove(toParentViewController: self)
        
        pager.automaticallyAdjustsScrollViewInsets = true
        pageViewContainer.addSubview(pager.view)

        title = diningHall.name
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 1 {
            pager?.setViewControllers([pages[1]], direction: .forward, animated: true, completion: nil)
        } else {
            pager?.setViewControllers([pages[0]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < pages.count {
            return pages[nextIndex]
        }
    
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else { return nil }
        
        let previous = currentIndex - 1
        
        if previous >= 0 {
            return pages[previous]
        }

        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        segmentControl.selectedSegmentIndex = segmentControl.selectedSegmentIndex == 0 ? 1 : 0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pager?.viewControllers?.first,
              let firstViewControllerIndex = pages.index(of: firstViewController) else { return 0 }
        
        return firstViewControllerIndex
    }
    
}
