//
//  lgfPCH.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

/// ----------------------------------------------------------------------------------------------------
let TranslationArrayPath = lgf_FilePath.appendingPathComponent("TranslationArray.plist") as String;
let SelectLanguagePath = lgf_FilePath.appendingPathComponent("RealSelectLanguage.plist") as String;
let AllLanguagePath = Bundle.main.path(forResource: "Language", ofType: "plist")!
let DefaultSelectLanguagePath = Bundle.main.path(forResource: "SelectLanguage", ofType: "plist")!

let lgf_SelectLanguaged = lgf_GetSelectLanguaged()

func lgf_GetSelectLanguaged() -> NSMutableDictionary {
    let SelectLanguage = NSMutableDictionary.init(contentsOfFile: SelectLanguagePath)
    return SelectLanguage!
}

var lgf_TranslationArray = lgf_GetTranslationArray()

func lgf_GetTranslationArray() -> NSMutableArray {
    let TranslationArray = NSMutableArray.init(contentsOfFile: TranslationArrayPath)
    return TranslationArray!
}

func lgf_GetSelectPeople() -> NSMutableDictionary {
    var selectPeople = NSMutableDictionary()
    for (_, value) in lgf_GetSelectLanguaged(){
        if ((value as! NSMutableDictionary).value(forKey: "selectbool") as! String) == "true" {
            selectPeople = value as! NSMutableDictionary
        }
    }
    return selectPeople
}

/// ----------------------------------------------------------------------------------------------------

/// 沙河路径
let lgf_FilePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString

/// 通知中心
let lgf_NotificationCenter = NotificationCenter.default

/// UserDefaults持久化
let lgf_UserDefaults = UserDefaults.standard

/// 总代理
let lgf_Application = UIApplication.shared

/// Window宽高
let lgf_ScreenW = UIScreen.main.bounds.width
let lgf_ScreenH = UIScreen.main.bounds.height

/// 当前视图
var lgf_LastView:UIView = (lgf_Application.keyWindow?.rootViewController?.view)!
var lgf_LastController:UIViewController!

/// keyWindow
let lgf_KeyWindow = lgf_Application.keyWindow

/// 获取当前系统语言
let lgfCurrentLanguage = NSLocale.preferredLanguages.first

/// 获取版本号
let lgf_Version = Float(UIDevice.current.systemVersion)

/// 小菊花
var lgf_Network = lgf_Application.isNetworkActivityIndicatorVisible

/// 判断沙盒路径是否存在
func lgf_PathAlreadyExists(fileName:String) -> Bool {
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: fileName) {
        return true
    }
    return false
}

/// 由角度获取弧度
func lgf_DegreesToRadian(degrees:CGFloat) -> CGFloat {
    return CGFloat(Double.pi) * degrees / 180.0
}

/// 有弧度获取角度
func lgf_RadianToDegrees(radian:CGFloat) -> CGFloat {
    return (radian * 180.0) / CGFloat(Double.pi)
}

/// 取得对应 storyboardName 的故事版 并取得其中对应 Identifier 的视图（UIViewController）
func lgf_SBVC(storyboardName:String,Identifier:String) -> UIViewController {
    return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: Identifier);
}/// Bundle.main.loadNibNamed("LZlgfShareSDKView", owner: nil, options: nil)

/// 取得对应 NibName 的Xib 并取得其中对应 Identifier,index 的UIView
func lgf_XibView(NibName:String,index:NSInteger) -> UIView {
    return Bundle.main.loadNibNamed(NibName, owner: nil, options: nil)![index] as! UIView;
}

/// RGB颜色
func lgf_Color(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor {
    return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: (alpha))
}

/// 随机色
func lgf_RandomColor(alpha:CGFloat) -> UIColor {
    let red = CGFloat.init(arc4random()%256)/255.0
    let green = CGFloat.init(arc4random()%256)/255.0
    let blue = CGFloat.init(arc4random()%256)/255.0
    return UIColor.init(red: red, green: green, blue: blue, alpha: (alpha))
}

/// IOS系统版本判断   true : 大于等于 ，false : 小于
func lgf_IOS_VERSION(version:NSInteger) -> Bool {
    if(ProcessInfo.processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: version, minorVersion: 0, patchVersion: 0))) {return true} else {return false}
}

