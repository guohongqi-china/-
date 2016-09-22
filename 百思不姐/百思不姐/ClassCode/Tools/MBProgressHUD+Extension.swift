//
//  MBProgressHUD+Extension.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension MBProgressHUD{
    
    //pragma mark 显示一些信息
    class func showMessage(content:String, toView:UIView) -> MBProgressHUD {
       let hud  = MBProgressHUD.showHUDAddedTo(toView, animated: true)
        hud.labelText = content
        hud.removeFromSuperViewOnHide = true
        hud.dimBackground = true
        return hud
    }
 
   
    class func hideHUDForView(toView:UIView) {
        self.hideHUDForView(toView, animated: true)
    }
    
    //带有蒙版的提示，一秒后消失
    class func showSuccess(content:String, toView:UIView) -> MBProgressHUD {
        let hud  = MBProgressHUD.showHUDAddedTo(toView, animated: true)
        hud.labelText = content
        hud.removeFromSuperViewOnHide = true
        hud.dimBackground = true
        hud.hide(true, afterDelay: 1.0)
        return hud
    }

}



