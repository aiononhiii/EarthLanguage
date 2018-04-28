//
//  LGFMagicTextView.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

typealias LTextLength=(_ length:Int)->Void

class LGFMagicTextView: UITextView,UITextViewDelegate {

    @IBInspectable var magicType:String = ""
    
    /// 最大输入长度
    @IBInspectable var totalMaxNumber:Int = 0
    
    /// 固定范围，从首字开始
    @IBInspectable var headerText:String = ""
    
    /// 返回输入字数
    var ReturnsTextLength:LTextLength?
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.delegate = self
        if headerText.characters.count > 0 {self.selectedRange = NSMakeRange(headerText.characters.count, 0)}
        self.text = headerText
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
                layer.cornerRadius = cornerRadius
            }
        }
    }
    
    /// 边框颜色
    @IBInspectable var borderColor:UIColor=UIColor(){
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
    @IBInspectable var shadowColor:UIColor=UIColor(){
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
    
    /// 监听删除
    override func deleteBackward() {
        super.deleteBackward()
        if self.selectedRange.location<=headerText.characters.count {
            self.text = headerText
        }
    }
    
    /// 输入字符限定
    func textViewDidChange(_ textView: UITextView) {
        if totalMaxNumber > 0 {
            if (textView.markedTextRange == nil) {
                if (textView.text.characters.count - headerText.characters.count) < 0 {
                    ReturnsTextLength!(0)
                } else if (textView.text.characters.count - headerText.characters.count) > totalMaxNumber {
                    ReturnsTextLength!(totalMaxNumber)
                } else {
                    ReturnsTextLength!(textView.text.characters.count - headerText.characters.count)
                }
            }
            if (textView.text.characters.count > (totalMaxNumber + headerText.characters.count)) {
                /// 对超出的部分进行剪切
                self.text = textView.text.substingInRange(r: 0..<(totalMaxNumber + headerText.characters.count))
            }
        }
    }
    
    
}
