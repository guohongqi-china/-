//
//  NavigationController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/4.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
   
    
    override class func initialize() {
        
        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
//        navBar.backgroundColor = UIColor.redColor()
        
        // 设置导航栏变得不透明 ， 使得视图的坐标的原点从导航栏下边缘开始，也可以设置背景图片达到这个效果
//        navBar.translucent = false
        
        
        // 设置导航栏背景颜色
//        navBar.barTintColor = UIColor.redColor()
        
    }
    
    override func viewDidLoad() {
        
//navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
    
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {

        
        
    if childViewControllers.count > 0{
    
        let bt = UIButton(type: UIButtonType.Custom)
        bt.setTitle("返回", forState: UIControlState.Normal)
        bt.titleLabel?.font = UIFont.systemFontOfSize(14)
        bt.setImage(UIImage(named: "navigationButtonReturn"), forState: UIControlState.Normal)
        bt.setImage(UIImage(named: "navigationButtonReturnClick"), forState: UIControlState.Highlighted)
        bt.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        bt.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        bt.sizeToFit() //下面两句就等于sizeToFite
    
            
//        bt.Size = CGSizeMake(90, 30)
            //让按钮内容左对齐
//        bt.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        bt.addTarget(self, action: #selector(NavigationController.back), forControlEvents: UIControlEvents.TouchUpInside)
            //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: bt)



        }
        
        super.pushViewController(viewController, animated: true)

    }
    func back(){
        popViewControllerAnimated(true)
    }
    
}
