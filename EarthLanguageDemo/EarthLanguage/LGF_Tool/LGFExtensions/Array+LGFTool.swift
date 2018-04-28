//
//  Array+LGFTool.swift
//  EarthLanguage
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 EarthLanguage. All rights reserved.
//

import Foundation
import UIKit

extension Array {

    /// 数组里每个元素都执行同一件事
    func allSubViewsSelect(select:(Any) -> ()) -> Void {
        for SubView in self {
            select(SubView)
        }
    }
    
}
