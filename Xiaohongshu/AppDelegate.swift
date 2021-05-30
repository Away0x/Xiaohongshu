//
//  AppDelegate.swift
//  Xiaohongshu
//
//  Created by 吴彤 on 2021/4/2.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        config()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    // core data 持久化容器
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Xiaohongshu")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    // core data 存储数据的方法
    func saveContext () {
        let context = persistentContainer.viewContext
        // 如果持久化容器中的数据有变化，则存储到本地
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // 并发队列上的 context 存储
    func saveBackgroundContext(){
        // 因可以有多个并发队列的 context,故每次 persistentContainer.viewContext 时都会创建个新的, 故不能像上面一样.
        // 这里需用使用同一个并发队列的 context (即常量文件夹中引用的那个)
        if backgroundContext.hasChanges{
            do {
                try backgroundContext.save()
            } catch {
                fatalError("后台存储数据失败(包括增删改):\(error)")
            }
        }
    }
}

extension AppDelegate {
    private func config() {
        // 配置高德地图 (如果需要定位海外地址，需要开通高德海外 LBS)
        AMapServices.shared().enableHTTPS = true
        AMapServices.shared().apiKey = "83c1ad414cc8a51c8bdc76109d531049"
        
        // 设置所有的 navigationItem 的返回按钮颜色
        UINavigationBar.appearance().tintColor = .label
    }
}
