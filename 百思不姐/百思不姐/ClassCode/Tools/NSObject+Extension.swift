//
//  File.swift
//  百思不姐
//
//  Created by MacBook on 16/9/21.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation

extension NSObject{
    /**
     获取对象的所有属性名称
     - returns: 属性名称数组
     */
    func getAllPropertys()->[String]{
        
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.alloc(0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        for i in 0...countInt-1{
            let temp = buff[i]
            let tempPro = property_getName(temp)
            let proper = String.init(UTF8String: tempPro)
            result.append(proper!)
            
        }
        return result
    }
}