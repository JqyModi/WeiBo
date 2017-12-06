//
//  MainViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }
    
    private struct Constants {
        static let HomeTabbarName = "主页"
        static let MessageTabbarName = "消息"
        static let DiscoverTabbarName = "发现"
        static let ProfileTabbarName = "我"
        
        static let HomeTabbarImageName = "tabbar_home"
        static let MessageTabbarImageName = "tabbar_message_center"
        static let DiscoverTabbarImageName = "tabbar_discover"
        static let ProfileTabbarImageName = "tabbar_profile"
    }

    private func addChildViewControllers() {
        addChildViewController(vc: HomeTableViewController(), title: Constants.HomeTabbarName, imageName: Constants.HomeTabbarImageName)
        addChildViewController(vc: MessageTableViewController(), title: Constants.MessageTabbarName, imageName: Constants.MessageTabbarImageName)
        addChildViewController(vc: DiscoverTableViewController(), title: Constants.DiscoverTabbarName, imageName: Constants.DiscoverTabbarImageName)
        addChildViewController(vc: ProfileTableViewController(), title: Constants.ProfileTabbarName, imageName: Constants.ProfileTabbarImageName)
    }
    
    //方法重载
    private func addChildViewController(vc: UIViewController, title: String, imageName: String) {
        //添加导航控制器
        let nav = UINavigationController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        
        //设置主题色替换下面的操作
        self.tabBar.tintColor = UIColor.orange
        
        //添加选中图片
//        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //添加选中字体颜色
//        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], for: .selected)
        
        //添加
        addChildViewController(nav)
    }
}
