//
//  AFNetWorkingTools.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import AFNetworking



class AFNetWorkingTools: AFHTTPSessionManager {
    
    private static let instance: AFNetWorkingTools = {
    
        
        let tools = AFNetWorkingTools()
   

        tools.requestSerializer = AFJSONRequestSerializer()
        tools.responseSerializer = AFJSONResponseSerializer()
        /*
         RequestClient.sharedInstance.requestSerializer.setValue("application/json,text/html", forHTTPHeaderField: "Accept")
         RequestClient.sharedInstance.requestSerializer.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"
         */
        // 设置相应的默认反序列化格式
        
        tools.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        
        return tools
    }()
    
    //获取单例类的方法
    class func shareNetWorkingTools() -> AFNetWorkingTools {
        return instance
    }
    
    /**
     * 释放
     */
    deinit{
        AFNetWorkingTools().operationQueue.cancelAllOperations()
    }

}
