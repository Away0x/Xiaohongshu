//
//  NoteEditVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/14.
//

import UIKit

class NoteEditVC: UIViewController {
    
    var draftNote: DraftNote?
    var updateDraftNoteFinished: (() -> ())?
    
    // 请求位置权限
    let locationManager = CLLocationManager()
    
    // ------------------- collection view -------------------
    // 顶部图片选择布局
    @IBOutlet weak var photoCollectionView: UICollectionView!
    // 存储当前正在拖拽的 cell 坐标
    var dragingIndexPath = IndexPath(item: 0, section: 0)
    // 存储选择的图片
    // var photos = [UIImage(named: "1"), UIImage(named: "2")]
    var photos: [UIImage?] = []
    var photoCount: Int { photos.count }
    
    // 视频链接，使可以打开视频预览
    var videoURL: URL? // 测试数据: Bundle.main.url(forResource: "testVideo", withExtension: "mp4")
    var isVideo: Bool { videoURL != nil } // 当前是否为视频预览模式
    
    // ------------------- 标题和正文表单 -------------------
    // 标题输入框
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    // 正文
    @IBOutlet weak var textView: UITextView!
    // 正文 textView 软键盘顶部的 view
    var textViewIAView: TextViewIAView { textView.inputAccessoryView as! TextViewIAView }
    
    // ------------------- 话题 -------------------
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceHolderLabel: UILabel!
    
    var channel = ""
    var subChannel = ""
    
    // ------------------- 地点 -------------------
    @IBOutlet weak var poiNameIcon: UIImageView!
    @IBOutlet weak var poiNameLabel: UILabel!
    var poiName = ""
    
    // ------------------- 初始化 -------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()
        
//        // 打印沙盒目录地址
        // print(NSHomeDirectory())
//        // 在沙盒内寻找 document 文件夹
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)[0])
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
    
    // 开始编辑 title
    @IBAction func titleTextFieldEditBegin(_ sender: UITextField) { titleCountLabel.isHidden = false }
    
    // 结束编辑 title
    @IBAction func titleTextFieldEditEnd(_ sender: UITextField) { titleCountLabel.isHidden = true }
    
    // 编辑 title 中 (每输入一个字符之后都会调用)
    @IBAction func titleTextFieldEditChange(_ sender: UITextField) { handleTFEditChanged() }
    
    // 编辑 title 时点击软键盘的 return
    @IBAction func titleTextFieldEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder() // 隐藏软键盘
    }
    
    // MARK: - 保存草稿
    // 存草稿和发布笔记之前需判断当前用户输入的正文文本数量，看是否大于最大可输入的字符数
    @IBAction func saveDraftNote(_ sender: UIButton) {
        guard isValidateNote() else { return }
        
        if let draftNote = draftNote {
            updateDraftNote(draftNote)
        } else {
            createDraftNote()
        }
    }
    
    // MARK: -  发布笔记
    @IBAction func postNote(_ sender: UIButton) {
        guard isValidateNote() else { return }
    }
    
    // 因为 ChannelVC/POIVC 的跳转是在 storyboard 中指定的，所以只能在这边进行判断
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            view.endEditing(true)
            // channelVC 不是 self 下的属性, 没有强引用问题，所以 PVDelegate 声明时不用标记 weak
            channelVC.PVDelegate = self
        } else if let poiVC = segue.destination as? POIVC {
            poiVC.delegate = self
            poiVC.poiName = self.poiName
        }
    }
}

// 标题 text field delegate
extension NoteEditVC : UITextFieldDelegate {}

// 正文 text view delegate
extension NoteEditVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else { return }
        textViewIAView.currentTextCount = textView.text.count
    }
}

// MARK: - ChannelVCDelegate 反向传值协议
extension NoteEditVC : ChannelVCDelegate {
    // 获取 ChannelTableVC 传递的数据
    func updateChannel(channel: String, subChannel: String) {
        self.channel = channel
        self.subChannel = subChannel
        
        updateChannelUI()
    }
}

// MARK: - POIVCDelegate 反向传值协议
extension NoteEditVC : POIVCDelegate {
    func updatePOIName(_ name: String) {
        // 不显示位置
        if name == kPOIsInitArr[0][0] {
            self.poiName = ""
        } else {
            self.poiName = name
        }
        
        updatePOINameUI()
    }
}
