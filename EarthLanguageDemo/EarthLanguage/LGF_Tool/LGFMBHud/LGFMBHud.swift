//
//  LGFMBHud.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/19.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class LGFMBHud: MBProgressHUD {
    
    static func showMessage(message:String, after:TimeInterval) -> Void {
        let HUD:MBProgressHUD = MBProgressHUD.showAdded(to: lgf_LastView, animated: true)
        HUD.label.text = message
        HUD.bezelView.backgroundColor = UIColor.white
        HUD.bezelView.layer.borderWidth = 1.0
        HUD.bezelView.layer.borderColor = UIColor.lightGray.cgColor
        HUD.label.textColor = UIColor.black
        HUD.label.font = UIFont.init(name: "Helvetica-Light", size: 15.0)
        HUD.isUserInteractionEnabled = false
        HUD.mode = .text
        HUD.removeFromSuperViewOnHide = true
        HUD.hide(animated: true, afterDelay: after)
    }
    
    static func showHud(in view: UIView, hint: String) -> Void {
        let HUD:MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.label.text = hint
        HUD.label.font = UIFont.systemFont(ofSize: 13.0)
        //设为false后点击屏幕其他地方有反应
        HUD.isUserInteractionEnabled = true
        //HUD内的内容的颜色
        HUD.contentColor = UIColor.black
        //View的颜色
        HUD.bezelView.color = UIColor.init(r: 240.0, g: 240.0, b: 240.0)
        //style -blur 不透明 －solidColor 透明
        HUD.bezelView.style = .solidColor
        view.addSubview(HUD)
    }
    
    static func hideHud(in view: UIView) -> Void {
        MBProgressHUD.hide(for: view, animated: false)
    }

}
