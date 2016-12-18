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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let PRTStatus = getPRTStatus()
        statusLabel.text = String(describing: PRTStatus?.status)
        messageLabel.text = PRTStatus?.message
        // Do any additional setup after loading the view from its nib.
    }
    
    func getPRTStatus() -> PRTStatus? {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath: String = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        print(urlPath)
        
        guard let url = URL(string: urlPath) else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            print("HTML : \(jsonData)")
            
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                guard let status = json["status"] as? String else {
                    return nil
                }
                guard let message =  json["message"] as? String else {
                    return nil
                }
                guard let time = json["timestamp"] as? String else {
                    return nil
                }
                return PRTStatus(status: Int(status)!, message: message, time: Int(time)!)
            }
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
        
        return nil
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
