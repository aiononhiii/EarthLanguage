//
//  AutoSpeak.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import AVFoundation
import UIKit

typealias AutoSpeakSpeekStart = () -> Void
typealias AutoSpeakSpeekEnd = () -> Void
typealias AutoSpeakSpeekRange = (NSRange) -> Void

class AutoSpeak: AVSpeechSynthesizer,AVSpeechSynthesizerDelegate {
    
    /// 初始化 AutoSpeak 单列
    static let sharedSpeak = AutoSpeak()
    
    var speekStart:AutoSpeakSpeekStart?
    var speekEnd:AutoSpeakSpeekEnd?
    var speekRange:AutoSpeakSpeekRange?
    
    /// 开始播报
    func goSpeak(text:String, locale:String) -> Void {
        if AutoSpeak.sharedSpeak.isSpeaking {
            AutoSpeak.sharedSpeak.stopSpeaking(at: AVSpeechBoundary.word)
        }
        AutoSpeak.sharedSpeak.delegate = AutoSpeak.sharedSpeak
        do{try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)}catch{}
        do{try AVAudioSession.sharedInstance().setActive(true)}catch{}
        
        if text != "" {
            let volumSliderValue:Float = AVAudioSession.sharedInstance().outputVolume
            if volumSliderValue < 0.5 {
                LGFMBHud.showMessage(message: "手机音量很轻哦～", after: 1.0)
            }
            
            //输出内容
            let utterance:AVSpeechUtterance = AVSpeechUtterance.init(string: text)
            //语言种类
            utterance.voice = AVSpeechSynthesisVoice.init(language: locale)
            //语音输出参数设置 列如 ：男声，女声等等
            utterance.rate = lgf_UserDefaults.float(forKey: "rate_value")/// 语速 0.0～1.0
            utterance.pitchMultiplier = lgf_UserDefaults.float(forKey: "pitchMultiplier_value")/// 声调 0.5～2.0
            utterance.postUtteranceDelay = 0.0/// 延迟
            utterance.volume = 1.0 /// 音量 0.0~1.0
            
            AutoSpeak.sharedSpeak.speak(utterance)
        }
        
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        AutoSpeak.sharedSpeak.speekEnd!()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        AutoSpeak.sharedSpeak.speekStart!()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        AutoSpeak.sharedSpeak.speekRange!(characterRange)
        LLog(utterance.speechString.substingInRange(r: characterRange.toRange()!))
    }
    

}
