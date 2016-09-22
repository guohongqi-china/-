//
//  WordTableViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/11.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh
enum WordTableViewControllerType: Int {
    case WordTableViewControllerWord = 29
    case WordTableViewControllerAll = 1
    case WordTableViewControllerVoice = 31
    case WordTableViewControllerVideo = 41
    case WordTableViewControllerPicture = 10
    

}
class WordTableViewController: UITableViewController {
    var controlType:WordTableViewControllerType?
    var currentPage:Int = 0
    var maxtime:String?
    var modArr:[WordModel]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    lazy var cellHeightDic = [String:CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpTableView()
       
        var bodDic1 = [String:String]()
        bodDic1 = ["a":"list"]
        bodDic1["c"] = "data"
        //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
        bodDic1["type"] = "\(controlType?.rawValue)"
        
    }
    /**
     *  获取控制的type
     *   //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
     */
    func getSelfType() -> String{
        switch self.controlType! {
        case .WordTableViewControllerWord:
            return "29"
           
        case .WordTableViewControllerVideo:
            return "41"
            
        case .WordTableViewControllerVoice:
            return "31"
            
        case .WordTableViewControllerPicture:
            return "10"
           
        default:
            return "1"
            
            
        }
    }
    /**
     *  设置属性
     */
    func setUpTableView(){
        
        //注册xib  cell的方法
        //let cellNib = UINib(nibName: "WordTableViewCell", bundle: nil)
        //tableView.registerNib(cellNib, forCellReuseIdentifier: "WordTableViewCell")
       tableView.rowHeight = UITableViewAutomaticDimension
       tableView.estimatedRowHeight = 1000
        //上拉加载
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.currentPage = 1
            self.loadNewData()
        })
        
        //自动改变下拉图标的透明度，越往下越清楚
        self.tableView.mj_header.automaticallyChangeAlpha = true
        self.tableView.mj_header.beginRefreshing()
        //下拉刷新
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.loadMoreData()
        })
    
    
    }
    /**
     *  加载表格数据方法（下拉加载最新数据）
     *  这里的controlType?.rawValue就是枚举类型取值的方法
     */
    func loadNewData(){
        self.tableView.mj_footer.endRefreshing();
        print("=========\(controlType?.rawValue)");
       WordModel.loadNetworkingData(nil, page: nil,type:"\(controlType!.rawValue)") { (responderObject, error, maxtime) in
        if error != nil{
            
        }else{
            self.modArr?.removeAll()
            self.modArr = responderObject
            self.maxtime = maxtime
        }
        self.tableView.mj_header.endRefreshing()

        }
    }
    /**
     *  下拉加载更多数据
     */
    func loadMoreData(){
        self.tableView.mj_header.endRefreshing()
        currentPage += 1
  
        WordModel.loadNetworkingData(maxtime, page: "\(currentPage)",type:"\(controlType!.rawValue)") { (responderObject, error, maxtime) in
            if error != nil{
                self.tableView.mj_footer.endRefreshing()

            }else{
                if let result = responderObject{
                    for mode:WordModel in  result{
                    if self.modArr?.contains(mode) == false{
                        self.modArr?.append(mode)

                    }
                }
                }
             self.maxtime == maxtime ? self.tableView.mj_footer.endRefreshingWithNoMoreData() : (self.tableView.mj_footer.endRefreshing())
                self.maxtime = maxtime
                self.tableView.reloadData()

            }
        }
        
    }

}

/**
 *  代理方法
 */
extension WordTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.modArr == nil ? 0 : (self.modArr?.count)!
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = self.cellHeightDic["\(indexPath.row)"]!
        return height
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = WordTableViewCell.cellForTableview(tableView, identifier: "WordTableViewCell", indexPath: indexPath)
        let mode = self.modArr![indexPath.row]
        cell.dataModel = mode
        cell.layoutIfNeeded()
        
        if self.cellHeightDic["\(indexPath.row)"] == nil {
            self.cellHeightDic["\(indexPath.row)"] = cell.cellHeight()
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /**
         *  push
         */
        
        let CommentContr = BDJCommentViewController()
        CommentContr.title = "评论"
        CommentContr.firstModel = self.modArr![indexPath.row]
        CommentContr.firstCellH = self.cellHeightDic["\(indexPath.row)"]! as CGFloat
        self.navigationController?.pushViewController(CommentContr, animated: true)
        
    }

}