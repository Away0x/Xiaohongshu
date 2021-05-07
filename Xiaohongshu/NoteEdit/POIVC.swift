//
//  POIVC.swift
//  Xiaohongshu
//  添加地点 POI
//  Created by 吴彤 on 2021/5/6.
//

import UIKit

class POIVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 获取定位 https://lbs.amap.com/api/ios-location-sdk/guide/get-location/singlelocation
    lazy var locationManager = AMapLocationManager()
    // 周边搜索 https://lbs.amap.com/api/ios-sdk/guide/map-data/poi
    lazy var mapSearch = AMapSearchAPI()
    lazy var aroundSearchRequest: AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(
            withLatitude: CGFloat(latitude),
            longitude: CGFloat(longitude)
        )
        // request.requireExtension = true
        return request
    }()
    
    var pois = [["不显示位置", ""]]
    
    // 当前位置的经纬度
    var latitude = 0.0
    var longitude = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
        
        mapSearch?.delegate = self
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
