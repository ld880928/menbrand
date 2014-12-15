//
//  RecommendedViewController.swift
//  menbrand
//
//  Created by 李迪 on 14-9-27.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class RecommendedViewController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!
    var infoData:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true

        self.infoTableView.addHeaderWithCallback { () -> Void in
            //刷新数据
            
            let session = NSURLSession.sharedSession()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://menbrand.demo.evebit.com/api/news?cid=5")!)
            
            request.HTTPMethod = "GET"
            /*
            let mapData = ["cid":"5"]
            
            let postData = NSJSONSerialization.dataWithJSONObject(mapData, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
            
            request.HTTPBody = postData
            */
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (NSData data, NSURLResponse res, NSError error) -> Void in
                
                self.infoData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray?
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.infoTableView.headerEndRefreshing()
                    self.infoTableView.reloadData()
                })
            })
            
            
            task.resume()
            
        }
        
        self.infoTableView.headerBeginRefreshing()
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if var datas = self.infoData {
            return self.infoData!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RecommendedTableViewCell") as RecommendedTableViewCell;
        
        let item = self.infoData!.objectAtIndex(indexPath.row) as NSDictionary
        
        let imageURLStrings = item.objectForKey("field_images") as? NSArray
        
        let imageURLString = imageURLStrings!.objectAtIndex(0) as String
                
        cell.imageViewIcon.sd_setImageWithURL(NSURL(string: imageURLString))
        
        cell.labelTitle.text = item.objectForKey("node_title") as? String
        
        return cell;
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.infoData!.objectAtIndex(indexPath.row) as NSDictionary
        self.performSegueWithIdentifier("RecommendedDetailSegue", sender: item)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as RecommendedDetailViewController
        controller.data = sender as NSDictionary?
    }

}
