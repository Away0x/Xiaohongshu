//
//  NoteEditVC-DraftNote.swift
//  Xiaohongshu
//  草稿相关
//  Created by 吴彤 on 2021/5/30.
//

import Foundation

extension NoteEditVC {
    // MARK: 创建草稿
    func createDraftNote() {
        // 后台线程中保存 core data
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            // 视频
            if self.isVideo {
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            // 图片
            self.handlePhotos(draftNote)
            
            draftNote.isVideo = self.isVideo
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUB("保存草稿成功", false)
            }
        }
        
        dismiss(animated: true)
    }
    
    // MARK: 更新草稿
    func updateDraftNote(_ draftNote: DraftNote){
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote)
            }
            self.handleOthers(draftNote)
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        // 更新草稿页面一般都是由 nav push 进来的
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 上面分离出来的函数
extension NoteEditVC{
    private func handlePhotos(_ draftNote: DraftNote){
        // 封面图片
        draftNote.coverPhoto = photos[0]?.jpeg(.high)
        // 所有图片
        var photos: [Data] = []
        for photo in self.photos{
            if let pngData = photo?.pngData(){
                photos.append(pngData)
            }
        }
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote){
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updateAt = Date()
        
         appDelegate.saveBackgroundContext()
    }
}
