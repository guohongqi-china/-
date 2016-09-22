//
//  LeftTableViewCell.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit


class LeftTableViewCell: UITableViewCell {
    @IBOutlet var redView: UIView!
    
    
//    @IBOutlet var redView: UIView!
    var model:FocusModel?{
        didSet{
            textLabel?.text = model?.name
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.y = 2;
        textLabel?.height = contentView.height - 4
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.redView.hidden = !selected
        textLabel?.textColor = selected ? UIColor.RGBColor(219, green: 21, blue: 26, alpha: 1) : UIColor.RGBColor(78, green: 78, blue: 78, alpha: 1)
        backgroundColor = selected ? UIColor.whiteColor() : UIColor.RGBColor(244, green: 244, blue: 244, alpha: 1)
        

    }
    
}
