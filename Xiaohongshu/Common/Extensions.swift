//
//  Extensions.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/11.
//

import Foundation


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
