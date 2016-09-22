//
//  GHQFourViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/7/4.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class GHQFourViewController: UIViewController {
    
    override func viewDidLoad() {
        navigationItem.title = "我的"
        navigationItem.rightBarButtonItems = [left,right]
        
    }
    
    lazy var left:UIBarButtonItem = UIBarButtonItem.CreateBarButtonItem("", imageStr: "mine-setting-icon", heightImage: "mine-setting-icon-click", target: self, buttonAction: "action")
    lazy var right:UIBarButtonItem = UIBarButtonItem.CreateBarButtonItem("", imageStr: "mine-moon-icon", heightImage: "mine-moon-icon-click", target: self, buttonAction: "action2")
    func action(){
        print("dfafd")
    }
    func action2(){
        print("fdafaffffffff")
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let vc = viewc
//        navigationController?.pushViewController(, animated: <#T##Bool#>)
        
//        let vc = ViewController()
//        navigationController?.pushViewController(vc, animated: <#T##Bool#>)
    }

}
