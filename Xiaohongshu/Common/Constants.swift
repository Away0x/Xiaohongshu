//
//  Constants.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/5.
//

import UIKit

// swift 中常量一般以 k 开头
// 常量文件里面都是懒加载的

// MARK: StoryboardID
let kFollowVCID = "FollowVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kNearByVCID = "NearByVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"
let kChannelTableVCID = "ChannelTableVCID"

// MARK: Cell 相关的 ID
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"

// MARK: - 资源文件相关
let kMainColor = UIColor(named: "main")!
let kBlueColor = UIColor(named: "blue")!
let kImagePlaceHolder = UIImage(named: "1")!

// MARK: size
// 瀑布流
let kWaterfallPadding: CGFloat = 4
let kDraftNoteWaterfallCellBottomViewHeight: CGFloat = 86.5 // 从 storyboard 里面测量到的 16+54.5+16
// UI
let kScreenRect = UIScreen.main.bounds

// MARK: - CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer // 持久化容器
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext() // 后台队列

// MARK: - 业务为逻辑相关
let kChannels = ["推荐", "旅行", "娱乐", "才艺", "美妆", "白富美", "美食", "萌宠"]

// YPImagePicker
let kMaxCameraZoomFactor: CGFloat = 5 // 最大多少倍变焦
let kMaxPhotoCount = 9 // picker 选择图片时允许用户最多选几张
let kSpacingBetweenItems: CGFloat = 2 // 照片缩略图之间的间距

// Note
let kMaxNoteTitleCount = 20 // 笔记标题最大字符数量
let kMaxNoteTextCount = 1000 // 笔记正文最大字符数量

// 话题 mock
let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]

// 高德
let kMapAppKey = "83c1ad414cc8a51c8bdc76109d531049" // 高德 app key
let kNoPOIPH = "未知地点"
//let kPOITypes = "医疗保健服务" // 搜索的类别
let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOIsInitArr = [["不显示位置", ""]]
let kPOIsOffset = 20 // 每次请求加载数据的数量

// 极光
let kJAppKey = "be20640a66ec644c03fe9f75" // 极光 app key
