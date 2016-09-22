//
//  NSDate+Extension.swift
//  百思不姐
//
//  Created by MacBook on 16/7/28.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation

extension NSDate{
    
    /**
     *  两个日期进行比较
     */
    internal func twoDateToCompare(date:NSDate) -> NSDateComponents{
        //日历
        let calendar = NSCalendar.currentCalendar()
        //比较时间
        let unit:NSCalendarUnit =  [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second]
       return calendar.components(unit, fromDate: date, toDate: self, options: NSCalendarOptions(rawValue: 0))
    }
    
    /**
     *  是否是今年
     */
    internal func isThisYear() -> Bool{
        let calendar = NSCalendar.currentCalendar()
        let nowYear = calendar.component(NSCalendarUnit.Year, fromDate: NSDate())
        let selfYear = calendar.component(NSCalendarUnit.Year, fromDate: self)
        return nowYear == selfYear
    }
    
    /**
     *  是否是今天
     */
    internal func isThisToday() -> Bool{
        let dformatter = NSDateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd"
        let nowString = dformatter.stringFromDate(NSDate()) as String
        let selfString = dformatter.stringFromDate(self) as String
        return nowString == selfString
    }
    
    /**
     *  是否是昨天
     */
    internal func isYesterday() -> Bool{
          // 日期格式化类
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let uuu = dformatter.stringFromDate(NSDate())
        let nowDate = dformatter.dateFromString(uuu)
        let selfDate = dformatter.dateFromString(dformatter.stringFromDate(self))
        let calendar = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit =  [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day ]
        let cmps = calendar.components(unit, fromDate: selfDate!, toDate: nowDate!, options: NSCalendarOptions(rawValue: 0))
        return cmps.year == 0
            && cmps.month == 0
            && cmps.day == 1
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
