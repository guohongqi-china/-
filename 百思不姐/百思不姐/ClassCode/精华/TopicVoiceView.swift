//
//  TopicVoiceView.swift
//  百思不姐
//
//  Created by MacBook on 16/9/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import UIKit

class TopicVoiceView: UIView {
 
    
    @IBOutlet var backImage: UIImageView!
    @IBOutlet var playCount: UILabel!
    
    @IBOutlet var hadPlayTime: UILabel!
    
    @IBOutlet var playBt: UIButton!
    var dataModel : WordModel?{
        didSet{
            //可选绑定
            if let url = dataModel?.image2  {
                backImage.sd_setImageWithURL(NSURL(string: url))
            }
            
            if let play = dataModel?.playcount {
                playCount.text = String(play)
            }
            if let leng = Int((dataModel?.voicetime)!){
                
                let minute:NSInteger = leng / 60
                let second:NSInteger = leng % 60

                hadPlayTime.text = String(format: "%02ld:%02ld", minute,second)
            }
            /**
             *  playCount.text = String(dataModel?.playcount).optionlBinding()
             *hadPlayTime.text = dataModel?.voicelength.optionlBinding()
             */

            
        }
    }
    
    @IBAction func playBtAction(sender: UIButton) {
    }
   class func  VoiceView() -> TopicVoiceView{
    if let view = NSBundle.mainBundle().loadNibNamed("TopicVoiceView", owner: nil, options: nil).last as? TopicVoiceView{
        return view
    }
    return TopicVoiceView()
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = UIViewAutoresizing.None
    }
    
}
