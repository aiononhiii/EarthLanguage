//
//  AutoSpeech.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import Speech
import UIKit

class AutoSpeech: SFSpeechRecognizer {
    
    static func goSpeech(recognition:@escaping ((_ result:String, _ success:Bool) -> Void)) -> Void {

        let avIdentifier:String = (lgf_GetSelectPeople().value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "ioslocale") as! String

        DispatchQueue.global().async {
            /// 创建语音识别操作类对象
            let speechRecognizer:SFSpeechRecognizer = SFSpeechRecognizer.init(locale: Locale.init(identifier: avIdentifier))!
            
            /// 通过一个音频路径创建音频识别请求
            let request:SFSpeechRecognitionRequest = SFSpeechURLRecognitionRequest.init(url: URL(fileURLWithPath: (lgf_FilePath as String) + "/EarthLanguage.m4a"))
            do {try AVAudioSession.sharedInstance().setActive(false)} catch {}
            /// 进行请求
            speechRecognizer.recognitionTask(with: request) { (result, error) in
                DispatchQueue.main.async {
                    if result?.isFinal == true && ((result?.bestTranscription.formattedString)?.isEmpty == false) {
                        recognition((result?.bestTranscription.formattedString)!, true)
                        LLog("语音录入成功:" + (result?.bestTranscription.formattedString)!)
                    } else {
                        if (result?.bestTranscription.formattedString == nil) {
                            recognition("没听清楚", false)
                            LLog("没听清楚")
                        }
                    }
                }
            }
        }
    }
}
