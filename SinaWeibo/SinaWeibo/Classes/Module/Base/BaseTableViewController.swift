//
//  BaseTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    //设置是否登录开关
    var userLogin = true
    
    //加载视图：Apple专门为手写代码设计等效于sb/xib创建 一旦手动实现该方法sb/xib自动失效
    //loadView自动检测当前控制器View是否为空若空则自动调用loadView方法
    override func loadView() {
        //切换访客视图
        userLogin ? super.loadView() : loadVisitorView()
    }
    //初始化访客视图
    func loadVisitorView() {
        let v = UIView()
        v.backgroundColor = UIColor.orange
        view = v
    }
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

}
