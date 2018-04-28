//
//  HelpVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/14.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

typealias HelpVCReloadAllTranslationVC = () -> Void

class HelpVC: UIView {
    @IBOutlet weak var showLocal: UISwitch!
    @IBOutlet weak var showTime: UISwitch!
    @IBOutlet weak var rate: UISlider!
    @IBOutlet weak var pitchMultiplier: UISlider!
    @IBOutlet weak var prompt: UILabel!
    var reloadAllTranslationVC:HelpVCReloadAllTranslationVC?
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = (lgf_LastView.bounds)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rate.value = lgf_UserDefaults.float(forKey: "rate_value")
        pitchMultiplier.value = lgf_UserDefaults.float(forKey: "pitchMultiplier_value")
        showLocal.isOn = lgf_UserDefaults.bool(forKey: "show_local_on")
        showTime.isOn = lgf_UserDefaults.bool(forKey: "show_time_on")
        
//        LGFAFNTool.shared.request(requestType: .POST, urlString: "https://1.yingwufanyi.applinzi.com/getprompt.php", parameters:  [String:Any]() as AnyObject, success: { (success) in
//            
////            let dict = JSON(data:data)
//            LLog(success)
//        }) {
//            LLog("失败")
//        }
        prompt.text = "欢迎使用鹦鹉翻译"
    }
    
    @IBAction func rateSlider(_ sender: UISlider) {
        lgf_UserDefaults.set(sender.value, forKey: "rate_value")
    }

    @IBAction func pitchMultiplierSlider(_ sender: UISlider) {
        lgf_UserDefaults.set(sender.value, forKey: "pitchMultiplier_value")
    }
    
    @IBAction func showLocalSelect(_ sender: UISwitch) {
        lgf_UserDefaults.set(sender.isOn, forKey: "show_local_on")
    }
    
    @IBAction func showTimeSelect(_ sender: UISwitch) {
        lgf_UserDefaults.set(sender.isOn, forKey: "show_time_on")
    }
    
    @IBAction func hideHelpVC(_ sender: LGFMagicButton) {
        lgf_ZoomOut(view: self, duration: 0.2, range: 1.0) {
            self.removeFromSuperview()
            self.reloadAllTranslationVC!()
        }
    }
}
