//
//  BaseTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct BConstants {
    static let NavLeftBtnText = "登录"
    static let NavRightBtnText = "注册"
}
class BaseTableViewController: UITableViewController {

    //设置是否登录开关
//    var userLogin = true
    var userLogin = UserAccountViewModel().userLogin
    
    var visitorView: VisitorLoginView?
    
    //加载视图：Apple专门为手写代码设计等效于sb/xib创建 一旦手动实现该方法sb/xib自动失效
    //loadView自动检测当前控制器View是否为空若空则自动调用loadView方法
    override func loadView() {
        //切换访客视图
        userLogin ? super.loadView() : loadVisitorView()
    }
    //初始化访客视图
    func loadVisitorView() {
        //加载访客视图
        visitorView = VisitorLoginView()
        view = visitorView
    }
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置代理点击事件
        visitorView?.visitorDelegate = self
        
        //设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: BConstants.NavLeftBtnText, style: .done, target: self, action: #selector(BaseTableViewController.visitorWillLogin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: BConstants.NavRightBtnText, style: .done, target: self, action: #selector(BaseTableViewController.visitorWillRegister))
        
        //设置主题色：在此设置主题色会出现刚开始没有渲染成功需要点击操作后才能触发
        //已在AppDelegate中设置全局的
        //UINavigationBar.appearance().tintColor = UIColor.orange
    }
}
extension BaseTableViewController: VisitorLoginViewDelegate {
    @objc func visitorWillLogin() {
        debugPrint("login in")
        
        //跳转到登录页
        let oauth = OAuthViewController()
        oauth.title = "登录"
        let nav = UINavigationController(rootViewController: oauth)
        present(nav, animated: true, completion: nil)
    }
    
    @objc func visitorWillRegister() {
        debugPrint("register")
    }
}

