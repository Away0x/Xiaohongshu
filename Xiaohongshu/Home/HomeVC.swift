//
//  HomeVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/5.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        // MARK: 设置上方的 bar, 按钮, 条的 UI
        // selectedBar -- 按钮下方的条
        settings.style.selectedBarBackgroundColor = UIColor(named: "main")!
        settings.style.selectedBarHeight = 3
        // buttonBarItem 样式
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        settings.style.buttonBarItemLeftRightMargin = 0
        
        super.viewDidLoad()
        
        // 使 scroll view 左右滑动在最边缘时不会出现 bounce 效果
        containerView.bounces = false
        
        // 设置切换 tab 时的样式
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            // 未被选中的 cell
            oldCell?.label.textColor = .secondaryLabel
            // 被选中的 cell
            newCell?.label.textColor = .label
        }
        
        // 设置默认显示的 tab
        // DispatchQueue.main.async {
        //    self.moveToViewController(at: 1, animated: false)
        // }
    }
    
    // 设置 tab bar 对应的 controller
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard!.instantiateViewController(identifier: kFollowVCID)
        let nearByVC = storyboard!.instantiateViewController(identifier: kNearByVCID)
        let discoveryVC = storyboard!.instantiateViewController(identifier: kDiscoveryVCID)
        
        return [discoveryVC, followVC, nearByVC]
    }

}
