# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Xiaohongshu' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Xiaohongshu
  # 顶部 tab bar 布局
  pod 'XLPagerTabStrip', '~> 9.0'
  # 瀑布流布局
  pod 'CHTCollectionViewWaterfallLayout/Swift'
  # 选取照片
  pod 'YPImagePicker' # 不注明版本, 使用最新版本
  # 提示框 (OC)
  pod 'MBProgressHUD', '~> 1.2.0'
  # 图片浏览器
  pod 'SKPhotoBrowser'
  # 给 text view 加 placeholder
  pod 'KMPlaceholderTextView', '~> 1.4.0'
  # 高德地图 sdk
  pod 'AMapLocation' # https://lbs.amap.com/api/ios-location-sdk/gettingstarted
  pod 'AMapSearch' # https://lbs.amap.com/api/ios-sdk/gettingstarted
  # 下拉刷新/上拉加载
  pod 'MJRefresh'
  # 时间日期处理
  pod 'DateToolsSwift'
  # 极光认证
  pod 'JVerification' # https://docs.jiguang.cn/jverification/client/ios_guide/
  
  # Fix: M1 模拟器运行项目报错
  # https://juejin.cn/post/6920218654013407246
  # arch -x86_64 pod repo update
  # arch -x86_64 pod update
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end

end
