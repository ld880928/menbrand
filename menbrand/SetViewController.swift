//
//  SetViewController.swift
//  menbrand
//
//  Created by 李迪 on 14-9-27.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    @IBOutlet weak var infoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SetTableViewCell") as SetTableViewCell

        switch indexPath.row {
        case 0:
            cell.labelTitle.text = "版权信息"
            break
        case 1:
            cell.labelTitle.text = "分享软件"
            break
        case 2:
            cell.labelTitle.text = "关于我们"
            break
        default :
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var type:String = ""
        switch indexPath.row {
        case 0:
            type = "版权信息"
            break
        case 1:
            type = "分享软件"
            break
        case 2:
            type = "关于我们"
            break
        default :
            break
        }
        
        self.performSegueWithIdentifier("SetDetailSegue", sender: type)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as SetDetailViewController
        controller.type = sender as? String
    }

}
