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
        
    var url = ""
    var article = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView(frame: self.view.frame)
        webView.loadRequest(URLRequest(url: URL(string: url)!))

        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebViewController.open))
        navigationItem.rightBarButtonItem = shareButton
            
        self.view.addSubview(webView)
    }
        
    func open () {
        displayShareSheet(content: "[WVU Mobile] \(article)")
    }
    
    func displayShareSheet(content: String) {
        let activityViewController = UIActivityViewController(activityItems: [content, URL(string: url)!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
}
