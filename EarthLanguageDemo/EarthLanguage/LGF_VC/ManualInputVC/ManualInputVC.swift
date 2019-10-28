//
//  ManualInputVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/12.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

typealias SaveTranslationData = (_ text:String) -> Void

class ManualInputVC: UIView,UITextFieldDelegate {

    @IBOutlet weak var ManualInputTextTop: NSLayoutConstraint!
    @IBOutlet weak var ManualInputText: UITextField!
    @IBOutlet weak var ManualInputView: LGFMagicView!
    @IBOutlet weak var Flag: LGFMagicImageView!
//    @IBOutlet weak var whoSay: LGFMagicLabel!
    
    var saveTranslationData:SaveTranslationData?
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = (lgf_LastView.bounds)
        lgf_LastView.addSubview(self)
        lgf_NotificationCenter.addObserver(self, selector: #selector(self.keyBoardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        lgf_NotificationCenter.addObserver(self, selector: #selector(self.keyBoardWillHide(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Flag.image = UIImage.init(named: (lgf_GetSelectPeople().value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "imagename") as! String)
//        self.whoSay.text = (lgf_GetSelectPeople().value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "countryname") as? String
        self.ManualInputView.shadowColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
        self.ManualInputText.tintColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
        lgf_After(seconds: 0.05) { self.ManualInputText.becomeFirstResponder() }
    }
    
    /// 键盘的出现
    func keyBoardWillShow(note: Notification){
        let  keyBoardBounds = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.ManualInputTextTop.constant = lgf_ScreenH - keyBoardBounds.height - 105
        self.layoutIfNeeded()
//        self.backgroundColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 0.1)
    }
    
    /// 键盘的隐藏
    func keyBoardWillHide(note: Notification){
        self.ManualInputTextTop.constant = -100
        self.layoutIfNeeded()
//        self.backgroundColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 0.0)
        lgf_After(seconds: note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) { self.removeFromSuperview() }
    }
    
    /// 隐藏手动输入view
    @IBAction func hideManualInputVC(_ sender: Any) {
        self.ManualInputText.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let notEmptyStr = textField.text?.replacingOccurrences(of: " ", with: "")
        if notEmptyStr == "" {
            self.ManualInputText.placeholder = "翻译文字不能为空～"
            return false
        }
        if Reachability()?.currentReachabilityStatus == .notReachable{
            self.ManualInputText.text = ""
            self.ManualInputText.placeholder = "亲,当前没网络"
            return false
        }
        self.saveTranslationData!(notEmptyStr!)
        self.ManualInputText.resignFirstResponder()
        return true
    }
    

}
