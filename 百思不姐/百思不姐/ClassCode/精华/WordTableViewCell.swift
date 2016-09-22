
//
//  WordTableViewCell.swift
//  百思不姐
//
//  Created by MacBook on 16/7/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit
import SDWebImage
class WordTableViewCell: UITableViewCell {

    
    @IBOutlet var sina_vView: UIImageView!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var forwardingButton: UIButton!
    @IBOutlet var noPraiseButton: UIButton!
    @IBOutlet var praiseButton: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var bottomView: UIView!
   
    @IBOutlet var HotCommentV: UIView!
    //最热评论内容
    @IBOutlet var HotCommentL: UILabel!
    var IMAGEH : CGFloat = 0
    var number :CGFloat = 0
    
    lazy  var picView:UIImageView = {
        let v = UIImageView()
        return v
    }()

    
    
    /**
     *  懒加载图片
     */
   lazy var  PCView:PictureView = {
        let pc = PictureView.sharePicImage()
        return pc
    }()
    lazy var timer:NSTimer = {
        let time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(WordTableViewCell.timeAction), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(time, forMode: NSRunLoopCommonModes)
        return time
    }()
    lazy var  VoiceView:TopicVoiceView = {
        let pc = TopicVoiceView.VoiceView()
        return pc
    }()
    lazy var  VideoView:TopicVideoView = {
        let pc = TopicVideoView.VoiceView()
        return pc
    }()
    
