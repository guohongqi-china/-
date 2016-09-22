//
//  FocusModel.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import AFNetworking

class FocusModel: NSObject {
    var count:Int = 0
    var id:Int = 0
    var name:String?
    
    var next_page:Int = 0
    var total_page:Int = 0
    var totla:Int = 0
    var list = [RightTableViewModel]()
    var currentPage:Int = 0
    
    
    
    init(modeDic:[String:AnyObject]) {
       super.init()
        setValuesForKeysWithDictionary(modeDic)
    }
    
    class func modelDic(dic:[String:AnyObject]) -> FocusModel {
       
        let arr =  FocusModel(modeDic: dic)
        return arr
    }
    
     class func modelArr(arrayDic:[[String:AnyObject]]) -> [FocusModel] {
        var arr = [FocusModel]()
        for dict in arrayDic{
            arr.append(FocusModel(modeDic: dict))
        }
        return arr
    }
    
    class func LoadNewData(finished: (dataArr: [FocusModel]?, error: NSError?)->()) {
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
        
        var params = ["a": "category"]
        params["c"] = "subscribe"
        
        AFNetWorkingTools.shareNetWorkingTools().GET("http://api.budejie.com/api/api_open.php", parameters: params, progress: { (downloadProgress: NSProgress) -> Void in
            
            print(downloadProgress)
            
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                print(responseObject!["list"])
                let modelArr = responseObject!["list"] as? [[String:AnyObject]]
                let arr = FocusModel.modelArr(modelArr!)
              dispatch_async(dispatch_get_main_queue(), { () -> Void in
                finished(dataArr: arr, error: nil)

              })
                
            }, failure: { (task: NSURLSessionDataTask?, error : NSError) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in

                finished(dataArr: nil, error: error)
                })
                
                
        })

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "list"{
            let arr = value as! [[String:AnyObject]]
         list =  RightTableViewModel.dicToModel(arr)
            return
        }
        super.setValue(value, forKey: key)
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("没有找到\(key)")
    }
    // 定义类属性数组
    static let properties = ["count", "id", "name","next_page","total_page","totla"]
    // 打印对象
    override var description: String{
        return "\(self.dictionaryWithValuesForKeys(FocusModel.properties))"
    }


}
