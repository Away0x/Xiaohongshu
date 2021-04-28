//
//  Extensions.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/11.
//

import UIKit

extension UIView {
    // 可以在 uiview xib 右侧属性栏显示设置改属性
    @IBInspectable
    var borderRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UIViewController {
    // 提示框
    func showTextHUB(_ title: String, _ subTitle: String? = nil) {
        // 不需要 import MBProgressHUD，因为在桥接文件中已经 import 了，对所有文件生效
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.mode = .text
        hub.label.text = title
        hub.detailsLabel.text = subTitle
        hub.hide(animated: true, afterDelay: 2)
    }
}

extension Bundle {
    var appName: String {
        // 读取 localizedInfoDictionary 时要注意有可能没有值
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
