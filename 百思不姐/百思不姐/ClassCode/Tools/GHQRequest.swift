//
//  GHQRequest.swift
//  百思不姐
//
//  Created by MacBook on 16/7/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation
import AFNetworking
import MBProgressHUD
class GHQRequest: NSObject {
     /**
      * 发送网络请求
      * requestType：网络请求的类型
      * finished：闭包返回的请求信息
      */
    internal  class func sendRequestToServer(requestUrl:String, bodyDic:[String:AnyObject], requestType:String,finished: (responseObject: AnyObject, error: NSError?)->()){
        
//        Reachability().NetworkSupervison { (isOrNo) in
//            
//       
//            if !isOrNo{
//                MBProgressHUD.showSuccess("请链接网络", toView: UIApplication.sharedApplication().windows.last!)
//                return;
//            }
        
        if requestType == "POST" {
            //发送post请求
            AFNetWorkingTools.shareNetWorkingTools().POST(requestUrl, parameters: bodyDic, progress: { (progress:NSProgress) in
                
                }, success: { (task:NSURLSessionDataTask, responseObject:AnyObject?) in
                    //将返回的结果通过闭包返回
                    print("请求接口：\(requestUrl)")
                    print("请求参数：\(bodyDic)")
                    print("请求结果：\(responseObject)")
                    finished(responseObject:responseObject!, error: nil)

                }, failure: { (task:NSURLSessionDataTask?, error:NSError) in
                    print("请求接口：\(requestUrl)")
                    print("请求参数：\(bodyDic)")
                    print("请求结果：\(error)")
                    //将返回的结果通过闭包返回
                    finished(responseObject:error, error: nil)

            })
        }else{
            //get请求
            AFNetWorkingTools.shareNetWorkingTools().GET(requestUrl, parameters: bodyDic, progress: { (progress:NSProgress) in
                
                }, success: { (task:NSURLSessionDataTask, responseObject:AnyObject?) in
                    print("请求接口：\(requestUrl)")
                    print("请求参数：\(bodyDic)")
                    print("请求结果：\(responseObject)")
                    //将返回的结果通过闭包返回
                    finished(responseObject:responseObject!, error: nil)
                    
                }, failure: { (task:NSURLSessionDataTask?, error:NSError) in
                    print("请求接口：\(requestUrl)")
                    print("请求参数：\(bodyDic)")
                    print("请求结果：\(error)")

                    //将返回的结果通过闭包返回
                    finished(responseObject:error, error: nil)
                    
            })

            
        }
            
//    }
    }
    
    override init() {
        super.init()
        
    }
    
    class func Reachability() -> GHQRequest{
        return GHQRequest()
    }
  
    
    var reachabilityManager : AFNetworkReachabilityManager?
    /**
     *  网络监管
     case Unknown
     case NotReachable
     case ReachableViaWWAN
     case ReachableViaWiFi
     */
    func NetworkSupervison(finshed:(isOrNo:Bool) -> ()){
        
        print("guohongqi======================guohongqi")
        reachabilityManager = AFNetworkReachabilityManager.sharedManager()
        reachabilityManager!.setReachabilityStatusChangeBlock({ (status:AFNetworkReachabilityStatus) in
            print("guohongqi====999==================guohongqi")

            switch (status){
            case .Unknown:
                finshed(isOrNo: false)
                break
            case .NotReachable:
                finshed(isOrNo: false)
                break
            case .ReachableViaWWAN:
                finshed(isOrNo: true)
                break
            case .ReachableViaWiFi:
                finshed(isOrNo: true)
                break
           
            }
        })
    }
}
