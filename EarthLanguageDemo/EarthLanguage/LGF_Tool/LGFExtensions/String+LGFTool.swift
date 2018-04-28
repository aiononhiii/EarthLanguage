//
//  String+Handle.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 字符串时间 格式化转 字符串时间
    func lgf_StrDateToStrDate(fromeFormat:String, toFormat:String) -> String {
        
        let fFormat = DateFormatter.init()
        fFormat.timeZone = NSTimeZone.system
        fFormat.locale = NSLocale.system
        fFormat.dateFormat = fromeFormat
        
        let tFormat = DateFormatter.init()
        tFormat.timeZone = NSTimeZone.system
        tFormat.locale = NSLocale.system
        tFormat.dateFormat = toFormat
        
        return fFormat.string(from: tFormat.date(from: self)!)
    }
    
    /// 字符串时间 转 时间（date）
    func lgf_StrToDate(fromeFormat:String) -> Date {
        
        let fFormat = DateFormatter.init()
        fFormat.timeZone = NSTimeZone.system
        fFormat.locale = NSLocale.system
        fFormat.dateFormat = fromeFormat
        
        return fFormat.date(from: self)!
    }
    
    /// 将十六进制颜色转换为UIColor
    func lgf_UIColor(alpha:CGFloat) -> UIColor {
        /// 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        /// 分别转换进行转换
        Scanner(string: self[0..<2]).scanHexInt32(&red)
        
        Scanner(string: self[2..<4]).scanHexInt32(&green)
        
        Scanner(string: self[4..<6]).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }

    /// 去掉首尾空格
    var lgf_RemoveHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去掉首尾空格 包括后面的换行 \n
    var lgf_RemoveHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去掉所有空格
    var lgf_RemoveAllSapce:String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    /// 去掉首尾空格 后 指定开头空格数
    func lgf_BeginSpaceNum(num:Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.lgf_RemoveHeadAndTailSpacePro
    }
    
    /// 是否是邮件地址
    func lgf_IsEmail() -> Bool {
        let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 是否是手机号
    func lgf_IsIphoneNum() -> Bool {
        let regex = "1\\d{10}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 是否是邮政编码
    func lgf_IszipCode() -> Bool {
        let regex = "[1-9]\\d{5}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 是否是身份证号
    func lgf_IsIdNum() -> Bool {
        let regex = "\\d{15}(\\d\\d[0-9xX])?"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }

    /// 是否是汉字
    func lgf_IsChinese() -> Bool {
        let regex = "[\\u4e00-\\u9fa5]"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 是否是 url
    func lgf_IsURL() -> Bool {
        let regex = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 是否是 名字
    func lgf_IsUsername() -> Bool {
        let regex = "^[a-z0-9_-]{4,16}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: self)
        return isValid
    }
    
    /// 字符串截取
    /// 获取子字符串
    func substingInRange(r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.characters.count{
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return self.substring(with:startIndex..<endIndex)
    }

    /// 获得MD5字符串
    func lgf_MD5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(16)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
        
    }
    
    /// 支付宝转码
    func urlEncodedString(string : NSString) -> NSString {
        let encodeString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, string, nil, "!*'();:@&=+$,/?%#[]" as CFString, CFStringGetSystemEncoding())

        return encodeString!
    }

}
