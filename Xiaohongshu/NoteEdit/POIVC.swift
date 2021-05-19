//
//  POIVC.swift
//  Xiaohongshu
//  添加地点 POI
//  Created by 吴彤 on 2021/5/6.
//

import UIKit

class POIVC: UIViewController {
    
    // 用于反向传值，返回上一个页面时使用
    var delegate: POIVCDelegate?
    // 用于正向传值，其他页面进入这个页面时使用
    var poiName = ""
    
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
    var pageCount = 0 // 周边搜索和关键字搜索的总页数
    
    // 关键字检索
    lazy var keywordSearchRequest: AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true // 获取拓展信息
        request.offset = kPOIsOffset
        return request
    }()
    // 关键字检索的分页信息
    var currentKeywordPage = 1
    
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
        
        mapSearch?.delegate = self
    }
    
}

// MARK: - UITableViewDataSource
extension POIVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { pois.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        let poi = pois[indexPath.row]
        
        cell.poi = poi
        
        if poi[0] == poiName { cell.accessoryType = .checkmark }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension POIVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark // cell 右侧会出现一个勾
        // 反向传值
        delegate?.updatePOIName(pois[indexPath.row][0])
        dismiss(animated: true)
    }
}
