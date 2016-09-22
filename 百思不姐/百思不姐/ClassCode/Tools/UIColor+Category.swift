//
//  UIColor+Category.swift
//  百思不姐
//
//  Created by MacBook on 16/7/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation
//import UIColor

extension UIColor{
    
    class func RGBColor(red:CGFloat, green:CGFloat , blue:CGFloat,alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}

