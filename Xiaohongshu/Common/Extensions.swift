//
//  Extensions.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/11.
//

import UIKit
import AVFoundation
import DateToolsSwift

// MARK: - String
extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// 扩展 String? 类型
extension Optional where Wrapped == String {
    var unwrappedValue: String { self ?? "" }
}

// MARK: - Date
extension Date {
    // 1. 5分钟前
    // 2. 今天21:10
    // 3. 昨天:21.10
    // 4. 09-15
    // 5. 2020-09-15
    var formattedDate: String? {
        let currentYear = Date().year
        if year == currentYear {//今年
            if isToday {//今天
                if minutesAgo > 10{//note发布(或存草稿)超过10分钟即显示'今天xx:xx'
                    return "今天 \(format(with: "HH:mm"))"
                } else {
                    return timeAgoSinceNow
                }
            } else if isYesterday {//昨天
                return "昨天 \(format(with: "HH:mm"))"
            } else {//前天或更早的时间
                return format(with: "MM-dd")
            }
        } else if year < currentYear {//去年或更早
            return format(with: "yyyy-MM-dd")
        } else {
            return "明年或更远,目前项目暂不会用到"
        }
    }
}

// MARK: - UIView
extension UIView {
    // 可以在 uiview xib 右侧属性栏显示设置改属性
    @IBInspectable
    var borderRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

// MARK: - UIImage
extension UIImage {
    // 便利构造器必须调用同一个类中定义的其他初始化方法
    // 便利构造器在最好必须调用一个指定构造器
    convenience init?(data: Data?) {
        if let unwrappedData = data {
            self.init(data: unwrappedData)
        } else {
            return nil
        }
    }
    
    enum JPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

// MARK: - UITextField
extension UITextField {
    var unwrappedText: String { text ?? "" }
    var exactText: String { unwrappedText.isBlank ? "" : unwrappedText }
}

// MARK: - UITextView
extension UITextView {
    var unwrappedText: String { text ?? "" }
    var exactText: String { unwrappedText.isBlank ? "" : unwrappedText }
}

// MARK: - UIViewController
extension UIViewController {
    // 提示框
    func showTextHUB(_ title: String, _ inCurrentView: Bool = true, _ subTitle: String? = nil) {
        var viewToShow = view!
        if !inCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        
        // 不需要 import MBProgressHUD，因为在桥接文件中已经 import 了，对所有文件生效
        let hub = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hub.mode = .text
        hub.label.text = title
        hub.detailsLabel.text = subTitle
        hub.hide(animated: true, afterDelay: 2)
    }
    
    // 加载 loading
    func showLoadHUB(_ title: String? = nil) {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.label.text = title
    }
    
    // 隐藏 loading
    func hideLoadHub() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    // 点击空白处，隐藏软键盘
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 给根视图加上手势时，最好设置一下这个，避免影响到其他控件的事件
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true) // 收起软键盘
    }
}

// MARK: - Bundle
extension Bundle {
    // 获取 app name
    var appName: String {
        // 读取 localizedInfoDictionary 时要注意有可能没有值
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
    // 读取 xib 文件
    static func loadView<T>(fromNib name: String, with type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("加载\(type)类型的 view 失败")
    }
}

// MARK: - FileManager
extension FileManager {
    // 对 url 添加子路径常用 appendingPathComponent, 对 path 添加就直接字符串拼接/插值
    func save(_ data: Data?, to dirName: String, as fileName: String) -> URL? {
        guard let data = data else { return nil }
        
        // MARK: 知识点
        // 1. path 转 URL, URL 转 path
        // 2. 创建文件夹和文件时都需要先规定 URL
        // 3. 一般都会使用 fileExists 先判断文件夹或文件是否存在
        
        // MARK: 创建文件夹
        // "file:///xx/xx/tmp/dirName"
        // 这里的 NSTemporaryDirectory() 也可使用 temporaryDirectory
        let dirURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(dirName, isDirectory: true)
        
        if !fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true) else {
                print("创建文件夹失败")
                return nil
            }
        }
        
        // MARK: 写入文件
        // "file:///xx/xx/tmp/dirName/fileName"
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !fileExists(atPath: fileURL.path){
            guard let _ = try? data.write(to: fileURL) else {
                print("写入/创建文件失败")
                return nil
            }
        }
        
        return fileURL
    }
}

// MARK: - URL
extension URL {
    // 从视频中生成封面图(了解)
    var thumbnail: UIImage {
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        // 如果视频尺寸确定的话可以用下面这句提高处理性能
        // assetImgGenerate.maximumSize = CGSize(width,height)
        
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            return kImagePlaceHolder
        }
    }
}
