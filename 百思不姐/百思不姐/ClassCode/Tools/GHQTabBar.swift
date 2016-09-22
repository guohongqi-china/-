//
//  GHQTabBar.swift
//  百思不得姐
//
//  Created by MacBook on 16/6/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class GHQTabBar: UITabBar {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.greenColor()
        addSubview(publishButton)
       
    }
    func screenWidth()-> CGFloat{
        return UIScreen.mainScreen().bounds.width;
    }
    func screenHeight()-> CGFloat{
        return UIScreen.mainScreen().bounds.height;
    }
    

   lazy var publishButton:UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "tabBar_publish_icon"), forState: UIControlState.Normal)
        bt.setImage(UIImage(named: "tabBar_publish_click_icon"), forState: UIControlState.Selected)
         bt.addTarget(self, action: #selector(GHQTabBar.buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
    return bt
    }()
    
    func buttonAction(){
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(SendPublishViewController(), animated: false, completion: nil)
    }
    
    // 必须重写这个方法, Swift推荐我们要么支持纯代码, 要么支持XIB
    // 这样可以简化代码的复杂度
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        publishButton.center = CGPointMake(screenWidth() / 2,bounds.height / 2)
        print(screenWidth() / 5)
        publishButton.width = screenWidth() / 5
        publishButton.height = bounds.height
//        publishButton.backgroundColor = UIColor.purpleColor()
      
        
        var index:CGFloat = 0
        
        for bt in subviews{
            
            if bt == publishButton || !bt .isKindOfClass(UIControl){
               
                continue
            }
            print(bt)
//            var x:Int = ((index > 1) ? (index + 1): index)
          let x = screenWidth() / 5  * ( index > 1 ? index + 1 : index) as CGFloat
            if index == 0 {
//                bt.backgroundColor = UIColor.yellowColor()
            }else if index == 1{
//                bt.backgroundColor = UIColor.greenColor()

            }else if index == 2{
//                bt.backgroundColor = UIColor.orangeColor()
                
            }else if index == 3{
//                bt.backgroundColor = UIColor.blueColor()
                
            }
            bt.frame = CGRectMake(x, 0, screenWidth() / 5, 48)
            index++;
            print(x)
            
        }
        
//        for var button:UIView in subviews{
//            if (!button.isKindOfClass(UIControl.class) || button == publishButton )contin
//        }

//        for (UIView *button in self.subviews) {
//            if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
//            
//            // 计算按钮的x值
//            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
//            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//            
//            // 增加索引
//            index++;
//        }

        
    }
    
}
