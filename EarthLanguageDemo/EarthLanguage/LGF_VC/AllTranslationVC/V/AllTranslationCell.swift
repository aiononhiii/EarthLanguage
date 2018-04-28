//
//  AllTranslationCell.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import UIKit

typealias TranslationCellSpeekStart = () -> Void
typealias TranslationCellSpeekEnd = () -> Void

class AllTranslationCell: UICollectionViewCell {
    
    var SpeekStart:TranslationCellSpeekStart?
    var SpeekEnd:TranslationCellSpeekEnd?
    @IBOutlet weak var oneLocal: LGFMagicImageView!
    @IBOutlet weak var twoLocal: LGFMagicImageView!
    @IBOutlet weak var threeLocal: LGFMagicImageView!
    @IBOutlet weak var onePLay: LGFMagicButton!
    @IBOutlet weak var twoPlay: LGFMagicButton!
    @IBOutlet weak var threePlay: LGFMagicButton!
    @IBOutlet weak var newDataState: UIImageView!
    @IBOutlet weak var translationNumber: UILabel!
    @IBOutlet weak var translationTime: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var oneLocalLeft: NSLayoutConstraint!
    @IBOutlet weak var twoLocalLeft: NSLayoutConstraint!
    @IBOutlet weak var threeLocalLeft: NSLayoutConstraint!
    
    /// 语音播报
    @IBAction func GoSpeak(_ sender: LGFMagicButton) {
        
        lgf_JellyAnimation(view: sender, duration: 0.1, range: 1.3) {
            AutoSpeak.sharedSpeak.goSpeak(text: (sender.titleLabel?.text)!, locale: sender.MagicInfo["ioslocale"]!)
            AutoSpeak.sharedSpeak.speekEnd = {
                self.SpeekEnd!()
            }
            AutoSpeak.sharedSpeak.speekStart = {
                self.SpeekStart!()
            }
            AutoSpeak.sharedSpeak.speekRange = { (range) in
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
