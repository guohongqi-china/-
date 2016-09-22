//
//  PushGuideView.swift
//  百思不姐
//
//  Created by MacBook on 16/7/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class PushGuideView: UIViewController {
    
      
    /*
     * 导航页消失按钮
     */
    @IBAction func dismissAction(sender: UIButton) {

        UIView.animateWithDuration(1, animations: { () -> Void in

            self.view.alpha = 0
            }) { (result:Bool) -> Void in
                //动画执行完毕视图切换
                self.removeFromParentViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = GHQViewController()
                self.view.removeFromSuperview()
        }

    }
    class func judgeCurrentVersion() -> Bool {
        let key = "CFBundleShortVersionString"
        //通过key获取当前软件的版本号
        let currentVersion  = NSBundle.mainBundle().infoDictionary![key] as? String
        //获取沙盒中存储的版本号
        let sanboxVersion  = NSUserDefaults.standardUserDefaults().stringForKey(key)
        //当本地沙盒版本号与当前版本号不一样时，就代表是新的版本，所以，我们要存储一次当前版本
        if sanboxVersion != sanboxVersion {
            NSUserDefaults.standardUserDefaults().setValue(currentVersion, forKey: key)
            return false
        }else{
            return true
        }
        
    }

    override func awakeFromNib() {

    }

}
