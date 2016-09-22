//
//  BDJCommentViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/9/19.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh
class BDJCommentViewController: UIViewController {
    
    /**
     * 属性列表
     */
    /** 工具条底部间距 */
    @IBOutlet var BotInputViewConstraint: NSLayoutConstraint!
    
    @IBOutlet var TableV: UITableView!
    var firstCellH : CGFloat = 0
    var firstModel : WordModel?
    /** 最热评论数组 */
    var hotCArr = [BDJHotCM]()
    /** 最新评论数组  */
    var newCArr = [BDJHotCM]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContro()//控制器设置
        setUpNotification()//通知
        registCell()
        
    }
    
    /**
     * 注册cell，表视图设置
     */
    func registCell(){
        TableV.registerNib(UINib.init(nibName:"WordTableViewCell", bundle: nil), forCellReuseIdentifier: "WordTableViewCell")
        TableV.rowHeight = UITableViewAutomaticDimension
        TableV.estimatedRowHeight = 1000;
        
        /** 下拉加载 */
        TableV.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(BDJCommentViewController.loadNewData))
        TableV.mj_header.beginRefreshing()
        
    }
    
    func loadNewData(){
        
        BDJHotCM.getNewDataFromServer(firstModel!) { (responderObject, latextData, error) in
            self.TableV.mj_header.endRefreshing()
            if error == nil{
                
                if let latextArr = latextData{
                    self.newCArr = latextArr
                }
                
                if let hotArr = responderObject{
                    self.hotCArr = hotArr
                }
                self.TableV.reloadData()
       
            }else{
                
               MBProgressHUD.showSuccess("\(error)", toView: self.view.window!)
            }
        }
                
    }
    
    /**
     * 通知
     */
    func setUpNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BDJCommentViewController.KeyBoardChangFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    /** 监听键盘弹出事件 */
    func KeyBoardChangFrame(note:NSNotification) {
        
        //获取键盘结束时的尺寸
        let keyFrame = note.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        
        //动画时长
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.BotInputViewConstraint.constant = UIView.kScreenHeight() -  keyFrame!.origin.y
            self.view.layoutIfNeeded()
            
        }) { (complement:Bool) in
            
        }
    }
    
    /**
     * 控制器属性设置
     */
    func setUpContro(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "comment_nav_item_share_icon"), style: UIBarButtonItemStyle.Done, target: self, action: #selector(itemAction))
    }
    /** 右按钮点击事件 */
    func itemAction(){
        
    }
    
    /** 销毁控制器一处观察者 */
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
/**
 * 代理
 */
extension BDJCommentViewController:UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource{
 
    /**
     *  uitableView代理
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return hotCArr.count == 0 ? newCArr.count : hotCArr.count
        }else{
            return hotCArr.count
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if hotCArr.count != 0 {
            return 3
        }
        if newCArr.count != 0  {
            return 2
        }
        
        return 1;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return firstCellH
        }else{
            return 100;
        }
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
            
        }
        return 44
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "评论"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("WordTableViewCell", forIndexPath: indexPath) as! WordTableViewCell
          cell.dataModel = firstModel
            return cell
        }else{
            let identifier = "cell" 
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = "wowowowoow"
            return cell!
        }
        
    }
    
    
    /**
     * UIScrollViewDelegate
     * 当我们开始拖拽视图的时候，我们让视图结束编辑，此时，键盘就会回收
     */
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    /**
     * UITextFieldDelegate
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



