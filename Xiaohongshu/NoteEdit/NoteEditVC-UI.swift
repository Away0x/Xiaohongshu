//
//  NoteEditVC-UI.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/30.
//

import Foundation

extension NoteEditVC {
    func setUI() {
        setDraftNoteEditUI()
    }
}

// MARK: - 编辑草稿笔记时
extension NoteEditVC {
    func updateChannelUI() {
        channelLabel.text = subChannel
        channelLabel.textColor = kBlueColor
        channelIcon.tintColor = kBlueColor
        channelPlaceHolderLabel.isHidden = true
    }
    
    func updatePOINameUI() {
        if poiName == "" {
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
            poiNameIcon.tintColor = .label
            return
        }
        poiNameLabel.text = poiName
        poiNameLabel.textColor = kBlueColor
        poiNameIcon.tintColor = kBlueColor
    }
    
    private func setDraftNoteEditUI() {
        if let draftNote = draftNote {
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty { updateChannelUI() }
            if !poiName.isEmpty { updatePOINameUI() }
        }
    }
}
