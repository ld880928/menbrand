//
//  BrandViewController.swift
//  menbrand
//
//  Created by 李迪 on 14-9-27.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var infoTableView: UITableView!
    var infoData:NSArray?
    var sliderShowDatas:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view.
        self.infoTableView.addHeaderWithCallback { () -> Void in
            //刷新数据
            
            let session = NSURLSession.sharedSession()
            
            let url = NSURL(string: "http://menbrand.demo.evebit.com/api/brand")
            
            let request = NSURLRequest(URL: url!)
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (NSData data, NSURLResponse res, NSError error) -> Void in
                
            self.infoData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray?
                                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let sessionSliderShow = NSURLSession.sharedSession()
                    
                    let requestSliderShow = NSURLRequest(URL: NSURL(string: "http://menbrand.demo.evebit.com/api/slidershow")!)
                    
                    let taskSliderShow = session.dataTaskWithRequest(request, completionHandler: { (NSData data, NSURLResponse res, NSError error) -> Void in
                        
                        self.sliderShowDatas = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray?
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.infoTableView.headerEndRefreshing()
                            self.infoTableView.reloadData()
                        })
                    })
                    
                    taskSliderShow.resume()
                    
                })
            })
            
            task.resume()
            
        }
        
        self.infoTableView.headerBeginRefreshing()
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        }
        
        if var datas = self.infoData {
            return self.infoData!.count
        }
        else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }
        else  {
            return 100.0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("BrandSliderShowTableViewCell") as BrandSliderShowTableViewCell

            cell.blockProperty = {(item :NSDictionary) -> Void in self.performSegueWithIdentifier("BrandDetailSegue", sender: item)}
            
            if let data = self.sliderShowDatas {
                cell.setData(data)
            }
            
            return cell;
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BrandTableViewCell") as BrandTableViewCell
        
        let item = self.infoData!.objectAtIndex(indexPath.row) as NSDictionary
        
        let imageURLStrings = item.objectForKey("field_images") as? NSArray
        
        let imageURLString = imageURLStrings!.objectAtIndex(0) as String
        
        cell.imageViewIcon.sd_setImageWithURL(NSURL(string: imageURLString))
        
        cell.labelPhoneNumber.text = item.objectForKey("field_phone") as? String
        
        cell.labelTitle.text = item.objectForKey("field_company") as? String
        
        cell.labelSubTitle.text = item.objectForKey("field_address") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.infoData!.objectAtIndex(indexPath.row) as NSDictionary
        self.performSegueWithIdentifier("BrandDetailSegue", sender: item)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as BrandDetailViewController
        controller.data = sender as NSDictionary?
    }
    

}
