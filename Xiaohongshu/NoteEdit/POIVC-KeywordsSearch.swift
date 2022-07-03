//
//  POIVC-KeywordsSearch.swift
//  Xiaohongshu
//  关键字搜索
//  Created by 吴彤 on 2021/5/9.
//

// MARK: - UISearchBarDelegate
extension POIVC : UISearchBarDelegate {
    // 点击 search bar 的 cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { dismiss(animated: true) }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 清空文本框时，还原列表数据为周边搜索数据
        if searchText.isEmpty {
            pois = aroundSearchedPOIs // 恢复为之前周边搜索的数据
            // 重置上拉加载事件函数和 footer 状态
            setAroundSearchFooter()
            tableView.reloadData()
        }
    }
    
    // 用户点击了软键盘的 return key 按钮
    // sb 中可以设置 Return key 为 search
    // 并且设置 auto-enable return key 为 true, 避免没输入内容时也可点击 return key 按钮
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isBlank else { return }
        keywords = searchText
        
        pois.removeAll() // 恢复为检索前的空数据状态
        currentKeywordPage = 1
        
        // 进行关键字搜索
        setKeywordSearchFooter()
        showLoadHUB()
        makeKeywordsSearch(keywords)
    }
}

// MARK: - 一般函数
extension POIVC {
    // 关键字搜索
    private func makeKeywordsSearch(_ keywords: String, _ page: Int = 1){
        keywordSearchRequest.keywords = keywords
        keywordSearchRequest.page = page
        print("关键字搜索:", keywords, page)
        mapSearch?.aMapPOIKeywordsSearch(keywordSearchRequest)
    }
    
    // 设置关键字搜索时上拉加载的事件函数
    private func setKeywordSearchFooter() {
        mjFooter.resetNoMoreData()
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
    }
    
    // 关键字搜索，上拉加载
    @objc private func keywordsSearchPullToRefresh() {
        currentKeywordPage += 1
        makeKeywordsSearch(keywords, currentAroundPage)
        endRefreshing(currentKeywordPage)
    }
}
