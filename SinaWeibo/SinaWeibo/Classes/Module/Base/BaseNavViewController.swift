//
//  BaseNavViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //重写该方法来自定义导航栏返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count != 0 {
            //重写返回按钮
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: "back")
            //隐藏底部导航控件：TabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        //继续系统导航操作
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func back() {
        //弹出操作
        navigationController?.popViewController(animated: true)
    }
}
