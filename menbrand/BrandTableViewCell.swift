//
//  BrandTableViewCell.swift
//  menbrand
//
//  Created by 李迪 on 14-9-27.
//  Copyright (c) 2014年 li. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
