//
//  LGFAFNTool.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/19.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

/// 枚举定义请求方式
enum HTTPRequestType : Int {
    case GET
    case POST
}

final class LGFAFNTool: AFHTTPSessionManager {
    
    /// 单例
    static let shared :LGFAFNTool = {
        
        let tools = LGFAFNTool()
        /// 设置超时时间
        tools.requestSerializer.timeoutInterval = 5.0
        tools.responseSerializer.stringEncoding = String.Encoding.utf8.rawValue
        /// 这是给JSON序列化加一个格式
        tools.responseSerializer.acceptableContentTypes? = NSSet.init(objects: "application/json", "text/html", "text/json","text/javascript","text/plain") as! Set<String>
        return tools
    }()
    
    /// 封装GET和POST 请求
    /// - Parameters:
    /// - requestType: 请求方式
    /// - urlString: urlString
    /// - parameters: 字典参数
    /// - completion: 回调
    func request(requestType: HTTPRequestType, urlString: String, parameters: AnyObject, success: @escaping ((AnyObject?) -> Void), failure: @escaping (() -> Void)) {
        lgf_Network = true
//        LGFMBHud.hideHud()
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            success(json as AnyObject?)
            lgf_Network = false
        }
        
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            failure()
            lgf_Network = false
        }
        
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }

}
