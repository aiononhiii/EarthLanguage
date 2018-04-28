//
//  LGF_Authorization.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

//import MapKit
import Speech
import Foundation
import AVFoundation
//import Contacts
//import EventKit
import Photos
import Foundation
import UIKit

//去系统设置页面
func lgf_GoSystemSetting() -> Void {
    let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)! as URL
    if lgf_Application.canOpenURL(settingUrl) {
        lgf_Application.open(settingUrl, options: [String : Any](), completionHandler: { (false) in })
    }
}

/// 定位 授权请求 设置页面跳转
///
/// - Returns: 是否授权
//func lgf_LocateAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
//    if CLLocationManager.locationServicesEnabled() {
//        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
//            if lgf_IOS_VERSION(version: 10) {//如果IOS系统版本大于等于 10.0
//                lgf_AlertShow(title: "", message: "请开启定位权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
//                }, righthandler: {
//                    lgf_GoSystemSetting()
//                })
//            }
//            success(false)
//        }
//    } else {
//        lgf_AlertShow(title: "", message: "", lefttitle: "", righttitle: "", lefthandler: {
//        }, righthandler: {
//            lgf_GoSystemSetting()
//        })
//        success(false)
//    }
//    success(true)
//}

/// 相机 授权请求 设置页面跳转
///
/// - Returns: 是否授权
func lgf_CameraAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
    let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    if status == .notDetermined {// 未询问用户是否授权
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (Authorization) in
            if Authorization {
                //恭喜已经启用
                LLog("已经启用")
                success(true)
            } else {
                //已经禁用
                LLog("已经禁用")
                success(false)
            }
        }
    } else if status == .restricted || status == .denied {// 未授权
        lgf_AlertShow(title: "", message: "请开启相机权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
        }, righthandler: {
            lgf_GoSystemSetting()
        })
        success(false)
    } else {// 已授权
        success(true)
    }
}

/// 相册 授权请求 设置页面跳转
///
/// - Returns: 是否授权
func lgf_PhotoAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
    PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) in
        if status == .notDetermined {// 未询问用户是否授权
            success(false)
        } else if status == .restricted || status == .denied {// 未授权
            lgf_AlertShow(title: "", message: "请开启相册权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
            }, righthandler: {
                lgf_GoSystemSetting()
            })
            success(false)
        } else {// 已授权
            success(true)
        }
    }
}

/// 麦克风 授权请求 设置页面跳转
///
/// - Parameter success: 是否授权
func lgf_MicroPhoneAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
    let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
    if status == .notDetermined {// 未询问用户是否授权
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio) { (Authorization) in
            if Authorization {
                //恭喜已经启用
                LLog("已经启用")
                success(true)
            } else {
                //已经禁用
                LLog("已经禁用")
                success(false)
            }
        }
    } else if status == .restricted || status == .denied {// 未授权
        lgf_AlertShow(title: "", message: "请开启麦克风权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
        }, righthandler: {
            lgf_GoSystemSetting()
        })
        success(false)
    } else {// 已授权
        success(true)
    }
}

/// 语音识别 授权请求 设置页面跳转
///
/// - Parameter success: 是否授权
func lgf_SpeechRecognizerAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
    let status:SFSpeechRecognizerAuthorizationStatus = SFSpeechRecognizer.authorizationStatus()
    if status == .notDetermined {// 未询问用户是否授权
        SFSpeechRecognizer.requestAuthorization { (status:SFSpeechRecognizerAuthorizationStatus) in
        }
        success(false)
    } else if status == .restricted || status == .denied {// 未授权
        lgf_AlertShow(title: "", message: "请开启语音识别权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
        }, righthandler: {
            lgf_GoSystemSetting()
        })
        success(false)
    } else {// 已授权
        success(true)
    }
}

/// 通讯录访问 授权请求 设置页面跳转 系统 9.0+
///
/// - Parameter success: 是否授权
//func lgf_AddressBookAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
//    let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
//    let contactsStore = CNContactStore()
//    if status == .notDetermined {// 未询问用户是否授权
//        contactsStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (Authorization, error) in
//            if Authorization {
//                //恭喜已经启用
//                LLog("已经启用")
//                success(true)
//            } else {
//                //已经禁用
//                LLog("已经禁用")
//                success(false)
//            }
//        })
//    } else if status == .restricted || status == .denied {// 未授权
//        lgf_AlertShow(title: "", message: "请开启通讯录访问权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
//        }, righthandler: {
//            lgf_GoSystemSetting()
//        })
//        success(false)
//    } else {// 已授权
//        success(true)
//    }
//}

/// 日历或备忘录 授权请求 设置页面跳转 系统
///
/// - Parameter success: 是否授权
//func lgf_CalendarMemorandumAuthorizationRequest(success:@escaping ((Bool) -> Void)) -> Void {
//    let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
//    let eventStore = EKEventStore()
//    if status == .notDetermined {// 未询问用户是否授权
//        eventStore.requestAccess(to: EKEntityType.event, completion: { (Authorization, error) in
//            if Authorization {
//                //恭喜已经启用
//                LLog("已经启用")
//                success(true)
//            } else {
//                //已经禁用
//                LLog("已经禁用")
//                success(false)
//            }
//        })
//    } else if status == .restricted || status == .denied {// 未授权
//        lgf_AlertShow(title: "", message: "请开启日历权限", lefttitle: "残忍拒绝", righttitle: "现在就去", lefthandler: {
//        }, righthandler: {
//            lgf_GoSystemSetting()
//        })
//        success(false)
//    } else {// 已授权
//        success(true)
//    }
//}
