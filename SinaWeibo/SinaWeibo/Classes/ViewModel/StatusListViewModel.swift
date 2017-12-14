//
//  StatusListViewModel.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import SVProgressHUD

//继承NSObject目的：可以使用系统提供的一些特性：如自动字典转模型
class StatusListViewModel: NSObject {
    
    //加载主页微博数据
    func loadData(finished: @escaping (_ array: [Status]?) -> ()) {
        
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        guard let token = UserAccountViewModel().token else {
            SVProgressHUD.showInfo(withStatus: "您尚未登录 ~")
            return
        }
        let params = ["access_token" : token]
        
        NetWorkTools.sharedTools.requestJsonDict(method: .GET, urlString: url, params: params) { (result, error) in
            //判断是否有数据
            guard let dict = result as? [String : Any] else {
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
        }
    }
}
