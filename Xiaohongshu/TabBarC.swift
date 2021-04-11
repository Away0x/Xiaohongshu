//
//  TabBarC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/8.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    // 点击 tabbar item 时
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PostVC {
            // 功能: 允许一个笔记发布单个视频或多张照片
            
            // TODO: 判断是否登录
            
            var config = YPImagePickerConfiguration()
            // MARK: 通用配置
            config.isScrollToChangeModesEnabled = false // 相册中禁止左右滑动切换拍照
            config.onlySquareImagesFromCamera = false // 只允许拍方形图
            config.albumName = Bundle.main.appName
            config.startOnScreen = .photo // 默认打开相册
            config.screens = [.library, .video, .photo] // 从左到右显示的页面
            config.maxCameraZoomFactor = 5
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = 2
            // MARK: 选择后预览编辑页面的配置
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            // MARK: 选完或按取消按钮后的异步回调处理 (依据配置处理单个或多个)
            picker.didFinishPicking { [unowned picker] items, canceled in
                if canceled {
                    print("用户按了左上角的取消按钮")
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            
            return false
        }
        
        // 执行切换 view controller 操作
        return true
    }

}
