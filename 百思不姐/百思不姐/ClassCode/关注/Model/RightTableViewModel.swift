//
//  RightTableViewModel.swift
//  百思不姐
//
//  Created by MacBook on 16/7/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit


class RightTableViewModel: NSObject {
    
    //    "fans_count" = 5946;
    //    gender = 2;
    //    header = "http://wimg.spriteapp.cn/profile/large/2015/09/30/560b557be210a_mini.jpg";
    //    introduction = "";
    //    "is_follow" = 0;
    //    "is_vip" = 0;
    //    "screen_name" = "\U5b59\U900a \U7b491227\U4eba";
    //    "tiezi_count" = 129;
    //    uid = 9017486;
  static  var ID:[String:String]?

    var fans_count:Int = 0
    var gender:Int = 0
    var header:String?
    var introduction:String?
    var is_follow:Int = 0
    var is_vip:Int = 0
    var screen_name:String?
    var tiezi_count:Int = 0
    var uid:Int = 0
        class func loadDataFromNetWorking(modelId:FocusModel,finshed:(dataArr: FocusModel?, error: NSError?) ->() ) {
        
//        dispatch_after(<#T##when: dispatch_time_t##dispatch_time_t#>, <#T##queue: dispatch_queue_t##dispatch_queue_t#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)
            var  parms = ["a":"list"]
            parms["c"] = "subscribe"
            parms["category_id"] = "\(modelId.id)"
            parms["page"] = "\(modelId.currentPage)"
            ID = parms
        
        
            AFNetWorkingTools.shareNetWorkingTools().GET("http://api.budejie.com/api/api_open.php", parameters: parms, success: { (task:NSURLSessionDataTask, responsObject:AnyObject?) -> Void in
               
                    if ID! != parms{
                        print("======================")
                        return
                    }
                    
                    print(responsObject)
                    let modelArr = responsObject as! [String:AnyObject]
                    let Arr = FocusModel.modelDic(modelArr)
                    finshed(dataArr: Arr, error: nil)

                
                
                
                }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                finshed(dataArr: nil, error: error)
                   
                    
                    
            }
        
        
    }
    
    
    //**字典转模型方法*/
    class func dicToModel(modelArr:[[String:AnyObject]]) -> [RightTableViewModel] {
        var arr = [RightTableViewModel]()
        for dictionary in modelArr{
            //            arr.append(RightTableViewModel(dic: dictionary),id:"")
            arr.append(RightTableViewModel(dic: dictionary, id: ""))
        }
        return arr
    }
    
    //自定义初始化方法
    init(dic:[String:AnyObject], id:String) {
        super.init()
        setValuesForKeysWithDictionary(dic)
        //        ID = id
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    // 定义类属性数组
    static let properties = ["fans_count", "gender", "header","introduction","is_follow","is_vip","screen_name","tiezi_count","uid"]
    // 打印对象
    override var description: String{
        return "\(self.dictionaryWithValuesForKeys(RightTableViewModel.properties))"
    }
    
}
