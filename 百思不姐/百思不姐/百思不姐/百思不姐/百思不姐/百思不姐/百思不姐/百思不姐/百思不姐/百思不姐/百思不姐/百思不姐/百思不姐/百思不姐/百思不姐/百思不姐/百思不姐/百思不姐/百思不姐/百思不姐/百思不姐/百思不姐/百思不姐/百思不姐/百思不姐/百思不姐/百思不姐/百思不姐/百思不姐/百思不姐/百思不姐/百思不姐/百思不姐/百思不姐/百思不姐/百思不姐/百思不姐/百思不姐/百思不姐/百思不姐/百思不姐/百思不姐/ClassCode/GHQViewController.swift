//
//  GHQViewController.swift
//  百思不得姐
//
//  Created by MacBook on 16/6/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class GHQViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(GHQTabBar(), forKey: "tabBar")

        setAppearance()
        //初始化UI
        setUpUI()
        
    }
    private func setAppearance(){
       tabBar.tintColor = UIColor.darkGrayColor()
//        UINavigationBar.appearance()
//        let dic = [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.grayColor()]
//        let dic1 = [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName:UIColor.darkGrayColor()]
//        let items = UITabBarItem.appearance()
//        items.setTitleTextAttributes(dic, forState: UIControlState.Normal)
//        items.setTitleTextAttributes(dic1, forState: UIControlState.Selected)

    }
    
     private func setUpUI(){
        
        createControl("GHQFirstViewController", title: "精华", image: "tabBar_essence_icon", seletedImage: "tabBar_essence_click_icon")
        createControl("GHQSecondViewController", title: "新帖", image: "tabBar_new_icon", seletedImage: "tabBar_new_click_icon")
        createControl("GHQThirdViewController", title: "关注", image: "tabBar_friendTrends_icon", seletedImage: "tabBar_friendTrends_click_icon")
        createControl("GHQFourViewController", title: "我", image: "tabBar_me_icon", seletedImage: "tabBar_me_click_icon")
    
    }
    private func createControl(controller:String , title:String, image:String, seletedImage:String){
        
        /*
        * 在swift中如果我们想要通过一个 类来创建一个对象，这个类的名称应该包含 命名空间的
        */
        // 1、动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 2、当我们使用字符串获得某个类的时候，系统要知道他是在哪个命名空间里进行的，所以此处我们要在类名前加个命名空间名字
        let cer:AnyClass? = NSClassFromString(ns + "." + controller)//将字符串转换成类
        
        // 3、通过类来创建对象
        let viewController = cer as! UIViewController.Type//将anyclass转化成指定的类型
        let vc = viewController.init()//指定类型之后，我们就可以创建对象了
        
        //1。设置首页对应的数据
        vc.title = title
        vc.tabBarItem.image = UIImage(named:image)
        vc.tabBarItem.selectedImage = UIImage(named: seletedImage)
        
        //2.给首页包装一个导航控制器
        let navigationController = UINavigationController()
        navigationController.addChildViewController(vc)
        
        
        //3.将导航控制设置为当前视图的根控制器
        addChildViewController(navigationController)


        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
