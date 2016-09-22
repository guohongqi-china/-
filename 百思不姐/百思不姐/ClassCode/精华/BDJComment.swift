//
//  BDJComment.swift
//  百思不姐
//
//  Created by MacBook on 16/9/18.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class BDJComment: NSObject {
    
    /**
     * 属性列表
     */
    var voicetime  = ""//音频时长
    var content    = ""//评论内容
    var like_count = ""//点赞数
    var user : BDJUserModel? //用户model
    
    init(modDic:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(modDic)
    }

    
    /**
     * 字典数组转换模型数组
     */
    class func modelArr(arrayDic:[[String:AnyObject]]) -> [BDJComment] {
        var arr = [BDJComment]()
        for dict in arrayDic{
            let mo = BDJComment(modDic: dict)
            arr.append(mo)
        }
        return arr
    }
   
    /**
     * 重写kvc赋值方法
     */
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user"{
            let dic = value as! [String : AnyObject]
           user = BDJUserModel(modDic: dic)
            return;
        }

        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}
