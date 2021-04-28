//
//  PhotoFooter.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/26.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    // 是从 storyboard 里创建的 view 可以在该函数中进行初始化
    override func awakeFromNib() {
        super.awakeFromNib()

        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }

}
