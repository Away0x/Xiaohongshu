//
//  NoteEditVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/14.
//

import UIKit
import YPImagePicker

class NoteEditVC: UIViewController {
    
    var photos = [
        UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")
    ]


    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoCount: Int { photos.count }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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

extension NoteEditVC: UICollectionViewDelegate {
    
}

// MARK: - 事件
extension NoteEditVC {
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
