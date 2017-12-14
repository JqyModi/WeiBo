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
        loadData(finished: { (statuses) in
            if statuses?.count == nil {
                SVProgressHUD.showInfo(withStatus: AppErrorTip)
            }
            //获取到数据：初始化数据模型
            self.statuses = statuses!
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
        
        //设置分割线
        self.tableView.separatorStyle = .none
        
        //自动计算行高：Cell自动布局1
        //1.设置估计值
        self.tableView.estimatedRowHeight = tableView.rowHeight
        //2.设置自动计算
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    private func loadData(finished: @escaping (_ array: [Status]?) -> ()) {
        let AFN = AFHTTPSessionManager()
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        guard let token = UserAccountViewModel().token else {
            SVProgressHUD.showInfo(withStatus: "您尚未登录 ~")
            return
        }
        let params = ["access_token" : token]
        AFN.get(url, parameters: params, progress: nil, success: { (_, data) in
            //判断是否有数据
            guard let dict = data as? [String : Any] else {
                SVProgressHUD.showInfo(withStatus: "访问失败")
                finished(nil)
                return
            }
            //[[String : Any]]字典类型数组
            if let statuses = dict["statuses"] as? [[String : Any]] {
                var array = [Status]()
                //遍历数组
                for item in statuses {
                    if let dic = item as? [String : Any] {
                        let status = Status(dict: dic)
                        array.append(status)
                    }
                }
                finished(array)
            }
        }) { (_, error) in
            debugPrint("error = \(error)")
        }
    }
    
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
        
        debugPrint("retweetstatus = \(data.retweeted_status)")
        return cell!
    }
}

