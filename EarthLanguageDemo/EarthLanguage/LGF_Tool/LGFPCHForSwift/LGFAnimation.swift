//
//  LGFAnimation.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/13.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

//UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
//UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
//UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
//UIViewAnimationOptionRepeat：重复运行动画。
//UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
//UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
//UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
//UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
//UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
//UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
//2.动画速度控制（可从其中选择一个设置）
//UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
//UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
//UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
//UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
//3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
//UIViewAnimationOptionTransitionNone：没有转场动画效果。
//UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
//UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
//UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
//UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
//UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
//UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
//UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。


//duration：动画从开始到结束的持续时间，单位是秒
//delay：动画开始前等待的时间
//options：动画执行的选项。里面可以设置动画的效果。可以使用UIViewAnimationOptions类提供的各种预置效果
//anmations：动画效果的代码块
//completion：动画执行完毕后执行的代码块

import Foundation
import UIKit

/// 抖动动画
func lgf_ShakeAnimation(view:UIView, duration:TimeInterval, range:CGFloat, end:@escaping (() -> Void)) -> Void {
    view.transform = CGAffineTransform.identity
    UIView.animate(withDuration: duration, animations: {
        view.transform = CGAffineTransform.init(translationX: range, y: 0)
    }) { (finish) in
        UIView.animate(withDuration: duration, animations: {
            view.transform = CGAffineTransform.init(translationX: -range, y: 0)
        }) { (finish) in
            UIView.animate(withDuration: duration, animations: {
                view.transform = CGAffineTransform.init(translationX: range, y: 0)
            }) { (finish) in
                UIView.animate(withDuration: duration, animations: {
                    view.transform = CGAffineTransform.identity
                }) { (finish) in
                    end()
                }
            }
        }
    }
}

/// 果冻动画（小）
func lgf_JellyAnimation(view:UIView, duration:TimeInterval, range:CGFloat, end:@escaping (() -> Void)) -> Void {
    view.transform = CGAffineTransform.identity
    UIView.animate(withDuration: duration, animations: {
        view.transform = CGAffineTransform.init(scaleX: range, y: range)
    }) { (finish) in
        UIView.animate(withDuration: duration, animations: {
            view.transform = CGAffineTransform.identity
        }) { (finish) in
            end()
        }
    }
}

/// 变成一条线
func lgf_IntoThread(view:UIView, duration:TimeInterval, end:@escaping (() -> Void)) -> Void {
    view.transform = CGAffineTransform.identity
    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
        view.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.001)
    }) { (finish) in
        UIView.animate(withDuration: duration * 4, delay: 0.0, options: .curveEaseInOut, animations: {
            view.alpha = 0.0
        }) { (finish) in
            end()
        }
    }
}

/// 放大消失
func lgf_ZoomOut(view:UIView, duration:TimeInterval, range:CGFloat, end:@escaping (() -> Void)) -> Void {
    view.transform = CGAffineTransform.identity
    UIView.animate(withDuration: duration, animations: {
        view.alpha = 0.0
        view.transform = CGAffineTransform.init(scaleX: range, y: range)
    }) { (finish) in
        end()
    }
}

/// 转圈动画
func lgf_TurnAnimation(view:UIView, duration:TimeInterval, end:@escaping (() -> Void)) -> Void {
    view.layer.removeAllAnimations()
    let anim = CABasicAnimation(keyPath: "transform.rotation")
    anim.toValue = -(Double.pi * 2)
    anim.duration = 1
    anim.repeatCount = MAXFLOAT
    anim.isRemovedOnCompletion = true
    //anim.autoreverses = true; // 结束后执行逆动画
    anim.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
    view.layer.add(anim, forKey: nil)
    
//    view.transform = CGAffineTransform.identity
//    UIView.animate(withDuration: duration, animations: {
//        view.transform = CGAffineTransform.init(rotationAngle: -.pi)
//    }) { (finish) in
//        end()
//    }
}

