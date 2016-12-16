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
    
    @IBOutlet weak var statusBox: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBox.text = getPRTSTatus()
        // Do any additional setup after loading the view from its nib.
    }
    
    func getPRTSTatus() -> String? {
        
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
                return json["message"] as? String
            }
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
        
        return "Error"
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
