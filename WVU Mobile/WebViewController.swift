//
//  WebViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/28/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

struct WebViewData {
    var urlString: String
    var article: String?
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    init(urlString: String, article: String? = nil) {
        self.urlString = urlString
        self.article = article
    }
    
}

class WebViewController: UIViewController {
    var webView: UIWebView?
    
    var data: WebViewData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: self.view.frame)
        
        if let url = data?.url {
            webView.loadRequest(URLRequest(url: url) )
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebViewController.open))
        
        self.webView = webView
        view.addSubview(webView)
    }
        
    @objc func open () {
        if let article = data?.article {
            displayShareSheet(content: "[WVU Mobile] \(article)")
        }
    }
    
    func displayShareSheet(content: String) {
        if let url = data?.url {
            let activityViewController = UIActivityViewController(activityItems: [content, url], applicationActivities: nil)
            present(activityViewController, animated: true, completion: {})
        }
    }
    
}
