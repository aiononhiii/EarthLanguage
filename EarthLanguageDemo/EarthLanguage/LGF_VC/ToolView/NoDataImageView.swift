//
//  NoDataImageView.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class NoDataImageView: UIView {

    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = CGRect.init(x: 0, y: 0, width: lgf_ScreenW, height: lgf_ScreenH * 0.7)
        lgf_LastView.addSubview(self)
    }
    
    func AutoHaveDataJudge(count:Int, superview:UIView) -> Void {
        if count > 0 {
            for view in superview.subviews {
                if view.isKind(of: NoDataImageView.classForCoder()) {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
}
