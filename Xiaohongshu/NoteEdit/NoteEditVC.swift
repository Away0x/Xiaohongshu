//
//  NoteEditVC.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/14.
//

import UIKit

class NoteEditVC: UIViewController {
    
    // 请求位置权限
    let locationManager = CLLocationManager()
    
    // ------------------- collection view -------------------
    // 顶部图片选择布局
    @IBOutlet weak var photoCollectionView: UICollectionView!
    // 存储当前正在拖拽的 cell 坐标
    var dragingIndexPath = IndexPath(item: 0, section: 0)
    // 存储选择的图片
    var photos = [UIImage(named: "1"), UIImage(named: "2")]
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
    
    // ------------------- 初始化 -------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // 开始编辑 title
    @IBAction func titleTextFieldEditBegin(_ sender: UITextField) {
        titleCountLabel.isHidden = false
    }
    
    // 结束编辑 title
    @IBAction func titleTextFieldEditEnd(_ sender: UITextField) {
        titleCountLabel.isHidden = true
    }
    
    // 编辑 title 中 (每输入一个字符之后都会调用)
    @IBAction func titleTextFieldEditChange(_ sender: UITextField) {
        // 修复系统自带拼音输入法的问题，当文本处于高亮时，表示用户正在输入中文拼音(不进行计数)
        guard sender.markedTextRange == nil else { return }
        // 大于最大字符数量，截取
        if sender.unwrappedText.count > kMaxNoteTitleCount {
            sender.text = String(sender.unwrappedText.prefix(kMaxNoteTitleCount))
            showTextHUB("标题最多输入\(kMaxNoteTitleCount)字哦")
            // 设置输入光标的位置
            DispatchQueue.main.async {
                let end = sender.endOfDocument // 文本结尾的位置
                sender.selectedTextRange = sender.textRange(from: end, to: end)
            }
        }
        
        titleCountLabel.text = "\(kMaxNoteTitleCount - sender.unwrappedText.count)"
    }
    
    // 编辑 title 时点击软键盘的 return
    @IBAction func titleTextFieldEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder() // 隐藏软键盘
    }
    
    // TODO: 存草稿和发布笔记之前需判断当前用户输入的正文文本数量，看是否大于最大可输入的字符数
    
    // 因为 ChannelVC 的跳转是在 storyboard 中指定的，所以只能在这边进行判断
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC {
            // channelVC 不是 self 下的属性, 没有强引用问题，所以 PVDelegate 声明时不用标记 weak
            channelVC.PVDelegate = self
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

// vc 反向传值协议
extension NoteEditVC : ChannelVCDelegate {
    // 获取 ChannelTableVC 传递的数据
    func updateChannel(channel: String, subChannel: String) {
        self.channel = channel
        self.subChannel = subChannel
        
        channelLabel.text = subChannel
        channelLabel.textColor = kBlueColor
        channelIcon.tintColor = kBlueColor
        channelPlaceHolderLabel.isHidden = true
    }
}
