//
//  POIVC-Config.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/7.
//

extension POIVC {
    func config() {
        // 带逆地理信息的一次定位 (返回坐标和地址信息)
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // 定位超时时间，最低 2s
        locationManager.locationTimeout = 5
        // 逆地理请求超时时间，最低 2s
        locationManager.reGeocodeTimeout = 5
        
        // 上拉加载 footer
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(aroundSearchPullToRefresh))
        tableView.mj_footer = mjFooter
        
        // 点击空白处收起软键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
