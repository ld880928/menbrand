//
//  SetDetailViewController.swift
//  menbrand
//
//  Created by colin on 14-9-29.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class SetDetailViewController: UIViewController {

    @IBOutlet weak var infoWebView: UIWebView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    var type: String?
    
    @IBAction func back(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var urlString = ""
        
        if self.type == "版权信息"
        {
            urlString = "http://menbrand.demo.evebit.com/api/systems/?nid=74"
        }
        else if self.type == "分享软件"
        {
            urlString = "http://menbrand.demo.evebit.com/api/systems/?nid=75"
        }
        else if self.type == "关于我们"
        {
            urlString = "http://menbrand.demo.evebit.com/api/systems/?nid=73"
        }
        
        self.labelTitle.text = self.type
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (NSData data, NSURLResponse res, NSError error) -> Void in
            
            let data___: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSArray
            
            let dataDic = data___?.objectAtIndex(0) as? NSDictionary
            
            let templatePath = NSBundle.mainBundle().pathForResource("template1", ofType: "html")
            
            var htmlString = String(contentsOfFile: templatePath!, encoding: NSUTF8StringEncoding, error: nil)
            
            if let data_ = dataDic {
                let introtextString = data_.objectForKey("body") as? String
                htmlString = htmlString?.stringByReplacingOccurrencesOfString("introtextString", withString: introtextString!, options: NSStringCompareOptions.allZeros, range: nil)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                self.infoWebView.loadHTMLString(htmlString!, baseURL: NSURL(string: "http://menbrand.demo.evebit.com"))
                
            })
        })
        
        
        task.resume()
        
        
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
