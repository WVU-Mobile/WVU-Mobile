//
//  WebViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/28/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
        var webView: UIWebView!
        
        var url = "https://www.indsci.com/privacy-statement/"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            webView = UIWebView(frame: self.view.frame)
            webView.loadRequest(URLRequest(url: URL(string: url)!))

            let shareButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebViewController.open))
            navigationItem.rightBarButtonItem = shareButton
            
            self.view.addSubview(webView)
        }
        
        func open () {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let popoverController = alert.popoverPresentationController
            popoverController?.barButtonItem = navigationItem.rightBarButtonItem
            
            let open = UIAlertAction(title: "Open in Safari", style: .destructive) { action in
                UIApplication.shared.openURL(URL(string: self.url)!)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(cancel)
            alert.addAction(open)
            
            navigationController?.present(alert, animated: true, completion: nil)
        }
}
