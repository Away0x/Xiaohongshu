//
//  ChannelTableVC.swift
//  Xiaohongshu
//  选择话题 - 子页面
//  Created by 吴彤 on 2021/5/6.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {
    
    var channel = ""
    var subChannels: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subChannels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)
        
        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = parent as! ChannelVC // 得到父视图控制器
        channelVC.PVDelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])
        
        // 根据 present 及 dismiss 机制，子视图控制器的 presentingViewController 和父视图一样 (这里为 NoteEditVC)
        // 所以这里 dismiss 就等于是在父视图控制器中 dismiss
        dismiss(animated: true)
        
    }

}

extension ChannelTableVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
