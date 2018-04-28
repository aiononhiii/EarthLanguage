//
//  LGFMagicVisualEffectView.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/13.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class LGFMagicVisualEffectView: UIVisualEffectView {

    @IBInspectable var magicType:String = ""
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if cornerRadius == 333 {
            layer.cornerRadius = self.frame.size.height / 2;
        }
    }
    
    /// 设置圆角
    @IBInspectable var cornerRadius:CGFloat = 0.0 {
        didSet{
            if cornerRadius != 333 {
                layer.cornerRadius = cornerRadius;
            }
        }
    }
    
    /// 边框颜色
    @IBInspectable var borderColor:UIColor = UIColor() {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// 设置边框宽度
    @IBInspectable var borderWidth:CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    /// 设置阴影颜色
    @IBInspectable var shadowColor:UIColor = UIColor() {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    /// 设置阴影圆角
    @IBInspectable var shadowRadius:CGFloat = 0.0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    /// 设置阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    @IBInspectable var shadowOffset:CGSize = CGSize() {
        didSet{
            layer.shadowOffset = shadowOffset
        }
    }
    
    /// 设置阴影透明度
    @IBInspectable var shadowOpacity:Float = 0.0 {
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }

}
