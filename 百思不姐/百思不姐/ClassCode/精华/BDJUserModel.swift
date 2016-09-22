//
//  BDJUserModel.swift
//  百思不姐
//
//  Created by MacBook on 16/9/18.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class BDJUserModel: NSObject {
    
    /**
     * 属性列表
     */
    var username      = ""//用户名
    var sex           = ""//性别分为m 和 f
    var profile_image = ""// 头像
    
    /**
     * 初始化方法
     */
    override init() {
        super.init()
    }
    init(modDic:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(modDic)
    }
    // 定义类属性数组
    static let properties = ["username", "sex", "profile_image"]
    // 打印对象
    override var description: String{
        return "\(self.dictionaryWithValuesForKeys(BDJUserModel.properties))"
    }
    /**
     * 字典数组转换模型数组
     */
    class func modelArr(arrayDic:[[String:AnyObject]]) -> [BDJUserModel] {
        var arr = [BDJUserModel]()
        for dict in arrayDic{
            let mo = BDJUserModel(modDic: dict)
            arr.append(mo)
        }
        return arr
    }

    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}
