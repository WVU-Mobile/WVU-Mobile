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
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds the "Show More" button
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
        } else {
            preferredContentSize = maxSize
        }
    }
    
    @IBAction func openApp(_ sender: Any) {
        let url: URL? = URL(string: "WVU-Mobile:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl, completionHandler: nil)
        }
    }
    
    func getPRTStatus(completion: (PRT?) -> Void) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath: String = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        
        guard let url = URL(string: urlPath) else {
            completion(nil)
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            
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
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        DispatchQueue.global().async {
            self.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.statusLabel.text = prt.status.overall
                        self.messageLabel.text = prt.message
                        self.time.text = "Reported \(prt.time.timeAgo)."
                        self.icon.image = prt.status.image.withRenderingMode(.alwaysTemplate)
                        self.icon.tintColor = UIColor(red: 0/255, green: 8/255, blue: 45/255, alpha: 0.5) /* #00082d */
                    }
                }
            })
        }
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
}
