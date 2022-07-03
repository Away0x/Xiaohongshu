> https://github.com/vsouza/awesome-ios

# Storybook
- 使用技巧:
    - 如果想在代码中设置属性，又忘记属性名称了，可以在 Storybook 右侧属性面板中的对应属性上鼠标稍作停留，即会出现代码中的属性名
- 使用 sb 做子视图时，不用自己处理子视图在父视图中的位置，其会自己适配 (比如子视图嵌入父视图的 ScrollView 中)

***

# TabbarController
- storybook 中连接 TabBarController 和 ViewController(子视图) 的方式 (每个 tab 关联一个 ViewController):
    1. 点击 TabBarController，右键拉箭头到 ViewController 上，在弹出的菜单中选择 Relationship Segue > view controllers
    2. 点击 TabBarController 在右侧属性栏的 Outlets > Preseting Seques > Relationship 中，点击连接需要管理的 ViewController
    3. 框选所需要连接的 ViewController，点击 XCode 右下方按钮，在弹出的菜单中选择 Embed In View Controller > Tab Bar Controller。即会为这些 ViewController 创建一个 TabBarController，并关联上

> TabBarController(NavigationController) 里面的 bar 和 item 这类 element 代表了什么？

TabBar 是底部导航的容器，里面的按钮则是 TabBarItem

Bar 是属于 TabBarController 的，所以要修改它可在 TabBarController 中通过 `self.tabBar` 来修改。(子视图控制器中可通过 `self.tabBarController.tabBar` 修改)

item 是属于 TabBarController 关联的一个个 ViewController 的，可以在 ViewController 中 `self.tabBarItem` 来修改

> TabBarItem 只设置文字，不需要图片

storybook 中选择子视图的 TabBarItem，在右侧属性中删除图片，只设置文字(没有图片了，storybook 中还是会显示一个小蓝色方框，可以忽略)，然后设置文字 title position 为 custom offset，设置 vertical 为 -16(**通常 TabBar 高 32**)，文字即可垂直居中了

> storybook 中如何调整 tabbar 中 item 的顺序

点击 TabBarController 底部 TabBar 里面各个 item 进行拖拽调整即可

***

# SF Symbols
> 其是 WWDC 2020 年推出的免费矢量图图标，`https://developer.apple.com/sf-symbols/`。我们可以直接使用或对其自定义使用

可下载官方 app 进行图标搜索和查看，图标中如果显示有 infomation 的，使用时需要注意，没按照提示使用，审核应用时可能会被驳回

在 storybook 右侧属性栏中，一些图片相关的属性可直接搜索 sf 图标使用

官方 app 支持图标模糊搜索，storybook 中只支持图标精确搜索

```swift
// 代码中使用
UIImage(systemName: "star.fill")
```

***

# 项目主题色
## Tint
> Tint 在 iOS 项目中类似有主题的概念，例如 Image Tint 就表示被选中时所展示的 image

### Global Tint
在 storybook 中点击任一 ViewController 在其右侧属性面板中选择 Interface Builder Document > Global Tint 进行修改 (只是修改了全局 View 的 Tint，如 TabBar 这些的组件的 Tint，需要另外调整)

## NamedColor (iOS14)
> 推出了 NamedColor，功能类似 Global Color，可以在 Assets.xcassets 中进行颜色管理，之后便可在属性面板中选取了

- 比 Global Tint 的好处在于，可以设置深色模式和浅色模式下的不同主题颜色

***

