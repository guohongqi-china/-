//
//  SendPublishViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/8/12.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import pop
class SendPublishViewController: UIViewController {

   var blockOC:((title:String) -> ())?
    lazy var imageView : UIImageView = {
        let IV = UIImageView(image:UIImage(named: "app_slogan"))
//        IV.image = UIImage(named: "app_slogan")
        
        //尺寸设置
        IV.centerX = UIView.kScreenWidth() / 2
        IV.y = UIView.kScreenHeight() * 0.2 - UIView.kScreenHeight() / 2
        return IV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          setUpUI()
        self.view.addSubview(imageView)

    }
    
    //*布局子空间*/
    func setUpUI(){
    self.view.userInteractionEnabled = false
        //图片标题数组
        let titleArr : [String] = ["发视频", "发图片", "发段子", "发声音", "审帖", "离线下载"]
        let imageArr : [String] = ["publish-video", "publish-picture", "publish-text", "publish-audio", "publish-review", "publish-offline"]
        //按钮布局
        let BTW : CGFloat = 72
        let BTH : CGFloat = BTW + 30
        let Space = 20
        let masCol = 3
        let StarY = UIView.kScreenHeight() / 2 - BTH
        let spaceX = (UIView.kScreenWidth() - BTW * CGFloat(masCol) - 2 * CGFloat(Space)) / 2
        
        ///////////////////////////////////////////////////////////////////////////
        //遍历创建button，并且设置属性
        for index in 0...titleArr.count - 1 {
            
            let publishBT = LoginStyleButton()
            self.view.addSubview(publishBT)

            //属性设置
            publishBT.setTitleColor(UIColor.RGBColor(150, green: 150, blue: 150, alpha: 1), forState: UIControlState.Normal)
            publishBT.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
            publishBT.tag = 1000 + index
            publishBT.contentMode = UIViewContentMode.Center
            
            //设置内容
            publishBT.titleLabel?.font = UIFont.systemFontOfSize(14)
            publishBT.setTitle(titleArr[index], forState: UIControlState.Normal)
            publishBT.setImage(UIImage(named: imageArr[index]), forState: UIControlState.Normal)
            
            //尺寸设置
            //publishBT.width = BTW
            //publishBT.height = BTH
            //publishBT.y = StarY + CGFloat(row) * BTH
            //publishBT.x = CGFloat(Space) + CGFloat(col) * BTW + CGFloat(col) * spaceX
            let row : NSInteger = index / NSInteger(masCol) //行号
            let col : NSInteger = index %  NSInteger(masCol)//列号
            /**  1、九宫格布局方法
             *  按钮的y值,等于屏幕高的一半减去按钮的高度。加按钮的高度乘以按钮坐在的行号
             *  按钮的之间的间距值，屏幕的宽度减去左间距乘以2，在减总列数乘以按钮的宽度，除以总列数减1
             *  按钮的x值，为按钮坐在列数*（按钮宽度 + 按钮间间距） + 左间距
             */

            
            let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            animation.fromValue = NSValue(CGRect:CGRectMake(CGFloat(Space) + CGFloat(col) * BTW + CGFloat(col) * spaceX, StarY + CGFloat(row) * BTH - UIView.kScreenHeight(), BTW, BTH))
            animation.toValue = NSValue(CGRect: CGRectMake(CGFloat(Space) + CGFloat(col) * BTW + CGFloat(col) * spaceX, StarY + CGFloat(row) * BTH, BTW, BTH))
            animation.springBounciness = 10//设置弹性效果的尺度
            animation.springSpeed = 10//设置动画的速度
            animation.beginTime = CACurrentMediaTime() + 0.1 * Double(index)
            publishBT.pop_addAnimation(animation, forKey: nil)
            
        }
    ///////////////////////////////////////////////////////////////////////////
        //**imageview做动画*/
        let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        animation.fromValue = NSValue(CGPoint: CGPointMake(UIView.kScreenWidth() / 2, UIView.kScreenHeight() * 0.2 - UIView.kScreenHeight() / 2))
        animation.toValue = NSValue(CGPoint: CGPointMake(UIView.kScreenWidth() / 2, UIView.kScreenHeight() * 0.2 ))
        animation.springBounciness = 10//设置弹性效果的尺度
        animation.springSpeed = 10//设置动画的速度
        animation.beginTime = CACurrentMediaTime() + 0.6
        imageView.pop_addAnimation(animation, forKey: nil)
        
     
        animation.completionBlock = {(animationll:POPAnimation!, finshed : Bool) in
            self.view.userInteractionEnabled = true
        }

    }
    /**取消按钮*/
    @IBAction func sender(sender: UIButton) {
        self.view.userInteractionEnabled = false
        for index in 2...7 {
            let BT = self.view.subviews[index]
            let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            animation.fromValue = NSValue(CGPoint: CGPointMake(BT.centerX, BT.centerY))
            animation.toValue = NSValue(CGPoint: CGPointMake(BT.centerX, UIView.kScreenHeight() * 0.2 + UIView.kScreenHeight()))
            animation.springBounciness = 10//设置弹性效果的尺度
            animation.springSpeed = 10//设置动画的速度
            animation.beginTime = CACurrentMediaTime() + 0.1 * Double(index)
            BT.pop_addAnimation(animation, forKey: nil)
        }
        ///////////////////////////////////////////////////////////
        /**imageview执行动画*/
        let VC = self.view.subviews[8]
        let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        animation.fromValue = NSValue(CGPoint: CGPointMake(VC.centerX, VC.centerY))
        animation.toValue = NSValue(CGPoint: CGPointMake(VC.centerX, UIView.kScreenHeight() * 0.2 + UIView.kScreenHeight()))
        animation.springBounciness = 10//设置弹性效果的尺度
        animation.springSpeed = 10//设置动画的速度
        animation.beginTime = CACurrentMediaTime() + 0
        VC.pop_addAnimation(animation, forKey: nil)

        //**动画执行完毕*/
        animation.completionBlock = {(animationll:POPAnimation!, finshed : Bool) in
            self.view.userInteractionEnabled = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

   
}
