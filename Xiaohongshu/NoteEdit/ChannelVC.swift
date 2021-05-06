//
//  ChannelVC.swift
//  Xiaohongshu
//  选择话题
//  Created by 吴彤 on 2021/5/6.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {
    
    // 用于子视图反向传值
    var PVDelegate: ChannelVCDelegate? = nil

    override func viewDidLoad() {
        // MARK: 设置上方的 bar, 按钮, 条的 UI
        settings.style.selectedBarBackgroundColor = kMainColor
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        
        super.viewDidLoad()
        
        containerView.bounces = false
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        
        for i in kChannels.indices {
            let vc = storyboard!.instantiateViewController(identifier: kChannelTableVCID) as! ChannelTableVC
            vc.channel = kChannels[i]
            vc.subChannels = kAllSubChannels[i]
            vcs.append(vc)
        }
        
        return vcs
    }

}