    func timeAction(){
        number += 0.01
    }
    /**
     *  设置cell数据
     */
    var dataModel : WordModel?{
        didSet{
            
            iconImageView.sd_setImageWithURL(NSURL(string: (dataModel?.profile_image)!), placeholderImage: UIImage(named: "header_cry_icon"))
            userName.text = dataModel?.name
            timeLabel.text = ComputationTime((dataModel?.create_time)!)
            contentLabel.text = dataModel?.text
            if dataModel?.sina_v == "0" {
                sina_vView.hidden = true
            }
            
            //底部button属性设置
            setupButton(praiseButton, title: Float((dataModel?.ding)!)!, placeholder:"顶")
            setupButton(noPraiseButton, title: Float((dataModel?.cai)!)!, placeholder:"猜")
            setupButton(forwardingButton, title: Float((dataModel?.repost)!)!, placeholder:"分享")
            setupButton(messageButton, title: Float((dataModel!.commentCount)), placeholder:"评论")
            let str1 = dataModel!.height! as NSString
            let str2 = dataModel!.width! as NSString
            let HT = PCViewHeight(CGFloat(str2.floatValue), height: CGFloat(str1.floatValue))
            self.layoutIfNeeded()
            IMAGEH = HT
            //图片设置
           
            if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerPicture.rawValue)" {
                PCView.model                = dataModel
                PCView.x                    = 10
                PCView.y                    = CGRectGetMaxY(contentLabel.frame) + 10
                PCView.width                = UIView.kScreenWidth() - 20
                PCView.height               = HT
                PCView.autoresizingMask     = UIViewAutoresizing.None
                PCView.DALabelView.hidden   = false

                contentView.addSubview(PCView)

                PCView.backgroudImage.image = nil
                timer.fireDate              = NSDate.distantPast()
                
                /**
                 *  receiveSize：已经接收到的值
                 *  expectedSize：期望得到的值（其实就是总值）
                 */
                picView.sd_setImageWithURL(NSURL(string: (dataModel?.image0)!), placeholderImage: UIImage(named: "header_cry_icon")!, options: SDWebImageOptions.ProgressiveDownload, progress: { (receiveSize:Int, expectedSize:Int) in
                    print("============\(Float(receiveSize))++++++++\(Float(expectedSize))")
                    self.dataModel!.picProgress = Float(receiveSize)/Float(expectedSize)
                    self.PCView.DALabelView.progress = CGFloat(self.dataModel!.picProgress)
                    }, completed: { (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, imageUrl:NSURL!) in
                        self.PCView.DALabelView.hidden = true
                        if self.dataModel?.bigPicture == false {
                            self.PCView.backgroudImage.image = image;
                        return
                        }
                        //开启上下文
                        let wh = self.dataModel!.width! as NSString
                        let hh = self.dataModel!.height! as NSString
                        let width = CGFloat(wh.floatValue)
                        let height = CGFloat(hh.floatValue)

                        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.PCView.width, HT), true, 0.0)
                        // 将下载完的image对象绘制到图形上下文
                        image.drawInRect(CGRectMake(0, 0, self.PCView.width, self.PCView.width * height / width))
    
                        //加载完之后要隐藏进度条
                        // 获得图片
                        self.PCView.backgroudImage.image = UIGraphicsGetImageFromCurrentImageContext()
                        
                        // 结束图形上下文
                        UIGraphicsEndImageContext();
                        
                 })

                
                let str = NSURL(string: (dataModel?.image2)!)!.pathExtension
                //判断gif图片是否隐藏
                PCView.GifImage.hidden = str?.lowercaseString != "gif"

                //判断是否显示：“点击查看大图”
             
                
                ((dataModel?.bigPicture) == true) ? (PCView.senderButton.hidden = false,PCView.backgroudImage.contentMode = UIViewContentMode.ScaleAspectFill):(PCView.senderButton.hidden = true,PCView.backgroudImage.contentMode = UIViewContentMode.ScaleToFill)
                
                removeView(VoiceView)
                removeView(VideoView)
                /**
                 * 声音
                 */
            }else if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerVoice.rawValue)"{
                
                VoiceView.dataModel = self.dataModel
                VoiceView.width = UIView.kScreenWidth() - 20
                VoiceView.x = 10
                VoiceView.y = CGRectGetMaxY(self.contentLabel.frame) + 10
                if let model : WordModel = self.dataModel{
                    
                    let wh = model.width! as NSString
                    let hh = model.height! as NSString
                    let width = CGFloat(wh.floatValue)
                    let height = CGFloat(hh.floatValue)
                    if width != 0{
                        VoiceView.height = VoiceView.width * height / width
                    }
                    
                }
                
                

                contentView.addSubview(VoiceView)
                
                removeView(PCView)
                removeView(VideoView)
                
                
            }else if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerVideo.rawValue)"{
                
                VideoView.dataModel = self.dataModel
                VideoView.width = UIView.kScreenWidth() - 20
                VideoView.x = 10
                VideoView.y = CGRectGetMaxY(self.contentLabel.frame) + 10
                if let model : WordModel = self.dataModel{
                    
                    let wh = model.width! as NSString
                    let hh = model.height! as NSString
                    let width = CGFloat(wh.floatValue)
                    let height = CGFloat(hh.floatValue)
                    if width != 0{
                        VideoView.height = VideoView.width * height / width
                        
                    }
                    
                }

                contentView.addSubview(VideoView)
                
                removeView(VoiceView)
                removeView(PCView)
                
                
            }else{
                if contentView.subviews.contains(PCView) {
                    PCView.removeFromSuperview()
                }
                if contentView.subviews.contains(VoiceView) {
                    VoiceView.removeFromSuperview()
                }
                if contentView.subviews.contains(VideoView) {
                    VideoView.removeFromSuperview()
                }
            }
            
            /** 处理最热评论 */
            let Mod = dataModel?.top_cmt.first
            if (Mod != nil) {
                HotCommentV.hidden = false
                HotCommentL.text = (Mod?.user?.username)! + " : " + (Mod?.content)!
            }else{
                HotCommentV.hidden = true
            }
            
        }
    }
    
    //移除视图
    func removeView(childView:UIView) {
        if contentView.subviews.contains(childView) {
            childView.removeFromSuperview()
        }
    }
    
    /**
     *  图片尺寸设置
     */
    func PCViewHeight(widht:CGFloat, height:CGFloat) -> CGFloat{
        let height = (UIView.kScreenWidth() - 20) * height / widht
        if height >= 300 {
            dataModel?.bigPicture = true
            return 300
        }
        return height
        
    }
    
    /**
     *  时间计算
     */
    func ComputationTime(createString:String) -> String{
        
        let resultString:String?
        //日期格式化
        let dataFormatter = NSDateFormatter()
        //设置日期格式
        dataFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        //获取时间
        let createDate = dataFormatter.dateFromString(createString)
        //判断是否是今年
        if ((createDate?.isThisYear()) != nil) {
            
            if ((createDate?.isThisToday()) != nil) {
                //是否是今天
                let cmps = NSDate().twoDateToCompare(createDate!)
                if cmps.hour >= 1{//相差一个小时以上
                    resultString = "\(cmps.hour)小时前"
                    
                }else if cmps.minute >= 1{//一小时之内
                    resultString = "\(cmps.second)分钟前"

                }else{//小于一分钟
                    resultString = "刚刚"
                }
                
            }else if ((createDate?.isYesterday()) != nil){
                //是否是昨天
                dataFormatter.dateFormat = "昨天  HH:mm:ss"
                resultString = dataFormatter.stringFromDate(createDate!)
            }else{
                //其他时间
                dataFormatter.dateFormat = "MM HH:mm:ss"
                resultString = dataFormatter.stringFromDate(createDate!)
            }
            
        }else{
            dataFormatter.dateFormat = "yyyy-MM-dd"
            print(createDate)
            resultString = dataFormatter.stringFromDate(createDate!)
        }
        
        //返回结果
        return resultString!
    }
    /**
     *  设置按钮标题
     */
    func setupButton(sender:UIButton, title:Float, placeholder:String){
        var btName:String?
        if title > 10000 {
            btName = String(format: "%.1f万",title / 10000)
        }else if title > 0{
            btName = String(format: "%.0f",title )
        }else{
            btName = placeholder
        }
        sender.setTitle(btName, forState: UIControlState.Normal)
        
    }
    /**
     *  返回cell的高度
     */
    internal func cellHeight() -> CGFloat{
        
        if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerPicture.rawValue)" {
            
            return  CGRectGetMaxY(PCView.frame) + 49.0
            
        }else if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerVoice.rawValue)" {
            
            
            
            return CGRectGetMaxY(VoiceView.frame) + 49.0
            
        }else if dataModel?.type == "\(WordTableViewControllerType.WordTableViewControllerVideo.rawValue)" {
            
            
            print(CGRectGetMaxY(VideoView.frame) + 49.0)
            return CGRectGetMaxY(VideoView.frame) + 49.0
            
        }else{
            /** 判断最热评论是否存在,返回相应的高度 */
            let Mod = dataModel?.top_cmt.first
            let height = Mod == nil ? CGRectGetMaxY(contentLabel.frame) + 49.0 : CGRectGetMaxY(contentLabel.frame) + 49.0 + HotCommentV.height
          return  height
        }
       
    }
   
    @IBAction func sender(sender: UIButton) {
        
        let ACSheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: "收藏", otherButtonTitles: "分享","1","2")
        ACSheet.showInView(self.window!)
        
        
    }

    //创建cell这里一定要创建，不要使用注册，如果注册cell的高度设置将会没用
    class func cellForTableview(tableview:UITableView, identifier:String, indexPath:NSIndexPath) -> WordTableViewCell{
        let identifier : String = identifier
        var cell = tableview.dequeueReusableCellWithIdentifier(identifier) as? WordTableViewCell
        if cell  == nil{
            cell = NSBundle.mainBundle().loadNibNamed("WordTableViewCell", owner: nil, options: nil).last as? WordTableViewCell
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        contentLabel.preferredMaxLayoutWidth = UIView.kScreenWidth() - 20
        self.autoresizingMask = UIViewAutoresizing.None
        timer.fireDate = NSDate.distantFuture()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let uimageVIEW = UIImageView()
        uimageVIEW.layer.masksToBounds = true
    }

   
}