# 深浅色适配 (iOS13)
- [适配深色模式（色彩+图片等）](https://www.fivestars.blog/code/ios-dark-mode-how-to.html)
- [官方文档](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/dark-mode/)
- [官方文档](https://developer.apple.com/documentation/xcode/supporting_dark_mode_in_your_interface)

## 使用系统自带动态颜色自动适配深色模式
- SystemColor
    - 选择颜色时可以选择 system backgroup color，其在深色模式下为黑色，浅色模式下为白色
    - 前缀为 system 的颜色和一些系统提供的语义话的颜色(如 Label Color)在不同模式下都会不同，可用于适配
- 使用 Assets.xcassets 的 Color set 管理颜色，可设置 Appearances 来管理深浅模式下的不同颜色

```swift
// 代码中使用 SystemColor
UIColor.systemBackground
```

## 图片适配
- 使用 SF Symbols
- 自定义图片可 使用 Assets.xcassets 管理，可设置 Appearances 来管理深浅模式下的不同图片

## 强制使用深色模式/浅色模式 (之后苹果可能会取消这个功能)
info.plist 中设置 Appearance 为 Dark 或 Light

***

# 横滑多 Tab 导航页面
- 方式一: 使用 PageViewController
- 方式二: 使用 ScrollView (开启 Paging Enabled)
    - [用UIScrollView做启动翻页 | Medium](https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92)
- 使用一些第三方插件:
    - [XLPagerTabStrip](https://github.com/xmartlabs/XLPagerTabStrip)
    - [TabPageViewController](https://github.com/EndouMari/TabPageViewController)


***

# CocoaPods
- [文档](https://guides.cocoapods.org/)
- [安装cocoapods很慢或出错怎么办？Unable to add a source with url https://github.com...](https://juejin.cn/post/6844903828177813518)
- [iOS安装cocoapods时failed to build gem native extension cocoapods错误](https://juejin.cn/post/6898287392471318535/)

```bash
# 安装
sudo gem install cocoapods
pod --version
```
```bash
# 初始化
cd project
pod init
# 安装依赖 (编辑 Podfile 后)
pod install
```

***

# iOS 向下兼容的解决方案
- [Swift中的#available和@available--iOS、macOS等向下兼容的解决方案](https://juejin.cn/post/6844904090762215437)

***

# 本地化
> [文档](https://developer.apple.com/localization/)

- trailing/leading: 会根据国家的阅读习惯排版文字

## storyboard & xib 本地化
- [BartyCrouch](https://github.com/Flinesoft/BartyCrouch)
- [教程](https://zhuanlan.zhihu.com/p/57117270)

## 代码字符串的本地化
- [教程](https://zhuanlan.zhihu.com/p/57345266)

## App 名称的本地化
- [教程](https://zhuanlan.zhihu.com/p/57005721)

***

# 代码读取 info.plist
```swift
// info.plist 文件
Bundle.main.infoDictionary
// InfoPlist.strings 文件
Bundle.main.localizedInfoDictionary
```
```swift
// 读取 localizedInfoDictionary 时要注意有可能没有值
if let appName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
    config.albumName = appName
} else {
    config.albumName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
}
```

***

# storyboard & 代码自定义 view
- storyboard/xib 创建的 view 可以在 awakeFromNib 中自定义初始化
    - 会先调用 init(:coder) 再调用 awakeFromNib
- 代码创建的 view 可以在 init(:frame) 中进行自定义初始化

***

# 收起软键盘
1. scroll view 拖拽时收起: storyboard 选择 scrollView 右侧属性 `keyboard -> dismiss on drag`
    - 选择 `dismiss interactively` 时，向下拉 scrollView 时，键盘会跟着向下收起 (比较适合信息类 app)
    - 也可代码设置: `scrollView.keyboardDismissMode = .onDrag`
2. textField 隐藏软键盘
    ```swift
    // 方法一实现 UITextFieldDelegate
    extension NoteEditVC : UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // 隐藏软键盘
            return true
        }
    }
    ```
    ```swift
    // 方法二通过 textField 的 end on exit 事件函数
    @IBAction func textFieldEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder() // 隐藏软键盘
    }
    ```
3. 点击空白处，收起软键盘
    ```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true) // 收起软键盘
    }
    ```

***

# UITextField 限制用户输入
## 利用 UITextField 的 edit changed 事件
该事件会在字符输入后调用

```swift
// 超出最大字符限制时截取文本，从而实现限制输入的效果
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
```

## 利用 UITextFieldDelegate
```swift
extension NoteEditVC : UITextFieldDelegate {
    // return false 会阻止用户输入
    // range.location: 当前输入的字符或粘贴文本在所有文本中的 start index
    // string: 当前输入的字符 (当复制粘贴时为粘贴的文本)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 超出最大限制字符长度, 禁止输入 (需要限制粘贴时的字符长度)
        // 1. 输入的字符或粘贴的文本在整体内容的索引是 20 的时候 (第 21 个字符不让输入)
        // 2. 当前输入的字符的长度 + 粘贴文本的长度超过 20 时，防止从一开始一下子粘贴超过 20 个字符的文本
        let isExceed = range.location >= kMaxNoteTitleCount || (textField.unwrappedText.count + string.count) > kMaxNoteTitleCount
        
        if isExceed {
            showTextHUB("标题最多输入\(kMaxNoteTitleCount)字哦")
        }
        
        return !isExceed
    }
}
```

***

# 修改 TextView 样式
## 添加 placeholder
```ruby
pod 'KMPlaceholderTextView', '~> 1.4.0'
```
storyboard 中设置 TextView 为 KMPlaceholderTextView，即可设置 placeholder

## 设置行高
```swift
// 文本的左右缩进边距
let lineFragmentPadding = textView.textContainer.lineFragmentPadding
textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)

// 调整 text view 样式
let paragraphStyle = NSMutableParagraphStyle()
// paragraphStyle.lineHeightMultiple = 2 // 行高是原来的两倍
paragraphStyle.lineSpacing = 6 // 行间距为 6
// 设置字体样式
let typingAttributes: [NSAttributedString.Key: Any] = [
    .paragraphStyle: paragraphStyle,
    // 该设置会使 sb 中设置的字体样式失效，所以需要自己重新再指定一下
    .font: UIFont.systemFont(ofSize: 14),
    .foregroundColor: UIColor.secondaryLabel
]
textView.typingAttributes = typingAttributes
```

## 设置 TextView 光标颜色
```swift
// sb 中设置 textView tint color 后(光标颜色)，需要调用一下这个方法才会生效
textView.tintColorDidChange()
```

***

# TableView 无数据时不显示分隔线
sb 上加一个高度为 1 的 footer 即可

```swift
// 或代码实现
tableView.tableFooterView = UIView()
```

***

# 访问沙盒
- NSHomeDirectory: 获取沙盒主目录
- NSTemporaryDirectory: 获取临时文件目录
- `NSSearchPathForDirectoriesInDomains(_ directory: FileManager.SearchPathDirectory, _ domainMask: FileManager.SearchPathDomainMask, _ expandTilde: Bool) -> [String]`: 寻找文件夹的方法
- `urls(for:in:)`

## 沙盒下的文件夹
- Documents: 主要存放一些比较重要的数据，其会自动进行 icould 备份
    - 手机打开了 iclould 功能，系统会在连接 wifi 时自动备份该文件夹
    - 苹果不允许该文件夹存储网络下载下来的东西
- Library: (除了 Caches，也会进行自动备份)
    - Application Support: CoreData 存储的文件夹
    - Caches: 缓存文件夹
        - 一些比较大的临时文件可以放这里或者 tmp 文件夹，该文件夹不会自动备份
    - Preferences: UserDefault 存储的文件夹 (存储一些 app 的设置)
    - SplashBoard: 存放启动页的缓存
        - 有时候更改了启动页没有生效，可能就是因为这里的缓存导致的
        - 可以这样删除缓存 `FileManager.default.removeItem(atPath: "\(NSHomeDirectory())/Library/SplashBoard")`
- tmp: 临时文件夹(不会备份)，会在 app 关闭的时候不定期的进行清理

```swift
// /Users/wutong/Library/Developer/CoreSimulator/Devices/FEA966A4-AEB1-4ADF-98F8-B88D5CD05DB0/data/Containers/Data/Application/11C7D635-6D2C-449B-8A82-F759E46AD7ED
print(NSHomeDirectory())
// 在沙盒内寻找 document 文件夹
// /Users/wutong/Library/Developer/CoreSimulator/Devices/FEA966A4-AEB1-4ADF-98F8-B88D5CD05DB0/data/Containers/Data/Application/11C7D635-6D2C-449B-8A82-F759E46AD7ED/Documents
print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
// ~/Documents
print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false)[0])
// file:///Users/wutong/Library/Developer/CoreSimulator/Devices/FEA966A4-AEB1-4ADF-98F8-B88D5CD05DB0/data/Containers/Data/Application/11C7D635-6D2C-449B-8A82-F759E46AD7ED/Documents/
print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
```

***

# GCD
```swift
// 全局并发队列
DispatchQueue.global().async {
    // fetch data
    let data try! Data(contentsOf: URL(string: "https://xxx.jpg"))
    let image = UIImage(data)!
    
    // 主线程更新 UI
    DispatchQueue.main.async {
        // update ui
        self.imgView.image = image
    }
}
```

***

