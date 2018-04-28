//
//  FlagSelectionVC.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/8.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit
import AudioToolbox

typealias ReloadNationalitySelectionVC = () -> Void

class FlagSelectionVC: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var allFlags: LGFMagicCollectionView!
    @IBOutlet weak var selectFalgBackView: LGFMagicView!
    @IBOutlet weak var selectFalg: LGFMagicImageView!
//    @IBOutlet weak var centerLb: UILabel!
//    @IBOutlet weak var promptLb: UILabel!
    var reloadNationalitySelectionVC:ReloadNationalitySelectionVC?
    
    var languageData = NSMutableDictionary.init() {
        didSet{
//            self.promptLb.textColor = (self.languageData.value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
//            self.centerLb.textColor = (self.languageData.value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
            self.selectFalgBackView.shadowColor = (self.languageData.value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0)
            self.selectFalg.image = UIImage.init(named: (self.languageData.value(forKey: "languagedata") as! NSMutableDictionary).value(forKey: "imagename") as! String)
        }
    }
    
    lazy var flags:NSArray = {
        var flags = NSArray.init(contentsOfFile: AllLanguagePath)
        return flags!
    }()
    
    /// 初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame = (lgf_LastView.bounds)
        lgf_LastView.addSubview(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// 隐藏动画
    func hideFlagSelectionVC(audiobool:Bool) -> Void {
        lgf_ZoomOut(view: self, duration: 0.2, range: 1.0) {
            self.removeFromSuperview()
            self.reloadNationalitySelectionVC!()
            if audiobool {AudioServicesPlaySystemSound(1520)}
        }
    }
    /// 显示动画
    //    func ShowFlagSelectionVC() -> Void {
    //        UIView.animate(withDuration: 0.1, animations: {
    //            self.alpha = 1.0
    //        })
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let view = self.hitTest(((touches as NSSet).anyObject() as AnyObject).location(in: self), with: event)
        if (view?.isKind(of: FlagCell.classForCoder()))! == false {
            self.hideFlagSelectionVC(audiobool: false)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.allFlags.width / 5, height: self.allFlags.height / 5)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.1 + TimeInterval((indexPath.item + 1)) * 0.01, animations: {
//            cell.transform = CGAffineTransform.init(translationX: 0, y: -20)
//        }) { (finished) in
//            UIView.animate(withDuration: 0.1 + TimeInterval((self.flags.count - indexPath.item)) * 0.01) {
//                cell.transform = CGAffineTransform.identity
//            }
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib.init(nibName: "FlagCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "FlagCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlagCell", for: indexPath) as! FlagCell
        let flagDict = self.flags[indexPath.item] as! NSMutableDictionary
        cell.flagIcon.image = UIImage.init(named: flagDict.value(forKey: "imagename") as! String)
        cell.layer.shadowColor = (self.languageData.value(forKey: "peoplecolor") as! String).lgf_UIColor(alpha: 1.0).cgColor
        cell.layer.shadowRadius = 1.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flagDict = self.flags[indexPath.item] as! NSMutableDictionary
        self.languageData.setValue(flagDict, forKey: "languagedata")
        lgf_SelectLanguaged.setValue(self.languageData, forKey: self.languageData.value(forKey: "selectpeople") as! String)
        lgf_SelectLanguaged.write(toFile: SelectLanguagePath, atomically: true)
        self.hideFlagSelectionVC(audiobool: true)
    }
    
}
