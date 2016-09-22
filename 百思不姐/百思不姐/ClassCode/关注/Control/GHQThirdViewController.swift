//
//  GHQThirdViewController.swift
//  百思不得姐
//
//  Created by MacBook on 16/6/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit


class GHQThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我关注的"
        navigationItem.leftBarButtonItem = UIBarButtonItem.CreateBarButtonItem("", imageStr: "friendsRecommentIcon", heightImage: "riendsRecommentIcon-click", target: self, buttonAction: "buttonAction")

    }
    func buttonAction(){
        print("wo")
        
        
    }
    @IBAction func LoginAndRegisterButton(sender: UIButton) {
        
    presentViewController(LoginRegistViewController(), animated: true, completion: nil)
        
    }

    @IBOutlet var loginButtonAction: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        navigationController?.pushViewController(FocusViewController(), animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
