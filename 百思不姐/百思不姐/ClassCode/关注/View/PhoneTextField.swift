//
//  PhoneTextField.swift
//  百思不姐
//
//  Created by MacBook on 16/7/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class PhoneTextField: UITextField {

    
//    class func RunTimeAction() {
//        var connt:UInt32 = 0
//        let ivarS = class_copyIvarList(self.classForCoder(), &connt)
//       
//        for (var i:UInt32 = 0; i < connt; i++){
//            let ivar = ivarS[Int(i)]
//            print(ivar_getName(ivar))
//        }
//        
//    }
   
    override func awakeFromNib() {
        textColor = UIColor.whiteColor()
        self.setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        tintColor = textColor
    }
    
    override func resignFirstResponder() -> Bool {
        self.setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        return super.resignFirstResponder()
    }
    override func becomeFirstResponder() -> Bool {
        self.setValue(textColor, forKeyPath: "_placeholderLabel.textColor")
        return super.becomeFirstResponder()
    }
    
    
    
}
