//
//  BrandSliderShowTableViewCell.swift
//  menbrand
//
//  Created by colin on 14-9-28.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class BrandSliderShowTableViewCell: UITableViewCell {

    @IBOutlet weak var infoScrollView: UIScrollView!
    
    var blockProperty : ((NSDictionary) -> Void)?
    var data:NSArray?
    
    func setData(data:NSArray) {
        for view in self.infoScrollView.subviews {
            view.removeFromSuperview()
        }
        
        self.data = data
        
        let width = self.infoScrollView.bounds.size.width
        
        for var i=0;i<data.count;i++ {
            
            let item = data.objectAtIndex(i) as NSDictionary
            
            let imageView_ = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, self.infoScrollView.bounds.height))
            
            let images = item.objectForKey("field_images") as NSArray
            
            let imageURLString = images.objectAtIndex(0) as String
            
            imageView_.sd_setImageWithURL(NSURL(string: imageURLString))
            
            self.infoScrollView.addSubview(imageView_)
            
            let tapGes = UITapGestureRecognizer(target: self, action:"imageTap:")
            imageView_.addGestureRecognizer(tapGes)
            imageView_.userInteractionEnabled = true
            imageView_.tag = i
            
        }
        
        self.infoScrollView.contentSize = CGSizeMake(width * CGFloat(data.count),self.infoScrollView.bounds.size.height)
    }
    
    func imageTap(ges:UITapGestureRecognizer) -> Void {
        
        if let data_ = self.data {
            let item = data_.objectAtIndex(ges.view!.tag) as NSDictionary

            if let callback = self.blockProperty {
                callback(item)
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
