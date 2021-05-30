//
//  WaterfallVC-LoadData.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/29.
//

import CoreData

extension WaterfallVC {
    // 获取草稿
    func getDraftNotes() {
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        // 分页
        //v request.fetchLimit = 20
        // request.fetchOffset = 0
        // 筛选
        // request.predicate = NSPredicate(format: "title = %@", "iOS")
        // 排序
        // request.sortDescriptors = [
        //     NSSortDescriptor(key: "updateAt", ascending: true) // updateAt 正向排序
        // ]
        
        // 默认取数据是 fault 机制的，当访问数据一条属性时，会加载出该数据的所有属性
        // request.returnsObjectsAsFaults
        
        // 预加载指定的属性，但是如果取数组外的属性，还是会触发 fault 机制
        request.propertiesToFetch = ["coverPhoto", "title", "updateAt", "isVideo"]
        
        showLoadHUB()
        backgroundContext.perform {
            if let draftNotes = try? backgroundContext.fetch(request){
                self.draftNotes = draftNotes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            self.hideLoadHub()
        }
    }
}
