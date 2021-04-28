//
//  Constants.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/5.
//

import UIKit

// swift 中常量一般以 k 开头

// MARK: StoryboardID
let kFollowVCID = "FollowVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kNearByVCID = "NearByVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"

// MARK: Cell 相关的 ID
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"

// MARK: size
// 瀑布流
let kWaterfallPadding: CGFloat = 4

// MARK: -业务为逻辑相关
let kChannels = ["推荐", "旅行", "娱乐", "才艺", "美妆", "白富美", "美食", "萌宠"]

// YPImagePicker
let kMaxCameraZoomFactor: CGFloat = 5 // 最大多少倍变焦
let kMaxPhotoCount = 9 // picker 选择图片时允许用户最多选几张
let kSpacingBetweenItems: CGFloat = 2 // 照片缩略图之间的间距
