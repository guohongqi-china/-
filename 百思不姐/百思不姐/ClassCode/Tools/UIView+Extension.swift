//
//  UIView+Extension.swift
//  百思不得姐
//
//  Created by MacBook on 16/7/1.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    public var Size:CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame.size
            frame = newValue
            self.frame.size = frame
        }
    }
    //
    public var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame;
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    
    public var y : CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    
    public var width : CGFloat{
        get{
            return self.frame.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height : CGFloat{
        get{
            return self.frame.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }

    
    public class func kScreenWidth() -> CGFloat{
        return UIScreen.mainScreen().bounds.size.width
    }
    
    public class func kScreenHeight() -> CGFloat{
        return UIScreen.mainScreen().bounds.size.height
    }
    
}