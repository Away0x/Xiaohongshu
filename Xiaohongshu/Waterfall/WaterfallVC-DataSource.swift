//
//  WaterfallVC-DataSource.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/30.
//

import Foundation

extension WaterfallVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMyDraft {
            return draftNotes.count
        }
        return 13
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 我的草稿页面
        if isMyDraft {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterfallCellID, for: indexPath) as! DraftNoteWaterfallCell
            
            cell.draftNote = draftNotes[indexPath.item]
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(showDeleteAlert), for: .touchUpInside)
            
            return cell
        }
        
        // 普通的 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterfallCellID, for: indexPath) as! WaterfallCell
    
        cell.imageView.image = UIImage(named: "\(indexPath.item + 1)")
    
        return cell
    }
}

// MARK: - 一般函数
extension WaterfallVC {
    private func deleteDraftNote(_ index: Int) {
        let draftNote = draftNotes[index]
        
        // core data 删除
        context.delete(draftNote)
        appDelegate.saveContext()
        
        // ui 上删除
        draftNotes.remove(at: index)
        collectionView.performBatchUpdates {
            // 用deleteItems会出现'index out of range'的错误,因为DataSource里面的index没有更新过来,故直接使用reloadData
            // self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
            self.collectionView.reloadData()
            self.showTextHUB("删除草稿成功")
        }
    }
}

// MARK: - 事件
extension WaterfallVC {
    @objc private func showDeleteAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "提示", message: "确认删除该草稿吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let okAction = UIAlertAction(title: "确认", style: .destructive) { _ in
            self.deleteDraftNote(sender.tag)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
