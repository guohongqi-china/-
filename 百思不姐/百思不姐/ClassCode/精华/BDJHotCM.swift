//
//  BDJHotCM.swift
//  百思不姐
//
//  Created by MacBook on 16/9/20.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class BDJHotCM: NSObject {
    
    var hostID = String()
    var like_count = String()
    var voiceuri = String()
    var ctime = String()
    var preuid = String()
    var precid = String()
    var voicetime = String()
    var user = BDJUserModel()
    var content = String()
    var precmt = [[String:AnyObject]]()
    var data_id = String()
    var status = String()
    
   
  
    
    /**
     * 重写init方法
     */
    init(valuesDic:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(valuesDic)
        properties = self.getAllPropertys()
      
    }
    
    /**
     * 字典数组转模型
     */
   class func dicValuesToModel(dataDic:[[String:AnyObject]]) -> [BDJHotCM] {
        var valuesArr = [BDJHotCM]()
        for (_,data) in dataDic.enumerate() {

            valuesArr.append(BDJHotCM(valuesDic: data))
      
        }
        return valuesArr
    }
    
    
    
    /**
     * kvc赋值
     */
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "user" {
            guard let kvs = value as? [String:AnyObject] else{
                return
            }
            user = BDJUserModel(modDic: kvs)
            return
        }
        
        if key == "precmt" {
            print(value?.classForCoder)
            if ((value?.isKindOfClass(NSArray)) != nil) {
                
                print("123")
                
            }else if value?.isKindOfClass(NSDictionary) != nil{
                print("456")

            }
            return;
        }
        
        if key == "id" {
            hostID = value as! String
            return
        }
        
        
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    // 定义类属性数组

     var properties = [String]()
    // 打印对象
    override var description: String{
        properties.removeLast()
        return "\(self.dictionaryWithValuesForKeys(properties))"
    }

    
    
    class func getNewDataFromServer(firstModel:WordModel,finshed:(responderObject:[BDJHotCM]?,latextData:[BDJHotCM]?,error:ErrorType?) ->()){
        
        /** 参数设置 */
        var bodDic = [String:String]()
        bodDic["a"] = "dataList"
        bodDic["c"] = "comment"
        bodDic["data_id"] = firstModel.id
        bodDic["hot"] = "1"
        
        //发送请求
        GHQRequest.sendRequestToServer(ModelForUrl.wordUrl(), bodyDic: bodDic, requestType: "POST") { (responseObject, error) in
            
            
            if error == nil{
                
                /** 获取数据并生成plist文件保存 */
                if !responseObject.isKindOfClass(NSError){
                    
                    let dataArr1 = NSDictionary(dictionary: responseObject as! [NSObject : AnyObject] )
                    dataArr1.writeToFile("/Users/macbook/Desktop/data.plist", atomically: true)
 
                    let arr = responseObject["data"] as! [[String:AnyObject]]
                    let latextArr = responseObject["hot"] as! [[String:AnyObject]]
                    
                    let valuesArr1 = BDJHotCM.dicValuesToModel(arr)
                    let valuesArr2 = BDJHotCM.dicValuesToModel(latextArr)
                    finshed(responderObject:valuesArr1,latextData:valuesArr2,error:nil)

                    
                    /** 生成属性 */
                    /*
                     let dic = NSDictionary(dictionary: arr[0])
                     for element in dic.allKeys{
                     
                     print("var \(element) = String()")
                     
                     }
                     */
      
                }else{
                    finshed(responderObject: responseObject as? [BDJHotCM],latextData: nil, error: nil)
                }
            
            }else{
            finshed(responderObject: nil,latextData: nil, error: error)
            }
        }

        
    }
    
    
    
 

    
    
    
    
    
    

}
