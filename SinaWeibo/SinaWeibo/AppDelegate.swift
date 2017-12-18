//
//  AppDelegate.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        //设置跟视图
//        window?.rootViewController = MainViewController()
        //新增欢迎页
//        window?.rootViewController = WelComeViewController()
        //新增引导页:重写了构造方法不需要传递参数
//        window?.rootViewController = NewFeatureCollectionViewController()
        //
        window?.rootViewController = defaultRootViewController()
        
        //为了方便调试先将跟视图改为ComposeViewController
//        let nav = UINavigationController(rootViewController: ComposeViewController())
//        window?.rootViewController = nav
        
        //发微博视图选择器测试
//        window?.rootViewController = PictureSelectorCollectionViewController()
        
        //注册通知
        registerNotification()
        
        debugPrint("版本信息： \(isNewVersion())")
        
        //设置全局主题色
        setThemeColor()
        
        return true
    }
    
    @objc private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.switchToRootVC(notification:)), name: NSNotification.Name(rawValue: AppSwitchRootViewController), object: nil)
    }
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func switchToRootVC(notification: Notification) {
        if (notification.object as? String) != nil {
            window?.rootViewController = WelComeViewController()
            //不继续往下执行
            return
        }
        window?.rootViewController = MainViewController()
    }
    
    // MARK: - 判断用户登录与版本更新
    private func defaultRootViewController() -> UIViewController {
        //判断用户是否登录
        if UserAccountViewModel().userLogin {
            //判断版本是否更新：登录之后才会有版本更新：不会下载来重来不用就更新版本
            return isNewVersion() ? NewFeatureCollectionViewController() : WelComeViewController()
        }
        return MainViewController()
    }

    private func setThemeColor() {
        UINavigationBar.appearance().tintColor = themeColor
        UITabBar.appearance().tintColor = themeColor
    }
    
    //判断是否是新版本
    private func isNewVersion() -> Bool {
        //获取新版本：获取info中版本信息
        let vStr = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        let newVersion = Double(vStr!)
        debugPrint("newVersion = \(newVersion)")
        //获取旧版本：一般保存在沙盒中
        let oldVersionKey = "OldVersionKey"
        let userdefault = UserDefaults.standard
        let oldVersion = userdefault.double(forKey: oldVersionKey)
        debugPrint("oldVersion = \(oldVersion)")
        //保存新版本
        userdefault.set(newVersion, forKey: oldVersionKey)
        //保存
        userdefault.synchronize()
        //比较新旧版本
        return newVersion! > oldVersion
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

