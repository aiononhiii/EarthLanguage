//
//  AllTranslationVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/4.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

class AllTranslationVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIViewControllerPreviewingDelegate {
    
    @IBOutlet weak var allTranslation: UICollectionView!
    @IBOutlet weak var nationalitySelectionView: UIView!
    @IBOutlet weak var goBottom: LGFMagicButton!
    var TranslationArray: NSMutableArray!
    
    let nationalitySelection:NationalitySelectionVC = {
        var VC = lgf_XibView(NibName: "NationalitySelectionVC", index: 0) as! NationalitySelectionVC
        return VC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lgf_After(seconds: 5.0) {
            LGFMBHud.hideHud(in: self.view)
            
        }
        
//        lgf_After(seconds: 6.0) {
//            LGFMBHud.hideHud(in: self.view)
//        }
//        
//        lgf_After(seconds: 7.0) {
//            LGFMBHud.hideHud(in: self.view)
//
//        }
//        
        
        lgf_After(seconds: 8.0) {
            LGFMBHud.hideHud(in: self.view)
            LGFMBHud.hideHud(in: self.view)
            LGFMBHud.hideHud(in: self.view)
        }
        
        lgf_LastView = self.view
        lgf_LastController = self
        self.nationalitySelection.frame = self.nationalitySelectionView.bounds
        self.nationalitySelectionView.addSubview(self.nationalitySelection)
        self.nationalitySelection.reloadAllTranslationVC = {self.translationReloadToBottom(animated: true)}
        self.translationReloadToBottom(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func goToBottom(_ sender: Any) {
        self.translationReloadToBottom(animated: true)
    }
    
    func SpeekStart() -> Void {
        self.nationalitySelection.startSpeek()
    }
    
    func SpeekEnd() -> Void {
        self.nationalitySelection.stopSpeek()
    }
    
    func translationReloadToBottom(animated:Bool) -> Void {
        let NoDataVC = lgf_XibView(NibName: "NoDataImageView", index: 0) as! NoDataImageView
        self.TranslationArray = lgf_GetTranslationArray()
        NoDataVC.AutoHaveDataJudge(count: self.TranslationArray.count, superview: self.view)
        lgf_After(seconds: 0.1) { 
            self.allTranslation.reloadData()
            lgf_ScrollToBottom(scrollview: self.allTranslation)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.TranslationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.width, height: self.view.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize {
        return CGSize(width: self.view.width, height: self.view.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize {
        return CGSize(width: self.view.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let footer :AllTranslationReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionFooter, withReuseIdentifier: "allTranslationFooter", for: indexPath) as! AllTranslationReusableView
            return footer as UICollectionReusableView
        } else {
            let header:UICollectionReusableViewTwo = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "allTranslationHeader", for: indexPath) as! UICollectionReusableViewTwo
            return header as UICollectionReusableView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.TranslationArray.count - 1 {
            lgf_JellyAnimation(view: cell, duration: 0.2, range: 1.2) {}
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllTranslationCell", for: indexPath) as! AllTranslationCell
        let translationDict = self.TranslationArray[indexPath.item] as! NSMutableDictionary
        print(translationDict)
        /// 翻译内容
        cell.onePLay.setTitle(translationDict["languageone"] as? String, for:.normal)
        cell.twoPlay.setTitle(translationDict["languagetwo"] as? String, for:.normal)
        cell.threePlay.setTitle(translationDict["languagethree"] as? String, for:.normal)
        if (translationDict["languageone"] != nil) {
            cell.onePLay.MagicInfo = ["title":(translationDict["languageone"] as? String)!,"ioslocale":(translationDict["onepeoeledict"] as! NSMutableDictionary).value(forKey: "ioslocale") as! String]
        }
        if (translationDict["languagetwo"] != nil) {
            cell.twoPlay.MagicInfo = ["title":(translationDict["languagetwo"] as? String)!,"ioslocale":(translationDict["twopeoeledict"] as! NSMutableDictionary).value(forKey: "ioslocale") as! String]
        }
        if (translationDict["languagethree"] != nil) {
            cell.threePlay.MagicInfo = ["title":(translationDict["languagethree"] as? String)!,"ioslocale":(translationDict["threepeoeledict"] as! NSMutableDictionary).value(forKey: "ioslocale") as! String]
        }
        
        if lgf_UserDefaults.bool(forKey: "show_local_on") {
            /// 国籍国旗
            cell.oneLocal.image = UIImage.init(named: (translationDict["onepeoeledict"] as! NSMutableDictionary).value(forKey: "imagename") as! String)
            cell.twoLocal.image = UIImage.init(named: (translationDict["twopeoeledict"] as! NSMutableDictionary).value(forKey: "imagename") as! String)
            cell.threeLocal.image = UIImage.init(named: (translationDict["threepeoeledict"] as! NSMutableDictionary).value(forKey: "imagename") as! String)
            cell.oneLocalLeft.constant = 8
            cell.twoLocalLeft.constant = 8
            cell.threeLocalLeft.constant = 8
        } else {
            cell.oneLocal.image = UIImage.init(named: "")
            cell.twoLocal.image = UIImage.init(named: "")
            cell.threeLocal.image = UIImage.init(named: "")
            cell.oneLocalLeft.constant = -23
            cell.twoLocalLeft.constant = -23
            cell.threeLocalLeft.constant = -23
        }
        
        if lgf_UserDefaults.bool(forKey: "show_time_on") {
            /// 翻译时间
            cell.translationTime.text = translationDict["nowtime"] as? String
        } else {
            cell.translationTime.text = ""
        }
        
        cell.translationNumber.text = String.init(indexPath.item + 1)
        
        if indexPath.item == self.TranslationArray.count - 1 {
            cell.newDataState.alpha = 1.0
        } else {
            cell.newDataState.alpha = 0.0
        }
        
        if indexPath.item == 0 {
            cell.lineView.alpha = 0.0//
        } else {
            cell.lineView.alpha = 1.0
        }
        
        cell.SpeekStart = {
            self.SpeekStart()
        }
        cell.SpeekEnd = {
            self.SpeekEnd()
        }

        
        if self.traitCollection.forceTouchCapability == .available {
            LLog("支持")
            self.registerForPreviewing(with: self, sourceView: cell.onePLay)
            self.registerForPreviewing(with: self, sourceView: cell.twoPlay)
            self.registerForPreviewing(with: self, sourceView: cell.threePlay)
        } else {
            self.addLongpressGesutre(view: cell.onePLay)
            self.addLongpressGesutre(view: cell.twoPlay)
            self.addLongpressGesutre(view: cell.threePlay)
            LLog("不支持")
        }
        
        return cell
    }
    
    func addLongpressGesutre(view:LGFMagicButton) -> Void {
        let longpressGesutre = UILongPressGestureRecognizer(target: self, action: #selector(ShowTranslationDetailVC))
        longpressGesutre.minimumPressDuration = 0.5
        view.addGestureRecognizer(longpressGesutre)
    }
    
    /// 不支持3dtouch长按手势
    func ShowTranslationDetailVC(_ sender: UILongPressGestureRecognizer) -> Void {
        let button = sender.view as! LGFMagicButton
        let VC = lgf_SBVC(storyboardName: "Main", Identifier: "TranslationDetailVCSB") as! TranslationDetailVC
        VC.magicInfo = button.MagicInfo
        VC.SpeekEnd = {self.SpeekEnd()}
        VC.SpeekStart = {self.SpeekStart()}
        self.present(VC, animated: true) {
            VC.speekButton.alpha = 1.0
            VC.copyButton.alpha = 1.0
            VC.hideButton.alpha = 1.0
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        let VC = viewControllerToCommit as! TranslationDetailVC
        self.present(VC, animated: true) {
            VC.speekButton.alpha = 1.0
            VC.copyButton.alpha = 1.0
            VC.hideButton.alpha = 1.0
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        previewingContext.sourceRect = previewingContext.sourceView.bounds
        let button = previewingContext.sourceView as! LGFMagicButton
        LLog(button.titleLabel?.text)
        let VC = lgf_SBVC(storyboardName: "Main", Identifier: "TranslationDetailVCSB") as! TranslationDetailVC
        VC.preferredContentSize = CGSize.init(width: lgf_ScreenW, height: lgf_ScreenH / 2)
        VC.magicInfo = button.MagicInfo
        VC.SpeekEnd = {self.SpeekEnd()}
        VC.SpeekStart = {self.SpeekStart()}
        return VC
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.4) { 
            if (scrollView.contentOffset.y < self.allTranslation.contentSize.height - self.allTranslation.height * 1.3) && self.TranslationArray.count > 3 {
                self.goBottom.transform = CGAffineTransform.init(translationX: -35, y: 0)
            } else {
                self.goBottom.transform = CGAffineTransform.identity
            }
        }
    }
    
}
