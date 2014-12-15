//
//  NewsDetailViewController.swift
//  menbrand
//
//  Created by colin on 14-9-28.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var data : NSDictionary?
    
    @IBOutlet weak var infoWebView: UIWebView!
    
    @IBAction func back(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let templatePath = NSBundle.mainBundle().pathForResource("template", ofType: "html")
        
        var htmlString = String(contentsOfFile: templatePath!, encoding: NSUTF8StringEncoding, error: nil)
        
        if let data_ = self.data {
            
            let titleString = data_.objectForKey("node_title") as? String
            htmlString = htmlString?.stringByReplacingOccurrencesOfString("titleString", withString: titleString!, options: NSStringCompareOptions.allZeros, range: nil)
            
            let introtextString = data_.objectForKey("body") as? String
            htmlString = htmlString?.stringByReplacingOccurrencesOfString("introtextString", withString: introtextString!, options: NSStringCompareOptions.allZeros, range: nil)
        }
        
        self.infoWebView.loadHTMLString(htmlString!, baseURL: NSURL(string: "http://menbrand.demo.evebit.com"))
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
