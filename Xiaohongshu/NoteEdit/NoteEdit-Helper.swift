//
//  NoteEdit-Helper.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/30.
//

import Foundation

extension NoteEditVC {
    // 存草稿时的验证
    func isValidateNote() -> Bool {
        guard !photos.isEmpty else {
            showTextHUB("至少需要选择一张图片哦")
            return false
        }
        
        guard textViewIAView.currentTextCount < kMaxNoteTextCount else {
            showTextHUB("标题最多输入\(kMaxNoteTitleCount)字哦")
            return false
        }
        
        return true
    }
    
    func handleTFEditChanged(){
        // 修复系统自带拼音输入法的问题，当文本处于高亮时，表示用户正在输入中文拼音(不进行计数)
        guard titleTextField.markedTextRange == nil else { return }
        // 大于最大字符数量，截取
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            showTextHUB("标题最多输入\(kMaxNoteTitleCount)字哦")
            // 设置输入光标的位置, 用户粘贴文本后的光标位置,默认会跑到粘贴文本的前面,此处改成末尾
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument // 文本结尾的位置
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
}
