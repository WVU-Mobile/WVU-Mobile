//
//  TodayViewController.swift
//  PRT Status Widget
//
//  Created by Richard Deal on 12/15/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    
    let wvuMobileURL = NSURL(string: "WVU-Mobile://")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            self.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.statusLabel.text = prt.status.overall
                        self.messageLabel.text = prt.message
                        self.time.text = "\(prt.time.prettyPrint) ~ \(prt.time.timeAgo)"
                        print("is this hit")
                    }
                }
            })
        }
    }
    
    func open(_ wvuMobileURL: URL, completionHandler: ((Bool) -> Void)? = nil) {
        print("You tapped the widget.")
    }
    
    func getPRTStatus(completion: (PRT?) -> Void) {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath: String = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        print(urlPath)
        
        guard let url = URL(string: urlPath) else {
            completion(nil)
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            print("HTML : \(jsonData)")
            
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                guard let status = json["status"] as? String else {
                    completion(nil)
                    return
                }
                guard let message =  json["message"] as? String else {
                    completion(nil)
                    return
                }
                guard let time = json["timestamp"] as? String else {
                    completion(nil)
                    return
                }
                completion(PRT(status: Int(status)!, message: message, time: Int(time)!))
            }
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
        
        completion(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
