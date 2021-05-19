//
//  Protocols.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/5/6.
//

import Foundation

protocol ChannelVCDelegate {
    /// 用户从选择话题页返回编辑笔记页面传值用
    /// - Parameter channel: 传回来的  channel
    /// - Parameter subChannel: 传回来的  subChannel
    func updateChannel(channel: String, subChannel: String)
}

// 笔记搜索地区页面反向传值协议
protocol POIVCDelegate {
    func updatePOIName(_ name: String)
}
