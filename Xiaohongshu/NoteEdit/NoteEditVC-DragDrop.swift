//
//  NoteEditVC-DragDrop.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/28.
//

import Foundation

// .delegate 在 storyboard 中设置了
// MARK: - UICollectionViewDragDelegate
extension NoteEditVC : UICollectionViewDragDelegate {
    // 开始拖拽
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        // 可以用 indexPath 判断某个 section 或 item 是否可拖拽，若不可拖拽则返回空数组
        
        dragingIndexPath = indexPath // 存储当前正在拖拽的 cell 坐标
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photo!))
        dragItem.localObject = photo // 存值，在 drop 时可以取出来
        return [dragItem]
    }
    // 若一次拖动多个，还需实现 itemsForAddingTo 方法
    // 如果需要修改拖拽的样式，需要实现 dragPreviewParametersForItemAt 方法
}

// MARK: - UICollectionViewDropDelegate
extension NoteEditVC : UICollectionViewDropDelegate {
    // 正在拖拽 (拖拽中会持续调用)
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        // 可以这样判断是否可拖拽 (例如 section 不同，不可拖拽)
        // if dragingIndexPath.section != destinationIndexPath?.section {
        //     return UICollectionViewDropProposal(operation: .forbidden)
        // }
        
        // 判断当前是否是一个有效的拖拽
        if collectionView.hasActiveDrag {
            // 是移动操作，需要插入
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    // 结束拖拽
    // coordinator: 协调器
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        // 移动 cell
        // coordinator.items.first: 拖拽的 cell (单个拖拽，所以取 first)
        if coordinator.proposal.operation == .move,
           let dragTarget = coordinator.items.first, // 拖拽的 cell
           let sourceIndexPath = dragTarget.sourceIndexPath, // 拖拽的 cell 的 indexPath
           let destinationIndexPath = coordinator.destinationIndexPath // drop 的 indexPath
       {
            
            // performBatchUpdates 会使移动数据更流畅 (会把多个操作合成一个动画)
            collectionView.performBatchUpdates {
                // swap 数据 (先删除再插入)
                photos.remove(at: sourceIndexPath.item)
                // 插入开始拖拽时存储在 item 上的数据
                let dragData = dragTarget.dragItem.localObject as! UIImage
                photos.insert(dragData, at: destinationIndexPath.item)
                
                // 更新 collectionView
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            // 拖拽结束
            coordinator.drop(dragTarget.dragItem, toItemAt: destinationIndexPath)
        } else if coordinator.proposal.operation == .copy {
            print("copy cell")
        }
    }
}
