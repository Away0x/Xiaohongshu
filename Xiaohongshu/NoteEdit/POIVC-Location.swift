//
//  POIVC-Location.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/7.
//

extension POIVC {
    func requestLocation() {
        // 请求权限，并进行定位
        showLoadHUB() // 显示 loading
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    // 定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHub() // 隐藏 loading
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
                    self?.hideLoadHub()
                    return
                }
                else {
                    // 没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            guard let POIVC = self else {
                self?.hideLoadHub()
                return
            }
            
            if let location = location {
                // 存储经纬度
                // NSLog("location:%@", location)
                POIVC.latitude = location.coordinate.latitude
                POIVC.longitude = location.coordinate.longitude
                // 搜索周边，搜索成功会触发 onPOISearchDone
                POIVC.makeAroundSearch()
                // 设置周边搜索时上拉加载的事件函数
                POIVC.mjFooter.setRefreshingTarget(POIVC, refreshingAction: #selector(POIVC.aroundSearchPullToRefresh))
            }
            
            if let reGeocode = reGeocode {
                // NSLog("reGeocode:%@", reGeocode)
                // 只允许请求国内地址
                guard let formattedAddress = reGeocode.formattedAddress, !formattedAddress.isEmpty else { return }
                
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province
                let addr = "\(province.unwrappedValue)\(reGeocode.city.unwrappedValue)\(reGeocode.district.unwrappedValue)\(reGeocode.street.unwrappedValue)\(reGeocode.number.unwrappedValue)"
                let currentPOI = [reGeocode.poiName ?? kNoPOIPH, addr]
                
                POIVC.pois.append(currentPOI)
                POIVC.aroundSearchedPOIs.append(currentPOI)
                
                DispatchQueue.main.async {
                    POIVC.tableView.reloadData()
                }
            }
        })
    }
}

// MARK: - 所有 POI 搜索的回调 AMapSearchDelegate
extension POIVC : AMapSearchDelegate {
    // 搜索请求结束
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        self.hideLoadHub() // 隐藏 loading
        if response.count == 0 { return }
        
        for poi in response.pois {
            let province = poi.province == poi.city ? "" : poi.province
            let addr = poi.district == poi.address ? "" : poi.address
            let poi = [poi.name ?? kNoPOIPH, "\(province.unwrappedValue)\(poi.city.unwrappedValue)\(poi.district.unwrappedValue)\(addr.unwrappedValue)"]
            
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest {
                aroundSearchedPOIs.append(poi) // 备份周边搜索的结果，以便与还原
            }
        }
        
        
        if response.count > kPOIsOffset {
            pageCount = Int(ceil(Double(response.count) / Double(kPOIsOffset)))
        } else {
            mjFooter.endRefreshingWithNoMoreData()
        }
        
        tableView.reloadData()
    }
}

extension POIVC {
    // 搜索周边地点
    func makeAroundSearch(_ page: Int = 1) {
        aroundSearchRequest.page = page
        mapSearch?.aMapPOIAroundSearch(aroundSearchRequest)
    }
}

extension POIVC {
    // 周边加载上拉加载, 请求下一页的数据
    @objc func aroundSearchPullToRefresh() {
        currentAroundPage += 1
        makeAroundSearch(currentAroundPage)
        if currentAroundPage < pageCount {
            mjFooter.endRefreshing()
        } else {
            mjFooter.endRefreshingWithNoMoreData()
        }
    }
}
