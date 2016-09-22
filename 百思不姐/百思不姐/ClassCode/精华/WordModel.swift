//
//  WordModel.swift
//  百思不姐
//
//  Created by MacBook on 16/7/27.
//  Copyright © 2016年 MacBook. All rights reserved.
//

import CoreAudioKit


class WordModel: NSObject {
    var id                   = ""
    var text                 = ""
    var user_id              = ""
    var name                 = ""
    var profile_image        = ""
    var create_time          = ""
    var ding                 = ""
    var cai                  = ""
    var repost               = ""
    var comment              = ""
    var commentCount         = 0
    var sina_v : String?
    var image0               = ""
    var image1               = ""
    var image2               = ""
    var width:String?
    var height:String?
    var type:String?
    var bigPicture:Bool      = false
    var frame:CGRect         = CGRectZero
    var picProgress : Float  = 0
    var voicelength : String = ""
    var top_cmt =  [BDJComment]()
    //音频播放时长
    var voicetime  = " "
    //视屏播放时长∫
    var videotime  = " "
    
    var playcount : NSNumber  = 0
    
    static var parms : [String:String]?
    
    init(modDic:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(modDic)
    }
    class func getBlock(finshed:(title:String) ->()){
        
    }
    
    //加载网络数据
    class func loadNetworkingData(maxtime:String?,page:String?,type:String?,finshed:(responderObject:[WordModel]?,error:ErrorType?,maxtime:String?) ->()){
        var bodDic1 = [String:String]()
        bodDic1 = ["a":"list"]
        bodDic1["c"] = "data"
        //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
        bodDic1["type"] = type
        
       
        maxtime == nil ? () : (bodDic1["maxtime"] = maxtime)
        page == nil ? ():(bodDic1["page"] = page)
        parms = bodDic1
        GHQRequest.sendRequestToServer(ModelForUrl.wordUrl(), bodyDic: bodDic1, requestType: "GET") { (responseObject, error) in
            
            if parms! != bodDic1{
                return;
            }
            //判断是否成功
            if (error != nil){
                finshed(responderObject: nil, error: error, maxtime: nil)
            }else{
                if let KeXuanBangDing = responseObject as? [String : AnyObject]{
                    let dic = KeXuanBangDing["list"] as! [[String : AnyObject]]
                    let str = KeXuanBangDing["info"]!["maxtime"] as! String
                    finshed(responderObject: modelArr(dic), error: nil, maxtime: str)
                }else{
                    finshed(responderObject:nil,error:nil,maxtime: nil)
                }
                
            }
        }
    }
    
    //字典数组转换模型数组
    class func modelArr(arrayDic:[[String:AnyObject]]) -> [WordModel] {
        var arr = [WordModel]()
        for dict in arrayDic{
            let mo = WordModel(modDic: dict)
            arr.append(mo)
        }
        return arr
    }

    
    //模型赋值
    override func setValue(value: AnyObject?, forKey key: String) {

          if key == "comment" && (value!.isKindOfClass(NSNumber)){
            comment = "\(value!)"
            return;
           }

        if key == "top_cmt"{
            let dic = value as? [[String : AnyObject]]
            let MMArr = BDJComment.modelArr(dic!)
            top_cmt = MMArr
            return;
        }
        print(key)
    print(value?.classForCoder);
            super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

    }
    // 定义类属性数组
    static let properties = ["text", "id", "name","create_time","comment","repost","profile_image","ding","cai"]
    // 打印对象
    override var description: String{
        return "\(self.dictionaryWithValuesForKeys(FocusModel.properties))"
    }

    /**
     * 重写mjmodel的辅助方法
     */
    
    
    
}
