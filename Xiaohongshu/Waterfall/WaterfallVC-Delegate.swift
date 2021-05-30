//
//  WaterfallVC-Delegate.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/30.
//

import Foundation

extension WaterfallVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if isMyDraft {
            let draftNote = draftNotes[indexPath.item]
            
            if let photosData = draftNote.photos,
               let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData) {
                
                let photos = photosDataArr.map { UIImage(data: $0) ?? kImagePlaceHolder }
                
                // data -> url，先将文件写入沙盒中，再转 url
                let videoURL = FileManager.default.save(draftNote.video, to: "video", as: "\(UUID().uuidString).mp4")
                
                let vc = storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                vc.draftNote = draftNote
                vc.photos = photos
                vc.videoURL = videoURL
                // 这种方法比 delegate 简单
                vc.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                
                // present(vc, animated: true)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                showTextHUB("加载草稿失败")
            }
        } else {
            
        }
    }
}
