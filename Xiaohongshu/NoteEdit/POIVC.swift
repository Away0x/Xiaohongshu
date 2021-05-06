//
//  POIVC.swift
//  Xiaohongshu
//  添加地点 POI
//  Created by 吴彤 on 2021/5/6.
//

import UIKit

class POIVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // https://lbs.amap.com/api/ios-location-sdk/guide/get-location/singlelocation
    private let locationManager = AMapLocationManager()
    
    private var pois = [["不显示位置", ""]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 带逆地理信息的一次定位 (返回坐标和地址信息)
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // 定位超时时间，最低 2s
        locationManager.locationTimeout = 5
        // 逆地理请求超时时间，最低 2s
        locationManager.reGeocodeTimeout = 5
        // 请求权限，并进行定位
        showLoadHUB() // 显示 loading
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            self?.hideLoadHub() // 隐藏 loading
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    // 定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    // 逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
                else {
                    // 没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let POIVC = self else { return }
            
            if let location = location {
                NSLog("location:%@", location)
            }
            
            if let reGeocode = reGeocode {
                // NSLog("reGeocode:%@", reGeocode)
                // 只允许请求国内地址
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province!
                let addr = "\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")"
                let currentPOI = [reGeocode.poiName!, addr]
                
                POIVC.pois.append(currentPOI)
                DispatchQueue.main.async {
                    POIVC.tableView.reloadData()
                }
            }
        })
    }
    
}

extension POIVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        
        cell.poi = pois[indexPath.row]
        
        return cell
    }
}

extension POIVC : UITableViewDelegate {
    
}
