//
//  NoteEditVC-CollectionView.swift
//  Xiaohongshu
//  collection view 相关代码
//  Created by 吴彤 on 2021/5/5.
//

import UIKit
import AVKit
import SKPhotoBrowser
import YPImagePicker
import SKPhotoBrowser


// MARK: - UICollectionViewDataSource
extension NoteEditVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
        
        return cell
    }
    
    // header footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        // 自定义 footer
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            
            footer.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            
            return footer
        case UICollectionView.elementKindSectionHeader:
            fatalError("no header")
        default:
            fatalError("非法的 collectionview cell")
            // return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension NoteEditVC: UICollectionViewDelegate {
    // 点击 item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo {
            // 点击的是视频，预览视频
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            present(playerVC, animated: true) {
                playerVC.player?.play() // 播放视频
            }
            
        } else {
            // 点击的是图片
            var images: [SKPhoto] = []
            
            for photo in photos {
                if let p = photo {
                    images.append(SKPhoto.photoWithImage(p))
                }
            }
            // 预览图片
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false // 隐藏分享按钮
            SKPhotoBrowserOptions.displayDeleteButton = true // 显示删除按钮
            present(browser, animated: false)
        }
    }
}

// MARK: - SKPhotoBrowserDelegate
extension NoteEditVC : SKPhotoBrowserDelegate {
    // 图片浏览器-删除图片
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        reload() // reload 图片浏览器数据
        photoCollectionView.reloadData() // reload collection view 数据
    }
}

// MARK: - 监听自定义事件
extension NoteEditVC {
    // collection view footer event
    @objc private func addPhoto(sender: UIButton) {
        // 可以继续添加图片
        if photoCount < kMaxPhotoCount {
            var config = YPImagePickerConfiguration()
            config.albumName = Bundle.main.appName
            config.screens = [.library]
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount // 还可选的照片数量
            config.library.spacingBetweenItems = kSpacingBetweenItems
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, canceled in
                for item in items {
                    if case let .photo(photo) = item {
                        // 添加图片
                        self.photos.append(photo.image)
                    }
                }
                // 刷新视图
                self.photoCollectionView.reloadData()

                picker.dismiss(animated: true)
            }
            
            present(picker, animated: true)
        } else {
            showTextHUB("最多只能选择\(kMaxPhotoCount)张图片")
        }
    }
}
