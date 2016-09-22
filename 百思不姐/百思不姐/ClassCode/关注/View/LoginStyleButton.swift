//
//  LoginStyleButton.swift
//  百思不姐
//
//  Created by MacBook on 16/7/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class LoginStyleButton: UIButton {
    
    /**
     *  加载完xib执行方法
     */
    override func awakeFromNib() {
        
    }
    /**
     *  重新设置布局
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        //调整图片位置与尺寸
        imageView?.x = 0
        imageView?.y = 0
        imageView?.width = self.width
        imageView?.height = self.width
        
        
        //调整文字位置与尺寸
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.height)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (titleLabel?.y)!
        
        titleLabel?.textAlignment = NSTextAlignment.Center
        
    }
    
}
