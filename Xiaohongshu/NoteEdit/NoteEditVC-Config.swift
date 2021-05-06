//
//  NoteEditVC-Config.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/6.
//

import Foundation

extension NoteEditVC {
    func config() {
        // 开启 collection view 拖拽交互
        photoCollectionView.dragInteractionEnabled = true
        // 点击空白处收起软键盘
        hideKeyboardWhenTappedAround()
        
        titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        // 设置正文 textView
        configTextView()
    }
    
    func configTextView() {
        // 去掉 textView 默认的文本边距
        // 文本的左右缩进边距
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)
        
        // 调整 text view 样式
        let paragraphStyle = NSMutableParagraphStyle() // 会使 sb 中设置的字体样式失效，所以需要自己重新再指定一下
        // paragraphStyle.lineHeightMultiple = 2 // 行高是原来的两倍
        paragraphStyle.lineSpacing = 6 // 行间距为 6
        // 设置字体样式
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        textView.typingAttributes = typingAttributes
        // sb 中设置 textView tint color 后(光标颜色)，需要调用一下这个方法才会生效
        textView.tintColorDidChange()
        
        // 设置软键盘顶部的 view
        // textViewIAView xib 的宽度可以随便定，因为系统会帮忙适配好，只需要定义好高度
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
        textViewIAView.doneButton.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
        
        // 请求位置权限
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - 事件
extension NoteEditVC {
    @objc private func resignTextView() {
        textView.resignFirstResponder()
    }
}
