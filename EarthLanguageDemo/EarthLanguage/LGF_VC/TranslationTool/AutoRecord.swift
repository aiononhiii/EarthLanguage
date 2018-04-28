//
//  AutoRecord.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import AVFoundation
import UIKit

class AutoRecord: AVAudioRecorder {
    
    /// 录音基本参数
    static let recordSetting:Dictionary = {
        return [AVFormatIDKey:NSNumber.init(value: kAudioFormatMPEG4AAC),/// 设置录音格式
            AVSampleRateKey:NSNumber.init(value: 44100),/// 设置录音采样率
            AVNumberOfChannelsKey:NSNumber.init(value: 1),/// 录音通道数1或2
            AVLinearPCMBitDepthKey:NSNumber.init(value: 16),/// 线性采样位数8、16、24、32
            AVEncoderAudioQualityKey:NSNumber.init(value: 0x60)]/// 录音的质量
    }()
    
    /// 录音储存地址
    static let url = URL(fileURLWithPath: (lgf_FilePath as String) + "/EarthLanguage.m4a")
    
    /// 开始录音
    class func goRecord(record:@escaping ((AVAudioRecorder) -> Void)) -> Void {
        /// 异步录制
        DispatchQueue.global().async {
            /// 关闭其他音乐
            do {try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryRecord)} catch {}
            do {try AVAudioSession.sharedInstance().setActive(true)} catch {}
            /// 录音
            do {let sharedRecord:AutoRecord = try AutoRecord(url: url, settings: recordSetting as [String : Any])
                sharedRecord.isMeteringEnabled = true;
                DispatchQueue.main.async {
                    if sharedRecord.prepareToRecord() == true {/// 录音成功
                        sharedRecord.record()
                        record(sharedRecord);
                    } else {
                        LLog("录音失败")
                    }
                }
            } catch {}
            
        }
        
    }
}
