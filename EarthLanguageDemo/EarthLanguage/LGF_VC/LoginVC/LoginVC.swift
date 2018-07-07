//
//  LoginVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/15.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if lgf_UserDefaults.bool(forKey: "login_bool") {
            
        } else {
            /// 一些默认值设置
            lgf_UserDefaults.set(0.5, forKey: "rate_value")
            lgf_UserDefaults.set(1.0, forKey: "pitchMultiplier_value")
            
            lgf_UserDefaults.set(false, forKey: "show_local_on")
            lgf_UserDefaults.set(false, forKey: "show_time_on")
            
            
            let translationDefaultData :NSMutableArray = []
            translationDefaultData.write(toFile: TranslationArrayPath, atomically: true)
            
            let selectLanguageDefaultData:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: DefaultSelectLanguagePath)!
            selectLanguageDefaultData.write(toFile: SelectLanguagePath, atomically: true)
        }
        
        AutoSpeak.sharedSpeak.goSpeak(text: "", locale: "")
        AutoSpeak.sharedSpeak.speekEnd = {}
        AutoSpeak.sharedSpeak.speekStart = {}
        AutoSpeak.sharedSpeak.speekRange = { (range) in }
        lgf_After(seconds: 1.5) {
            self.performSegue(withIdentifier: "AllTranslationVCPush", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
