//
//  LoginRegistViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class LoginRegistViewController: UIViewController {

    @IBOutlet var phoneNumberTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTextColor()

    }

    /**
     * 设置手机号占位符颜色
     */
    func setUPTextColor(){
    //设置账号输入框占位符颜色
    phoneNumberTextField.attributedPlaceholder = byStringGetPlaceHolder("请输入手机号")
    //设置密码输入框占位符颜色
    passwordTextField.attributedPlaceholder = byStringGetPlaceHolder("请输入密码？")

    }
    
    //给定6个字符长度的字符串，返回带有色彩的字符
    private func byStringGetPlaceHolder(placeHolder:String) -> NSMutableAttributedString{
        let placeHolder =  NSMutableAttributedString(string: placeHolder)
        //从0位置起，取一个字符长度设置成白色
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.cyanColor()], range: NSMakeRange(0, 1))
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.blueColor()], range: NSMakeRange(1, 1))
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.yellowColor()], range: NSMakeRange(2, 1))
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.greenColor()], range: NSMakeRange(3, 1))
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.purpleColor()], range: NSMakeRange(4, 1))
        placeHolder.setAttributes([NSForegroundColorAttributeName:UIColor.redColor()], range: NSMakeRange(5, 1))
            return placeHolder
    }
    
    
    /**
     * 注册按钮点击事件
     */
    @IBAction func registButtonAction(sender: UIButton) {
        
    }
    /**
     * X号按钮点击事件，模态退出
     */
    @IBAction func backAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /**
     * 当前状态栏显示的颜色,lightContent是将状态栏设置成白色
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    /**
     * 内存警告方法
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
