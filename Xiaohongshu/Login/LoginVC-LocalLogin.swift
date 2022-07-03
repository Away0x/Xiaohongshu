//
//  LoginVC-LocalLogin.swift
//  Xiaohongshu
//  本机一键登录
//  Created by 吴彤 on 2021/6/2.
//

import Foundation

extension LoginVC {
    @objc func localLogin() {
        // 初始化极光认证 https://docs.jiguang.cn/jverification/client/ios_api/
        let config = JVAuthConfig()
        config.appKey = kJAppKey
        // 初始化回调
        config.authBlock = { result in
            // print("aaa", result, JVERIFICATIONService.isSetupClient())
            if JVERIFICATIONService.isSetupClient() {
            // if let result = result, let code = result["code"] as? Int, code == 8000 {
                print("极光认证初始化成功")
                // 获取用户手机号
                JVERIFICATIONService.preLogin(5000) { result in
                    print("bbb", result)
                    if let result = result, let code = result["code"] as? Int, code == 7000 {
                        print("当前设备可使用一键登录")
                    } else {
                        print("当前设备不可使用一键登录")
                    }
                }
            } else {
                print("极光认证初始化失败")
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
}
