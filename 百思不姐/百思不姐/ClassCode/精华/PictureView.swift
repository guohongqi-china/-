//
//  PictureView.swift
//  百思不姐
//
//  Created by MacBook on 16/7/31.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class PictureView: UIView {
    var model : WordModel?
    
    @IBOutlet var backgroudImage: UIImageView!
    @IBOutlet var DALabelView: GHQlineView!
    @IBOutlet var GifImage: UIImageView!
    
    @IBOutlet var senderButton: UIButton!
    
    func tapAction(){
        let pictureControl = ShowImageViewController()
        pictureControl.model = model
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(pictureControl, animated: true, completion: nil)
    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(PictureView.tapAction))
        backgroudImage.addGestureRecognizer(tap)
        
        
        
    }

   
    class func sharePicImage() -> PictureView{
        print(NSStringFromClass(self))
        return NSBundle.mainBundle().loadNibNamed("PictureView", owner: nil, options: nil).last as! PictureView
    }

}
