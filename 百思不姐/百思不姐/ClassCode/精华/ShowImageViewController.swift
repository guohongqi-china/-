//
//  ShowImageViewController.swift
//  百思不姐
//
//  Created by MacBook on 16/8/10.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
class ShowImageViewController: UIViewController {
    
    
    @IBOutlet var pregressView: GHQlineView!
    @IBOutlet var backBt: UIButton!
    @IBOutlet var storageBt: UIButton!
    @IBOutlet var ImageScroview: UIScrollView!
    
    var picWidth:CGFloat = 0
    var picHeight:CGFloat = 0
    
    /////////////////////////////////////////
    //MARK:懒加载
    var model : WordModel?{
        didSet{
            picWidth = UIScreen.mainScreen().bounds.size.width
           let str1 = model!.height! as NSString
            let str2 = model!.width! as NSString
        
            picHeight  = picWidth * CGFloat(str1.floatValue) / CGFloat(str2.floatValue)
        }
    }
     //图片显示
     lazy var  pictureImage:UIImageView = {
      let view = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowImageViewController.tapAction))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }()

    lazy  var picView:UIImageView = {
        let v = UIImageView()
    return v
    }()
    
    /**
     *  按钮点击事件
     */
    @IBAction func sender(sender: UIButton) {
        if sender == storageBt {
            //保存按钮
            if pictureImage.image == nil{
                return
            }
            //保存图片到相册中
            UIImageWriteToSavedPhotosAlbum(pictureImage.image!, self, #selector(ShowImageViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
             MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        }else if sender == backBt{
            //返回按钮
            tapAction()
        }
    }
    
    func tapAction(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    /**
     *  照片写入相册成功与失败的回调方法
     */
    func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), { 
                dispatch_async(dispatch_get_main_queue(), { 
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                })
            })
            return
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置imageView的尺寸大小
        picHeight > UIScreen.mainScreen().bounds.size.height ? (pictureImage.frame = CGRectMake(0, 0, picWidth, picHeight),ImageScroview.contentSize = CGSizeMake(0, picHeight)) : (pictureImage.Size = CGSizeMake(picWidth, picHeight),pictureImage.center = CGPointMake(UIView.kScreenWidth() / 2, UIView.kScreenHeight() / 2))
        
        //图片赋值
         picView.sd_setImageWithURL(NSURL(string: (model?.image2)!), placeholderImage: UIImage(named: "header_cry_icon")!, options: SDWebImageOptions.ProgressiveDownload, progress: { (receiveSize:Int, expectedSize:Int) in
         print("============\(Float(receiveSize))++++++++\(Float(expectedSize))")
         self.model!.picProgress = Float(receiveSize)/Float(expectedSize)
         self.pregressView.progress = CGFloat(self.model!.picProgress)
         }, completed: { (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, imageUrl:NSURL!) in
         //加载完之后要隐藏进度条
        self.pregressView.hidden = true
        self.pictureImage.image = image
         })


        ImageScroview.addSubview(pictureImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
