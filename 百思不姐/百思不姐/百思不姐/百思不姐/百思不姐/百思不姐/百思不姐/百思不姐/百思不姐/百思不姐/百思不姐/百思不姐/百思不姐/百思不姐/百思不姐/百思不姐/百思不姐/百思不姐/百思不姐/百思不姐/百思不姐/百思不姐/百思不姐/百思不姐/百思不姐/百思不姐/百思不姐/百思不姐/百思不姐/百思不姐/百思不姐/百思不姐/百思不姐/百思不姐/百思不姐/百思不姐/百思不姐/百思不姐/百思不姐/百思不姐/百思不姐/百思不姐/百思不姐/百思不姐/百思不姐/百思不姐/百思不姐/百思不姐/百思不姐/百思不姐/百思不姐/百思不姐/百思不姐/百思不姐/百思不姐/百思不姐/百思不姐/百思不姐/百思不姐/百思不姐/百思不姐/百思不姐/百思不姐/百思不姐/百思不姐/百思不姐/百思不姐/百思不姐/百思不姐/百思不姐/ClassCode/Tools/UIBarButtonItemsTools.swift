//
//  UIBarButtonItemsTools.swift
//  百思不得姐
//
//  Created by MacBook on 16/7/4.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    public class func CreateBarButtonItem(title:String , imageStr : String , heightImage:String ,target:AnyObject, buttonAction:Selector) -> UIBarButtonItem{
        let bt = UIButton()
        bt.setTitle(title, forState: UIControlState.Normal)
         bt.setBackgroundImage(UIImage(named: imageStr), forState: UIControlState.Normal)
        bt.setBackgroundImage(UIImage(named: heightImage), forState: UIControlState.Highlighted)
        bt.Size = (bt.currentBackgroundImage?.size)!
        bt.addTarget(target, action: buttonAction, forControlEvents: UIControlEvents.TouchUpInside)
        return UIBarButtonItem(customView: bt)

    }
    
}



