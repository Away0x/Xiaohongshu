//
//  DiscoveryVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/5.
//

import UIKit
import XLPagerTabStrip

class DiscoveryVC: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: "发现")
    }
    
}
