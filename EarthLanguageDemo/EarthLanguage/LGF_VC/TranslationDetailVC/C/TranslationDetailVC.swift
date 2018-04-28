//
//  TranslationDetailVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

typealias TranslationDetailSpeekStart = () -> Void
typealias TranslationDetailSpeekEnd = () -> Void

class TranslationDetailVC: UIViewController {
    
    var SpeekStart:TranslationDetailSpeekStart?
    var SpeekEnd:TranslationDetailSpeekEnd?
    @IBOutlet weak var translation: UITextView!
    @IBOutlet weak var copyButton: LGFMagicButton!
    @IBOutlet weak var speekButton: LGFMagicButton!
    @IBOutlet weak var hideButton: LGFMagicButton!
    var magicInfo: Dictionary<String, String>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.translation.text = self.magicInfo["title"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = self.view.hitTest(((touches as NSSet).anyObject() as AnyObject).location(in: self.view), with: event)!
        if view != self.speekButton || view != self.copyButton {
            self.hideFlagSelectionVC(audiobool: false)
        }
    }

    @IBAction func hideView(_ sender: Any) {
        self.hideFlagSelectionVC(audiobool: false)
    }
    
    @IBAction func copySelect(_ sender: Any) {
        self.goCopyText()
        self.hideFlagSelectionVC(audiobool: false)
    }
    
    @IBAction func speekSelect(_ sender: Any) {
        self.goSpeek()
    }
    
    override var previewActionItems : [UIPreviewActionItem] {
        
        let item1 = UIPreviewAction.init(title: "复制该条文字", style: .default) { (_, _) in
            self.goCopyText()
        }
        
        let item2 = UIPreviewAction.init(title: "朗读该条文字", style: .default) { (_, _) in
            self.goSpeek()
        }
        
        return [item1, item2]
    }
    
    /// 朗读文字
    func goSpeek() {
        AutoSpeak.sharedSpeak.goSpeak(text: self.magicInfo["title"]!, locale: self.magicInfo["ioslocale"]!)
        AutoSpeak.sharedSpeak.speekEnd = {
            self.SpeekEnd!()
            self.translation.attributedText = self.initAttributedString() as NSAttributedString
        }
        AutoSpeak.sharedSpeak.speekStart = {
            self.SpeekStart!()
        }
        AutoSpeak.sharedSpeak.speekRange = { (range) in
            
            DispatchQueue.global().async {
                let str = self.initAttributedString()
                str.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: range)
                let newstr = str as NSAttributedString
                DispatchQueue.main.async {
                   self.translation.attributedText = newstr
                }
            }
        }
    }
    
    func initAttributedString() -> NSMutableAttributedString {
        let str = NSMutableAttributedString.init(string: self.magicInfo["title"]!)
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, str.length))
        str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 25), range: NSMakeRange(0, str.length))
        return str
    }
    
    /// 拷贝文字
    func goCopyText() {
        let pab = UIPasteboard.general
        pab.string = self.magicInfo["title"]!
        LGFMBHud.showMessage(message: "已经成功为您复制", after: 1.0)
    }

    /// 隐藏动画
    func hideFlagSelectionVC(audiobool:Bool) -> Void {
        self.dismiss(animated: true, completion: {
        })
    }
}
