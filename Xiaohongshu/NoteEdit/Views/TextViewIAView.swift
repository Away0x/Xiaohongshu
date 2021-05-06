//
//  TextViewIAView.swift
//  Xiaohongshu
//  text view 软键盘顶部的 view
//  Created by 吴彤 on 2021/5/6.
//

import UIKit

class TextViewIAView : UIView {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textCountStackView: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0 {
        didSet {
            if currentTextCount <= kMaxNoteTextCount {
                doneButton.isHidden = false
                textCountStackView.isHidden = true
            } else {
                doneButton.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }
    
    override func awakeFromNib() {
        maxTextCountLabel.text = "/\(kMaxNoteTextCount)"
    }
    
}
