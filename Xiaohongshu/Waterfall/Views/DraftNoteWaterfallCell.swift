//
//  DraftNoteWaterfallCell.swift
//  Xiaohongshu
//  我的草稿页面 cell
//  Created by 吴彤 on 2021/5/29.
//

import UIKit

class DraftNoteWaterfallCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    
    var draftNote: DraftNote? {
        didSet {
            guard let draftNote = draftNote else { return }
            
            let title = draftNote.title!
            titleLabel.text = title.isEmpty ? "无题" : title
            
            isVideoImageView.isHidden = !draftNote.isVideo
            imageView.image = UIImage(data: draftNote.coverPhoto) ?? kImagePlaceHolder
            dateLabel.text = draftNote.updateAt?.formattedDate
        }
    }
}