/// 随机颜色
func lgfRandomColor() -> UIColor {
    return UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
}

/// 16进制颜色转换
func lgf_ColorFromHex(rgb:Int,alpha:CGFloat) -> UIColor {
    return UIColor.init(red:((CGFloat)((rgb & 0xFF0000)>>16))/255.0,green:((CGFloat)((rgb & 0xFF00)>>8))/255.0,blue:((CGFloat)(rgb & 0xFF))/255.0,alpha:alpha)
}

/// 强制横屏
func lgf_CrossScreen() -> Void {
    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
}

/// 自定义Log
func LLog<content>(_ 请输入:content, file : String = #file, funcName : String = #function, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("类名:\(fileName)方法名:\(funcName)行:\(lineNumber)输出值:\(请输入)")
    #endif
}

///  弹出Alert框
func lgf_AlertShow(title:String, message:String ,lefttitle:String ,righttitle:String, lefthandler:@escaping () -> Void, righthandler:@escaping () -> Void) -> Void {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    let leftbtn:UIAlertAction = UIAlertAction.init(title: lefttitle, style: .default, handler: {
        (action: UIAlertAction) -> Void in
        lefthandler()
    })
    let rightbtn:UIAlertAction = UIAlertAction.init(title: righttitle, style: .default, handler: {
        (action: UIAlertAction) -> Void in
        righthandler()
    })
    
    leftbtn.setValue(lgf_ColorFromHex(rgb: 0xDDDDDD, alpha: 1.0), forKey: "_titleTextColor")
    rightbtn.setValue(lgf_ColorFromHex(rgb: 0xF0AE00, alpha: 1.0), forKey: "_titleTextColor")
    
    alert.addAction(leftbtn)
    alert.addAction(rightbtn)
    lgf_LastController?.present(alert, animated: true, completion: nil)
}

///  毫秒转换成可视时间
func lgf_SecondsConversion(time:AnyObject, type:String) -> String {
    
    if type == "second" {///  秒
        let minute = time.floatValue/60
        if minute>60 && minute<1440 {
            return String.init(format: "%ld小时前",Int(round(minute)/60))
        }else if minute<60 {
            return String.init(format: "%ld分钟前",Int(round(minute)))
        }else if minute>1440 {
            return String.init(format: "%ld天前",Int(round(minute)/1440))
        }else if minute==0 {
            return "刚刚"
        }
    } else if type == "millisecond" {///  毫秒
        let minute = time.floatValue/(1000*60)
        if minute>60 && minute<1440 {
            return String.init(format: "%ld小时前",Int(round(minute)/60))
        }else if minute<60 {
            return String.init(format: "%ld分钟前",Int(round(minute)))
        }else if minute>1440 {
            return String.init(format: "%ld天前",Int(round(minute)/1440))
        }else if minute==0 {
            return "刚刚"
        }
    }
    return ""
}

///  延迟执行
func lgf_After(seconds:TimeInterval, after:@escaping (() -> Void)) -> Void {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        after()
    }
}

///  滚动到底部
func lgf_ScrollToBottom(scrollview:UIScrollView) -> Void {
    scrollview.layoutIfNeeded()
    if scrollview.contentSize.height > scrollview.height {
        scrollview.setContentOffset(CGPoint.init(x: 0, y: scrollview.contentSize.height - scrollview.height), animated: true)
    }
}

/// func lgfGlobal(global: @autoclosure @escaping ()->Void) -> Void {
/// 
///     DispatchQueue.global().async{
///         global()
///     }
/// }
/// 
/// func lgfMain(main: @autoclosure @escaping ()->Void) -> Void {
///     
///     DispatchQueue.main.async {
///         main()
///     }
/// }

/// func lgfMain3(work:block) -> Void {
///     DispatchQueue.global().async{
///         work
///     }
/// }

/// func lgfMain() {
///     DispatchQueue.global().async{
///         lgfMain()
///     }
/// }

/// let GLOBAL = DispatchQueue.global().async {
/// 
///     self.label?.text = "finished"
/// 
/// }
