//
//  Date+LGFTool.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/12.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import Foundation

extension Date {
    
    /// 时间（date 转 字符串时间
    func lgf_DateToStr(fromeFormat:String) -> String {
        
        let fFormat = DateFormatter.init()
        fFormat.timeZone = NSTimeZone.system
        fFormat.locale = NSLocale.system
        fFormat.dateFormat = fromeFormat
        
        return fFormat.string(from: self)
    }
    
}
