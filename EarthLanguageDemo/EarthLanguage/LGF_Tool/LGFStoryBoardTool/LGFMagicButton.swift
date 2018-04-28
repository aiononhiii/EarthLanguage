//
//  LGFMagicButton.swift
//  swift_tool
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 laiguofeng. All rights reserved.
//

import UIKit

class LGFMagicButton: UIButton {
    
    @IBInspectable var magicType:String = ""
    
    var MagicInfo:Dictionary = [String: String]()
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.addTarget(self, action: #selector(SpecialTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(SpecialTouchOut), for: .touchUpOutside)
        self.addTarget(self, action: #selector(SpecialTouchOut), for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if cornerRadius == 333 {
            layer.cornerRadius = self.frame.size.height / 2;
        }
    }
    
    func SpecialTouchDown() -> Void {
        if self.transformnum > 0 {
            self.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.init(scaleX: self.transformnum, y: self.transformnum)
            }
        }
    }
    
    func SpecialTouchOut() -> Void {
        if self.transformnum > 0 {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    /// 设置按钮动画 0 无动画
    @IBInspectable var transformnum:CGFloat = 0.0
    
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
