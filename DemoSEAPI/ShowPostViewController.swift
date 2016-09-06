//
//  ShowPostViewController.swift
//  DemoSEAPI
//
//  Created by ashiq on 11/04/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit

class ShowPostViewController: UIViewController {

    var url : String = ""
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let httpurl = NSURL(string: url);
        webView.loadRequest(NSURLRequest(URL: httpurl!))

       
    }

}
