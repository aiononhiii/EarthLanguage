//
//  BaiDuTranslateAPI.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import Foundation

func lgf_goBaiDuTranslate(translateText:String, toLanguage:String, dataReturn:@escaping ((_ text:String,_ messagr:String) -> Void)) -> Void {
    
    let parameters:Dictionary = ["q":translateText,
                                 "from":"auto",
                                 "to":toLanguage,
                                 "appid":"20161213000033934",
                                 "salt":"1435660283",
                                 "sign":String.init(format: "20161213000033934%@14356602836mR5R5Fj6mj2q9lH5a4i", translateText).lgf_MD5()]
     
    LGFAFNTool.shared.request(requestType: .GET, urlString: baiduurl, parameters: parameters as AnyObject, success: { (successdata) in
        let requestDict:NSDictionary = successdata as! NSDictionary
        if requestDict.value(forKey: "error_code") != nil {
//            let errercode = requestDict.value(forKey: "error_code") as! String
//            if errercode == "54004" {
//                LGFMBHud.showMessage(message: "免费译量已经用完，下月继续免费，请支持作者", after: 1.0)
//            } else if errercode == "54003" {
//                LGFMBHud.showMessage(message: "请求过于频繁，请稍后再试", after: 1.0)
//            } else if errercode == "52002" {
//                LGFMBHud.showMessage(message: "系统错误", after: 1.0)
//            } else if errercode == "54001" {
//                LGFMBHud.showMessage(message: "请求超时，请检查网络", after: 1.0)
//            }
            dataReturn("error", "系统错误")
        } else {  
            dataReturn((((requestDict.value(forKey: "trans_result") as! Array<Any>).first as! Dictionary))["dst"]! as String, "")
        }
        
    }, failure: {
        dataReturn("error", "请求超时，请检查网络")
    })

}
