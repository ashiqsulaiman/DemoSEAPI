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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}