//
//  FocusViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh
class FocusViewController: UIViewController {

    
    let CELLId : String  = "cell1"
    let cell2 : String = "cell2"
    var modelID:Int = 0
    var index1:Int = 0
    var index2:Int = 0
    var isOrNo : Bool = false
    @IBOutlet var leftTableView: UITableView!

    @IBOutlet var rightTableView: UITableView!
    
    var Arr:[FocusModel]?
        {
        didSet{
            print("sdfafdsafd")
            self.leftTableView.reloadData()
            //设置最开始选中的单元格下标
            self.leftTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
            //加载数据
            self.rightTableView.mj_header.beginRefreshing()
        }
    }
    var modelDic = [String:[RightTableViewModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upDataUI()
        setUpData()
        setUpRefresh()
        
        
    }
    /**更新UI*/
    private func upDataUI(){
        title = "推荐关注"
        leftTableView.registerNib(UINib(nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: CELLId)
        leftTableView.backgroundColor = UIColor.RGBColor(244, green: 244, blue: 244, alpha: 1)
        rightTableView.registerNib(UINib(nibName: "RightTableViewCell", bundle: nil), forCellReuseIdentifier: cell2)
        
        //设置内边距
        automaticallyAdjustsScrollViewInsets = false
        leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        rightTableView.contentInset = leftTableView.contentInset
        
        //设置行高
        rightTableView.rowHeight = 70;
        
    
    }
    private func setUpRefresh(){
        //下拉加载上拉刷新
        rightTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(FocusViewController.loadNewUsers))
        rightTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(FocusViewController.loadMoreUsers))
//        rightTableView.mj_footer.hidden = true
        
    }
    func loadNewUsers(){
        
     let model =  DidSeletedRowForModel()
        model.currentPage = 1;
        self.modelID = model.id
        RightTableViewModel.loadDataFromNetWorking(model) { (dataArr, error) -> () in
            if self.modelID != model.id {
                return
            }
            if dataArr == nil{
                MBProgressHUD.showSuccess("加载失败", toView: self.view)
                print("我错了")
            }else{
                self.modelDic.removeValueForKey("\(self.leftTableView.indexPathForSelectedRow!.row)")
                self.modelDic["\(self.leftTableView.indexPathForSelectedRow!.row)"] = dataArr!.list
                self.rightTableView .reloadData()
                self.rightTableView.mj_header.endRefreshing()
                
                if dataArr!.total_page == model.currentPage  {
                    self.rightTableView.mj_footer.endRefreshingWithNoMoreData()
                }

            }
        }
        
    }
    
    func loadMoreUsers(){
        self.isOrNo = false
        let model =  DidSeletedRowForModel()
        model.currentPage += 1
        self.modelID = model.id
        self.index2 = self.index1
        RightTableViewModel.loadDataFromNetWorking(model) { (dataArr, error) -> () in
            if self.modelID != model.id {
                return
            }
            if dataArr == nil{
                MBProgressHUD.showSuccess("加载失败", toView: self.view)
                print("我错了")
            }else{

                for model in dataArr!.list{
                    self.modelDic["\(self.leftTableView.indexPathForSelectedRow!.row)"]?.append(model)
                }
                
                self.rightTableView .reloadData()
                dataArr!.total_page == model.currentPage ? self.rightTableView.mj_footer.endRefreshingWithNoMoreData(): self.rightTableView.mj_footer.endRefreshing()

                
            }
        }

        
    }
    
    
     func DidSeletedRowForModel() -> FocusModel{
    return self.Arr![self.leftTableView.indexPathForSelectedRow!.row]
    }
    
    
    /**左侧tableView请求数据*/
   private func setUpData(){
    MBProgressHUD.showMessage("努力加载中。。", toView: self.view)
    FocusModel.LoadNewData { (dataArr, error) -> () in
            if error==nil{
                self.Arr = dataArr
                MBProgressHUD.hideHUDForView(self.view)
                print(self.Arr)
            }else{
                MBProgressHUD.hideHUDForView(self.view)

                MBProgressHUD.showSuccess("加载失败", toView: self.view)
        }
            
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension FocusViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == leftTableView{
        return self.Arr == nil ? 0 : self.Arr!.count;
        }else{
     
            return    self.modelDic.count == 0 ? 0 : (self.modelDic.keys.contains("\(self.leftTableView.indexPathForSelectedRow!.row)") ?  self.modelDic["\(self.leftTableView.indexPathForSelectedRow!.row)"]!.count : 0)

        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == leftTableView{
        let cell  = tableView.dequeueReusableCellWithIdentifier(CELLId) as! LeftTableViewCell
      
        cell.model = Arr![indexPath.row]
        
        return cell
        }else{
           
            let cell  = tableView.dequeueReusableCellWithIdentifier(cell2) as! RightTableViewCell
            print(self.leftTableView.indexPathForSelectedRow!.row)
            if !self.modelDic.keys.contains("\(self.leftTableView.indexPathForSelectedRow!.row)"){
                return cell
            }
            cell.dataModel = self.modelDic["\(self.leftTableView.indexPathForSelectedRow!.row)"]![indexPath.row]
            return cell

        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let model =  self.Arr![indexPath.row]
        
        //左侧列表点击事件
        if tableView == leftTableView{
         
            if  self.modelDic["\(indexPath.row)"] != nil{
                self.rightTableView.reloadData()
            } else {
                self.rightTableView.mj_header.beginRefreshing()
//                loadNewUsers()
            }
            
        }
       
   
    
    }
    
    
    
    
    
}
