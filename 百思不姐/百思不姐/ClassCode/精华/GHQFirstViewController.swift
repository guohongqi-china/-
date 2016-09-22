//
//  GHQFirstViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/4.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class GHQFirstViewController: UIViewController {
    
    override func viewDidLoad() {
        setUpNav()
        setUpTitlesView()
        setUpChildControllers()
        setUpScrollView()

    }
    /**
     *  添加子控制器
     */
    func setUpChildControllers(){
        //初始化子控制器并添加
        //全部
        let allControl2 = WordTableViewController()
        allControl2.title = "全部"
        allControl2.controlType = WordTableViewControllerType.WordTableViewControllerAll
        
        //视屏
        let allControl3 = WordTableViewController()
        allControl3.title = "视屏"
        allControl3.controlType = WordTableViewControllerType.WordTableViewControllerVideo
        
        //声音
        let allControl4 = WordTableViewController()
        allControl4.title = "声音"
        allControl4.controlType = WordTableViewControllerType.WordTableViewControllerVoice

        //图片
        let allControl5 = WordTableViewController()
        allControl5.title = "图片"
        allControl5.controlType = WordTableViewControllerType.WordTableViewControllerPicture
        
        //段子
        let allControl1 = WordTableViewController()
        allControl1.title = "段子"
        allControl1.controlType = WordTableViewControllerType.WordTableViewControllerWord
        

        
        addChildViewController(allControl2)
        addChildViewController(allControl3)
        addChildViewController(allControl4)
        addChildViewController(allControl5)
        addChildViewController(allControl1)

        
    }
    
  
    
    /**
     *  懒加载
     */
    lazy var scr:UIScrollView = {
        let  scr = UIScrollView()
        scr.backgroundColor = UIColor.greenColor()
        scr.frame = self.view.bounds
        scr.contentSize = CGSizeMake(CGFloat(self.childViewControllers.count) * UIView.kScreenWidth(), 0)
        scr.pagingEnabled = true
        scr.backgroundColor = UIColor.grayColor()
        scr.delegate = self
        return scr
    }()
    /**
     *  设置底部的ScrollView
     */
    func setUpScrollView(){
        //不需要自动调整内边距
        automaticallyAdjustsScrollViewInsets = false
        view.insertSubview(scr, atIndex: 0)
        scr.setContentOffset(CGPointMake(0.1, 0), animated: true)
    }
    /**
     *  懒加载view
     */
    lazy var tV:UIView = {
        let tV = UIView()
        //设置背景色半透明的2种方法
        tV.backgroundColor = UIColor.RGBColor(220, green: 220, blue: 220, alpha: 1).colorWithAlphaComponent(0.5)
        //tV.backgroundColor = UIColor.RGBColor(1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        tV.width = UIView.kScreenWidth()
        tV.y = 64
        tV.height = 35
        return tV
    }()
    
    /**
     *  设置顶部标签视图
     */
    func setUpTitlesView(){
        
        view.addSubview(tV)
     
        let arr : [String]  = ["全部全部","视频","声音","图片","段子"]
        let count : Int = arr.count
        let btW: CGFloat = UIView.kScreenWidth() / CGFloat(count)
        //设置子标签
        for(var i = 0 ;i < count ; i += 1 ){
            let bt = UIButton()
            bt.height = tV.height
            bt.width = btW
            bt.y = 0
            bt.x = CGFloat(i) * btW
            bt.titleLabel?.font = UIFont.systemFontOfSize(14);
            bt.setTitle(arr[i], forState: UIControlState.Normal)
            //当我们给button设置文字的时候，titleLabel并不会立刻被设置文字，所以就没有尺寸，这时我们需要强制布局一下，让titlelabel有尺寸，这样，当第一次加载视图的时候redView,就会显示出来（如果不强制布局，titlelabel就没有宽度，redView是根据button的titlelabel来设定宽度的，自然也没有宽度）
            bt.tag = 1000 + i
            bt.layoutIfNeeded()
            bt.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            bt.setTitleColor(UIColor.redColor(), forState: UIControlState.Disabled)
            bt.addTarget(self, action: #selector(GHQFirstViewController.titleAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            tV.addSubview(bt)
            if i == 0{
                //titleAction(bt)
                bt.enabled = false
                button = bt
                self.redView.width = (bt.titleLabel?.width)!
                self.redView.centerX = bt.centerX
            }
            
        }
        //底部红色view
        tV.addSubview(redView)
        redView.y = 33
        
    }
    /**
     *  懒加载
     */
    lazy var redView:UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.redColor()
        vw.height = 2;
        return vw
    }()
    
    var button:UIButton?
    func titleAction(sender:UIButton){
        /**
         * 在这里注意：按钮的seleted这种状态也可以，使用disabled来实现，并且使用disabled，之后，我们一但，选中某个按钮之后，
         * 如果我们再选中它，这时它的点击事件就不会再执行了
         */
            sender.enabled = false  //当前选中的按钮不会再被触发事件
            button?.enabled = true  //没有选中的按钮可以触发事件
            button = sender
  
        UIView.animateWithDuration(0.2) { () -> Void in
            self.redView.width = (sender.titleLabel?.width)!
            self.redView.centerX = sender.centerX
        }
       
        scr.setContentOffset(CGPointMake((CGFloat)((sender.tag - 1000))  * UIView.kScreenWidth(), 0), animated: true)
    }
    
    
    /**
     *  设置导航栏属性
     */
    func setUpNav(){
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.CreateBarButtonItem("", imageStr: "MainTagSubIcon", heightImage: "MainTagSubIconClick", target: self, buttonAction: #selector(GHQFirstViewController.buttonAction))
        view.backgroundColor = UIColor.grayColor()

    }
    
    func buttonAction(){
        print("fsdaf")
    }

}
extension GHQFirstViewController:UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //当前索引
        print(scrollView.contentOffset.x)
        print(UIView.kScreenWidth())
        let index = NSInteger(scrollView.contentOffset.x / UIView.kScreenWidth())
        //取出子控制器
        let vc = self.childViewControllers[index] as! UITableViewController
        print(self.childViewControllers)
        print(scrollView)
        vc.view.x = CGFloat(index) * UIView.kScreenWidth()
        vc.view.y = 0
        vc.view.height = UIView.kScreenHeight()
        vc.view.width = UIView.kScreenWidth()
        
        //设置tableView的内边距
        let botton = self.tabBarController?.tabBar.height
        let top = CGRectGetMaxY(self.tV.frame)
        vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, botton!, 0)
        //设置滚动条的内边距
        vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset
        scrollView.addSubview(vc.view)
   
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        //点击按钮
        let index = NSInteger(scrollView.contentOffset.x / UIView.kScreenWidth())
        let bt = self.tV.viewWithTag(1000 + index) as! UIButton
        
        if self.redView.centerX != bt.centerX {
            titleAction(bt)
        }
        
    }
}
