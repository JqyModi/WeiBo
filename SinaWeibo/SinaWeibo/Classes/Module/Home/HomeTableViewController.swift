//
//  HomeTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

private let reuseIdentifier = "Cell"
private struct HConstants {
    //主页图片已经在VisitorLoginView中设置好了
    static let IconImageViewName = "visitordiscover_feed_image_house"
    static let TipLableText = "关注一些人，回来看看这里有什么惊喜。关注一些人，回来看看这里有什么惊喜。"
    static let NavLeftBtnText = "登录"
    static let NavRightBtnText = "注册"
}
class HomeTableViewController: BaseTableViewController {

    //定义数据模型
    private lazy var statuses = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if !userLogin {
            visitorView?.setupUIInfo(imageName: nil, text: HConstants.TipLableText)
        }
        
        prepareTableView()
        
        //加载微博首页数据
        loadData()
        
    }
    
    @objc private func loadData() {
        
        var since_id = 0
        var max_id = 0
        
        if indicatorView.isAnimating {
            //上拉加载
            since_id = 0
            //获取最后一条数据max_id来判断是否需要加载更多数据
            max_id = statuses.last?.id ?? 0
        }else {
            //下拉刷新
            max_id = 0
            //取第一条数据的since_id来判断是否有新数据：下拉刷新
            since_id = statuses.first?.id ?? 0
        }
        
        //since_id max_id同时有值不返会数据
        StatusListViewModel().loadData(since_id: since_id, max_id: max_id, finished: { (statuses) in
            //请求成功停止下拉刷新
            self.refreshControl?.endRefreshing()
            
            if statuses == nil {
                SVProgressHUD.showInfo(withStatus: AppErrorTip)
                //加载数据失败 停止转动
                self.indicatorView.stopAnimating()
            }
            
            //获取到数据：初始化数据模型
            if since_id > 0 {
                //刷新数据叠加
                self.statuses = self.statuses + statuses!
            }
            else if max_id > 0 {
                //刷新数据叠加
                self.statuses = self.statuses + statuses!
                //加载数据完成 停止转动
                self.indicatorView.stopAnimating()
            }
            else {
                //首次加载
                self.statuses = statuses!
            }
            //刷新表格
            self.tableView.reloadData()
            debugPrint("数据：\(self.statuses.count) 条")
        })
    }
    
    private func prepareTableView() {
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        //设置行高
        self.tableView.rowHeight = 200
        
        //设置下拉刷新
        refreshControl = UIRefreshControl()
        //添加监听
        refreshControl?.addTarget(self, action: "loadData", for: .valueChanged)
        
        //添加上拉加载布局
        self.tableView.tableFooterView = indicatorView
        
        //设置分割线
        self.tableView.separatorStyle = .none
        
        //自动计算行高：Cell自动布局1
        //1.设置估计值
        self.tableView.estimatedRowHeight = tableView.rowHeight
        //2.设置自动计算
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private lazy var indicatorView: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView()
        aiv.color = UIColor.randomColor()
//        aiv.hidesWhenStopped = true
        aiv.activityIndicatorViewStyle = .gray
        return aiv
    }()

}

//继承时已经实现了该协议：UITableViewDataSource,UITableViewDelegate
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? StatusTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? StatusTableViewCell
        //展示数据
        let data = statuses[indexPath.row]
        cell?.status = data
        
        //设置上拉加载数据操作：当Cell是上拉加载布局Cell时且菊花没有滚动状态下开始上拉加载数据
        if indexPath.row == statuses.count - 1 && !indicatorView.isAnimating {
            //开始上拉加载
            indicatorView.startAnimating()
            loadData()
            debugPrint("开始加载更多数据")
        }
        
        debugPrint("retweetstatus = \(data.retweeted_status)")
        return cell!
    }
}

