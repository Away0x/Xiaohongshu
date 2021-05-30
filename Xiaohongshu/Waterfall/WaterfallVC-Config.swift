//
//  WaterfallVC-Config.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/29.
//

import Foundation
import CHTCollectionViewWaterfallLayout

extension WaterfallVC {
    func config() {
        // sb 中设置了 layout class 了
        let layout = collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        layout.columnCount = 2
        layout.minimumColumnSpacing = kWaterfallPadding
        layout.minimumInteritemSpacing = kWaterfallPadding
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
        
        if isMyDraft {
            navigationItem.title = "本地草稿"
        }
    }
}
