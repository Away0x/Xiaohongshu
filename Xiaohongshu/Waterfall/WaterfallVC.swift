//
//  WaterfallVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/5.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

class WaterfallVC: UICollectionViewController {
    
    var channel = ""
    var draftNotes: [DraftNote] = []
    var isMyDraft = false // 用于判断 cell 类型

    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        // 我的草稿页面，加载草稿数据
        if isMyDraft {
            getDraftNotes()
        }
    }
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout {
    // 动态设定 cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellW = (kScreenRect.width - kWaterfallPadding * 3) / 2
        var cellH: CGFloat = 0
        
        if isMyDraft {
            // 草稿 cell 有 img 和 label，所以得计算才能得到高度
            let draftNote = draftNotes[indexPath.item]
            let img = UIImage(data: draftNote.coverPhoto) ?? kImagePlaceHolder
            let imageRatio = img.size.height / img.size.width // 宽高比
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewHeight
        } else {
            cellW = UIImage(named: "\(indexPath.item + 1)")!.size.width
            cellH = UIImage(named: "\(indexPath.item + 1)")!.size.height
        }
        
        return CGSize(width: cellW, height: cellH)
    }
    
}

// MARK: - IndicatorInfoProvider
extension WaterfallVC: IndicatorInfoProvider {
    
    // tab bar title
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: channel)
    }
    
}
