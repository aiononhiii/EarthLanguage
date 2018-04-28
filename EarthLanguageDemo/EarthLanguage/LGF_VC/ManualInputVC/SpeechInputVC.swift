//
//  SpeechInputVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/12.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class SpeechInputVC: UIView {

    @IBOutlet weak var listenImage: UIImageView!
    @IBOutlet weak var speechInputView: LGFMagicView!
    @IBOutlet weak var helpTitle: UILabel!
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = (lgf_LastView.bounds)
        lgf_LastView.addSubview(self)
//        self.timeoutLB.text = "10"
    }
    
    //／ 开始录音
    func startLsion() -> Void {
        self.listenImageRemoveAnimation()
        self.helpTitle.text = "我在听哦"

        self.listenImage.animationImages = [UIImage.init(named: "listen_one")!, UIImage.init(named: "listen_two")!]
        self.listenImage.animationDuration = 1.0
        self.listenImage.animationRepeatCount = Int.max
        self.listenImage.startAnimating()
        
        self.speechInputView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.2) { 
            self.speechInputView.transform = CGAffineTransform.identity
        }
    }
    
    /// 开始解析
    func startAnalysis() -> Void {
        
        self.listenImageRemoveAnimation()
        self.helpTitle.text = "翻译中..."
        
        self.listenImage.image = UIImage.init(named: "in_load")

//        self.timeout = XTimer.scheduledTimer(withTimeInterval: 1.0, target: self, selector: #selector(timeOut), userInfo: nil, repeats: true)!
//        self.timeout.reStart()
        /// 转圈动画
        lgf_TurnAnimation(view: self.listenImage, duration: 1.0) {}
    }
    
//    func timeOut() -> Void {
//        self.timeoutLB.alpha = 1.0
//        self.timeoutLB.text = String.init(Int.init(self.timeoutLB.text!)! - 1)
//        if self.timeoutLB.text == "0" {
//            self.timeout.stop()
//            self.timeout.invalidate()
//        }
//
//    }
    
    /// 解析失败
    func speechFail() -> Void {
        self.listenImageRemoveAnimation()
        self.helpTitle.text = "没听清楚"
        self.listenImage.image = UIImage.init(named: "speech_fail_two")
        
        self.listenImage.animationImages = [UIImage.init(named: "speech_fail_one")!, UIImage.init(named: "speech_fail_two")!]
        self.listenImage.animationDuration = 1.0
        self.listenImage.animationRepeatCount = 1
        self.listenImage.startAnimating()
        
        lgf_ShakeAnimation(view:self, duration: 0.08, range: 20) {
            lgf_After(seconds: 1.0, after: {
                self.removeSpeechInputVC()
            })
        }
    }
    
    /// 解析成功
    func speechSuccess() -> Void {
        self.listenImageRemoveAnimation()
        self.helpTitle.text = ""

        self.listenImage.image = UIImage.init(named: "speech_success")
        
        lgf_JellyAnimation(view: self, duration: 0.1, range: 1.2) { 
            lgf_After(seconds: 0.5, after: {
                self.removeSpeechInputVC()
            })
        }
    }
    
    /// 没有网络
    func haveNoNetwork() -> Void {
        self.listenImageRemoveAnimation()
        self.helpTitle.text = "请打开网络"
        
        self.listenImage.image = UIImage.init(named: "speech_fail")
        
        self.listenImage.animationImages = [UIImage.init(named: "have_no_net_one")!, UIImage.init(named: "have_no_net_two")!]
        self.listenImage.animationDuration = 0.7
        self.listenImage.animationRepeatCount = Int.max
        self.listenImage.startAnimating()
        
        lgf_ShakeAnimation(view:self, duration: 0.08, range: 20) {
            lgf_After(seconds: 1.0, after: {
                self.removeSpeechInputVC()
            })
        }
    }
    
    /// 删除所有动画
    func listenImageRemoveAnimation() -> Void {
        self.listenImage.stopAnimating()
        self.listenImage.layer.removeAllAnimations()
        self.transform = CGAffineTransform.identity
    }
    
    /// 删除整个view
    func removeSpeechInputVC() -> Void {
        lgf_ZoomOut(view: self.speechInputView, duration: 0.3, range: 2.0) {
            self.removeFromSuperview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.speechInputView.shadowColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
        self.startLsion()
    }
    
    
    
    deinit {
        self.listenImage.stopAnimating()
    }
}
