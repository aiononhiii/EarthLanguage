//
//  NationalitySelectionVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit
import AudioToolbox

typealias ReloadAllTranslationVCOne = () -> Void

class NationalitySelectionVC: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var inputType: LGFMagicCollectionView!/// 输入切换
    @IBOutlet weak var inputTypePage: UIPageControl!/// 输入切换page显示
    @IBOutlet weak var oneNat: LGFMagicButton!/// 第一个国籍
    @IBOutlet weak var twoNat: LGFMagicButton!/// 第二个国籍
    @IBOutlet weak var threeNat: LGFMagicButton!/// 第三个国籍
    @IBOutlet weak var oneNatImg: LGFMagicImageView!/// 第一个国籍国旗
    @IBOutlet weak var twoNatImg: LGFMagicImageView!/// 第二个国籍国旗
    @IBOutlet weak var threeNatImg: LGFMagicImageView!/// 第三个国籍国旗
    @IBOutlet weak var oneNatTitle: LGFMagicLabel!/// 第一个国籍名字
    @IBOutlet weak var twoNatTitle: LGFMagicLabel!/// 第二个国籍名字
    @IBOutlet weak var threeNatTitle: LGFMagicLabel!/// 第三个国籍名字
    @IBOutlet weak var topHelpTitle: UIButton!/// 上帮助提示
    @IBOutlet weak var bottomHelpTitle: UIButton!/// 下帮助提示
    @IBOutlet weak var showHelp: LGFMagicButton!/// 第一个国籍名字
    @IBOutlet weak var speekImage: LGFMagicImageView!
    var natButtons = [LGFMagicButton]()/// 所有国籍按钮数组
    var natImgs = [LGFMagicImageView]()/// 所有国籍国旗数组
    var natTitles = [LGFMagicLabel]()/// 所有国籍国旗数组
    var reloadAllTranslationVC:ReloadAllTranslationVCOne?
    
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lgf_After(seconds: 0.1) {
            lgf_UserDefaults.set(true, forKey: "login_bool")
            /// 输入方式选择
            self.inputType.reloadData()
            DispatchQueue.main.async {
                self.inputType.scrollToItem(at: IndexPath.init(item: self.inputTypePage.currentPage, section: 0), at: .left, animated: false)
            }
            
            self.natButtons += [self.oneNat, self.twoNat, self.threeNat]
            self.natImgs += [self.oneNatImg, self.twoNatImg, self.threeNatImg]
            self.natTitles += [self.oneNatTitle, self.twoNatTitle, self.threeNatTitle]
            self.inputTypePage.currentPage = lgf_UserDefaults.integer(forKey: "input_type_select_item")
            self.bottomHelpTitle.setTitle(self.inputTypePage.currentPage == 0 ? "手动输入" : "语音输入", for: .normal)
            
            self.natImgsAndTitlesSet()
            /// 遍历 natDict 里所有的字典
            for (_, item) in self.natButtons.enumerated() {
                if item.magicType == lgf_GetSelectPeople().value(forKey: "selectpeople") as! String {
                    self.natBtnOnSelect(item)
                }
            }
        }
        
    }
    
    func startSpeek() -> Void {
        self.speekImage.animationImages = [UIImage.init(named: "speek_music_zero")!, UIImage.init(named: "speek_music_one")!, UIImage.init(named: "speek_music_two")!, UIImage.init(named: "speek_music_three")!, UIImage.init(named: "speek_music_four")!]
        self.speekImage.animationDuration = 1.5
        self.speekImage.animationRepeatCount = Int.max
        self.speekImage.startAnimating()
    }
    
    func stopSpeek() -> Void {
        self.speekImage.stopAnimating()
        self.speekImage.image = UIImage.init(named: "speek_music_zero")
    }
    
    /// 国旗图片 国籍名字 设置
    func natImgsAndTitlesSet() -> Void {
        /// 设置选中的国籍国旗图片
        for (_, item) in self.natImgs.enumerated() {
            item.image = UIImage.init(named: ((lgf_SelectLanguaged.value(forKey: item.magicType) as! NSMutableDictionary).value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "imagename") as! String)
        }
        /// 设置选中的国籍名字
        for (_, item) in self.natTitles.enumerated() {
            item.text = ((lgf_SelectLanguaged.value(forKey: item.magicType) as! NSMutableDictionary).value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "countryname") as? String
        }
    }
    
    /// 点击按钮
    @IBAction func natBtnOnSelect(_ sender: LGFMagicButton) {
        if sender == showHelp {
            self.topHelpTitle.setTitle("长按进入帮助页面", for: .normal)
        } else {
            self.topHelpTitle.setTitle("长按切换国籍", for: .normal)
            /// 遍历 natDict 里所有的字典 找到点击的按钮对应的字典
            for (key, value) in lgf_SelectLanguaged{
                (value as! NSMutableDictionary).setValue((key as! String) == sender.magicType ? "true" : "false", forKey: "selectbool")
                lgf_SelectLanguaged.setValue(value, forKey: key as! String)
            }
            /// 遍历 NatButtons 里所有的按钮 找到点击的按钮
            for (_, item) in self.natButtons.enumerated() {
                item.setBackgroundImage(UIImage.init(named: item == sender ? (lgf_SelectLanguaged.value(forKey: item.magicType) as! NSMutableDictionary).value(forKey: "bgimage") as! String : (lgf_SelectLanguaged.value(forKey: item.magicType) as! NSMutableDictionary).value(forKey: "defuleimage") as! String), for: .normal)
                item.shadowOpacity = item == sender ? 1.0 : 0.0
            }
            for (_, item) in self.natTitles.enumerated() {
                item.textColor = item.magicType == sender.magicType ? UIColor.white : "D4D4D4".lgf_UIColor(alpha: 1.0)
            }
            /// inputType边框颜色设置
            //self.inputType.borderColor = ((lgf_SelectLanguaged.value(forKey: sender.magicType) as! NSMutableDictionary).value(forKey: "peoplecolor") as! String).lgf_UIColor()
            
            lgf_SelectLanguaged.write(toFile: SelectLanguagePath, atomically: true)
            
            self.inputTypePage.currentPageIndicatorTintColor = (lgf_GetSelectPeople().value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
             
            self.inputType.reloadData()
        }
    }
    
    /// 取消点击按钮
    @IBAction func natBtnUnSelect(_ sender: Any) {
        self.topHelpTitle.setTitle("", for: .normal)
    }
    
    /// 进入国旗选择
    @IBAction func goFlagSelection(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            AudioServicesPlaySystemSound(1520)
            sender.cancelsTouchesInView = false
            let VC = lgf_XibView(NibName: "FlagSelectionVC", index: 0) as! FlagSelectionVC
            VC.languageData = lgf_SelectLanguaged.value(forKey: (sender.view as! LGFMagicButton).magicType) as! NSMutableDictionary
            VC.reloadNationalitySelectionVC = { self.natImgsAndTitlesSet() }
        }
    }
    
    @IBAction func goHelpView(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            AudioServicesPlaySystemSound(1520)
            sender.cancelsTouchesInView = false
            let VC = lgf_XibView(NibName: "HelpVC", index: 0) as! HelpVC
            VC.reloadAllTranslationVC = {
                self.reloadAllTranslationVC!()
            }
            lgf_LastView.addSubview(VC)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.inputType.width, height: self.inputType.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib.init(nibName: "InputTypeCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "InputTypeCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InputTypeCell", for: indexPath) as! InputTypeCell
        
        if indexPath.item == 0 {
            cell.inputImage.setBackgroundImage(UIImage.init(named: "keyboard_image"), for: .normal)
            cell.inputImage.setBackgroundImage(UIImage.init(named: "keyboard_image"), for: .highlighted)
        } else if indexPath.item == 1 {
            cell.inputImage.setBackgroundImage(UIImage.init(named: "microphone_image"), for: .normal)
            cell.inputImage.setBackgroundImage(UIImage.init(named: "sound_recording_icon_off"), for: .highlighted)
        } else {
            
        }
        cell.inputImage.tag = indexPath.item
        cell.reloadAllTranslationVC = {self.reloadAllTranslationVC!()}
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.inputTypePage.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.width)
        switch self.inputTypePage.currentPage {
        case 0:
            self.bottomHelpTitle.setTitle("键盘输入", for: .normal)
            break
        case 1:
            self.bottomHelpTitle.setTitle("语音输入", for: .normal)
            break
        default:
            break
        }
        lgf_UserDefaults.set(self.inputTypePage.currentPage, forKey: "input_type_select_item")
    }
}
