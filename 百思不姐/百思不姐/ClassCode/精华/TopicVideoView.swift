//
//  TopicVideoView.swift
//  百思不姐
//
//  Created by MacBook on 16/9/9.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class TopicVideoView: UIView {

   
    
    @IBOutlet var backImage: UIImageView!
    @IBOutlet var playCL: UILabel!
    
    @IBOutlet var playTC: UILabel!
    
    
    @IBOutlet var sender: UIButton!
    
    
    var dataModel : WordModel?{
        didSet{
            //可选绑定
            if let url = dataModel?.image2  {
                backImage.sd_setImageWithURL(NSURL(string: url))
            }
            
            if let play = dataModel?.playcount {
                playCL.text = String(play)
            }
            if let leng = Int((dataModel?.voicetime)!){
                
                let minute:NSInteger = leng / 60
                let second:NSInteger = leng % 60
                
                playTC.text = String(format: "%02ld:%02ld", minute,second)
            }
            /**
             *  playCount.text = String(dataModel?.playcount).optionlBinding()
             *hadPlayTime.text = dataModel?.voicelength.optionlBinding()
             */
            
            
        }
    }

    
    
    @IBAction func sender(sender: UIButton) {
        
        
    }
    class func  VoiceView() -> TopicVideoView{
        if let view = NSBundle.mainBundle().loadNibNamed("TopicVideoView", owner: nil, options: nil).last as? TopicVideoView{
            return view
        }
        return TopicVideoView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = UIViewAutoresizing.None
    }

    
    
    
}
