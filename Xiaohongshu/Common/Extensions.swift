//
//  Extensions.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/11.
//

import UIKit

extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// 扩展 String? 类型
extension Optional where Wrapped == String {
    var unwrappedValue: String { self ?? "" }
}

extension UIView {
    // 可以在 uiview xib 右侧属性栏显示设置改属性
    @IBInspectable
    var borderRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UITextField {
    var unwrappedText: String { text ?? "" }
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
    
    // 加载 loading
    func showLoadHUB(_ title: String? = nil) {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.label.text = title
    }
    
    // 隐藏 loading
    func hideLoadHub() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    // 点击空白处，隐藏软键盘
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 给根视图加上手势时，最好设置一下这个，避免影响到其他控件的事件
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true) // 收起软键盘
    }
}

extension Bundle {
    // 获取 app name
    var appName: String {
        // 读取 localizedInfoDictionary 时要注意有可能没有值
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
    // 读取 xib 文件
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)类型的 view 失败")
    }
}
