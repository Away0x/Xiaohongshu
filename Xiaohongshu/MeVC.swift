//
//  MeVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/30.
//

import UIKit

class MeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 去掉导航栏 back button 的文字
        // navigationItem.backButtonTitle = ""
        // ios 14 后可以这么设置
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let draftVC = segue.destination as? WaterfallVC {
            draftVC.isMyDraft = true
        }
    }

}
