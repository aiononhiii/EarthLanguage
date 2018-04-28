//
//  InputTypeCell.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit
import AVFoundation

typealias ReloadAllTranslationVCTwo = () -> Void

class InputTypeCell: LGFMagicCollectionViewCell {
    
    @IBOutlet weak var inputImage: LGFMagicButton!
    var reloadAllTranslationVC:ReloadAllTranslationVCTwo?
    var SpeechInputVC:SpeechInputVC!
    var inputRecord:AVAudioRecorder!/// 录音对象
    
    /// 录音按钮按下
    @IBAction func startRecording(_ sender: LGFMagicButton) {
        if sender.tag == 0 {
            let ManualInputVC = lgf_XibView(NibName: "ManualInputVC", index: 0) as! ManualInputVC
            ManualInputVC.saveTranslationData = { (text:String) -> Void in self.saveTranslationData(translation: text, input: "manual")}
        } else if sender.tag == 1 {
            /// 调用麦克风
            lgf_MicroPhoneAuthorizationRequest(success: { (success) in
                if success {
                    /// 调用语音识别
                    lgf_SpeechRecognizerAuthorizationRequest(success: { (success) in
                        if success {
                            self.SpeechInputVC = lgf_XibView(NibName: "SpeechInputVC", index: 0) as! SpeechInputVC
                            /// 进行录制
                            AutoRecord.goRecord(record: { (record) in
                                self.inputRecord = record
                            })
                        }
                    })
                }
            })
        }
    }
    
    /// 录音按钮松开 开始语音识别
    @IBAction func stopRecording(_ sender: LGFMagicButton) {
        if sender.tag == 1 {
            /// 调用语音识别
            lgf_SpeechRecognizerAuthorizationRequest(success: { (success) in
                if success {
                    self.SpeechInputVC?.startAnalysis()
                    /// 录制结束
                    self.inputRecord?.stop()
                    /// 进行语音识别
                    AutoSpeech.goSpeech(recognition: { (result:String,success:Bool) in
                        if success {/// 成功
                            self.saveTranslationData(translation: result, input: "speech")
                        } else {/// 失败
                            self.SpeechInputVC?.speechFail()
                        }
                    })
                }
            })
        }
    }
    
    /// 保存数据
    func saveTranslationData(translation:String, input:String) -> Void {
        if Reachability()?.currentReachabilityStatus == .notReachable {
            if input == "speech" {self.SpeechInputVC?.haveNoNetwork()}
            return
        }
        
        let translationResultArray = NSMutableArray.init(contentsOfFile: TranslationArrayPath)
        let whoSay = (lgf_GetSelectPeople().value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "countryname")
        let onePeoeleDict = (lgf_SelectLanguaged.value(forKey: "oneNat") as! NSMutableDictionary).value(forKey: "languagedata") as! NSMutableDictionary
        let twoPeoeleDict = (lgf_SelectLanguaged.value(forKey: "twoNat") as! NSMutableDictionary).value(forKey: "languagedata") as! NSMutableDictionary
        let threePeoeleDict = (lgf_SelectLanguaged.value(forKey: "threeNat") as! NSMutableDictionary).value(forKey: "languagedata") as! NSMutableDictionary
        
        var languageOne:String!
        var languageTwo:String!
        var languageThree:String!
        lgf_goBaiDuTranslate(translateText: translation, toLanguage: onePeoeleDict.value(forKey: "baidulocale") as! String) { (data,messagr) in
            if data != "error" {
                languageOne = data
                lgf_goBaiDuTranslate(translateText: translation, toLanguage: twoPeoeleDict.value(forKey: "baidulocale") as! String) { (data,messagr) in
                    if data != "error" {languageTwo = data}
                    lgf_goBaiDuTranslate(translateText: translation, toLanguage: threePeoeleDict.value(forKey: "baidulocale") as! String) { (data,messagr) in
                        if data != "error" {
                            languageThree = data
                            let recordDict = NSMutableDictionary.init()
                            recordDict.setValue(languageOne, forKey: "languageone")/// 用于翻译
                            recordDict.setValue(languageTwo, forKey: "languagetwo")
                            recordDict.setValue(languageThree, forKey: "languagethree")
                            recordDict.setValue(onePeoeleDict, forKey: "onepeoeledict")/// 用于语音播报,信息显示等
                            recordDict.setValue(twoPeoeleDict, forKey: "twopeoeledict")
                            recordDict.setValue(threePeoeleDict, forKey: "threepeoeledict")
                            recordDict.setValue(whoSay, forKey: "whosay")
                            recordDict.setValue(Date().lgf_DateToStr(fromeFormat: "yyyy年M月d日 H点mm分ss秒"), forKey: "nowtime")
                            translationResultArray?.add(recordDict)
                            translationResultArray?.write(toFile: TranslationArrayPath, atomically: true)
                            if input == "speech" {
                                self.SpeechInputVC?.speechSuccess()
                            } else {
                                
                            }
                            self.reloadAllTranslationVC!()
                        }
                    }
                }
            } else {
                if input == "speech" {
                    self.SpeechInputVC?.haveNoNetwork()
                } else {
                    LGFMBHud.showMessage(message: messagr, after: 1.0)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
