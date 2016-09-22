//
//  RightTableViewCell.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import SDWebImage

class RightTableViewCell: UITableViewCell {

    
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var contentLabel: UILabel!
    
    var dataModel:RightTableViewModel!{
        didSet{
            iconImageView.sd_setImageWithURL(NSURL(string: dataModel.header!))
            titleLabel.text = dataModel?.screen_name
            contentLabel.text = "\(dataModel?.fans_count)"
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
