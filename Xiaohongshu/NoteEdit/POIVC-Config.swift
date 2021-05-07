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
    }
}
