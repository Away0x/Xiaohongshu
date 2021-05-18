//
//  POIVC.swift
//  Xiaohongshu
//  添加地点 POI
//  Created by 吴彤 on 2021/5/6.
//

import UIKit

class POIVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // 上拉加载 footer
    lazy var mjFooter = MJRefreshAutoNormalFooter()
    
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
        request.offset = kPOIsOffset
        request.types = kPOITypes // 分类检索
        request.requireExtension = true // 获取拓展信息
        return request
    }()
    // 周边搜索的分页信息
    var currentAroundPage = 1
    var pageCount = 0
    
    // 关键字检索
    lazy var keywordSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true // 获取拓展信息
        request.offset = kPOIsOffset
        return request
    }()
    
    // table 数据
    var pois = kPOIsInitArr
    var aroundSearchedPOIs = kPOIsInitArr //完全同步copy周边的pois数组，用于简化逻辑
    
    // 当前位置的经纬度
    var latitude = 0.0
    var longitude = 0.0
    // 地点检索的关键字
    var keywords = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
        
        searchBar.becomeFirstResponder() // focus
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
