//
//  UserAccountViewModel.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation
import AFNetworking

class UserAccountViewModel {
    
    //提取常用属性
    var account: UserAccount?
    
    var userLogin:Bool {
        return account?.access_token != nil
    }
    
    init() {
        account = UserAccount.loadAccount()
    }
    
    var userName: String? {
        return account?.name
    }
    
    var token: String? {
        return account?.access_token
    }
    
    var headURL: NSURL? {
        return NSURL(string: (account?.avatar_large ?? ""))
    }
    
    //2.获取用户令牌
    func loadAccessToken(code: String, finished: @escaping (_ error: Error?) -> ()) {
        let AFN = AFHTTPSessionManager()
        let params = ["client_id": Constants.client_id,"client_secret": Constants.client_secret,"grant_type": "authorization_code","code": code,"redirect_uri": Constants.redirect_uri]
        AFN.post(Constants.tokenBaseUrl, parameters: params, progress: nil, success: { (_, data) in
            //获取到用户令牌
            debugPrint("data = \(data)")
            if let dict = data as? [String : Any] {
                //将字典转为UserAccount模型类
                let account = UserAccount(dict: dict)
                //通过传递一个引用来继续填充其他属性
                //直接传递一个闭包
                self.loadUserInfo(account: account, finished: finished)
            }
        }) { (_, error) in
            debugPrint("error = \(error)")
        }
    }
    //3.获取用户信息: 酷客_VB
    //    func loadUserInfo(accessToken: String, uid: String) {
    func loadUserInfo(account: UserAccount, finished: @escaping (_ error: Error?) -> ()) {
        //        let url = Constants.userInfoUrl
        let url = "https://api.weibo.com/2/users/show.json"
        let params = ["access_token" : account.access_token, "uid" : account.uid]
        let AFN = AFHTTPSessionManager()
        
        //调试技巧：查看数据类型
        //1.将响应序列号重新初始化不指定任何解析格式：返回一个二进制数据
        //AFN.responseSerializer = AFHTTPResponseSerializer()
        //默认支持解析类型：- `application/json`- `text/json`- `text/javascript`
        //可添加支持类型
        //AFN.responseSerializer.acceptableContentTypes?.insert("text/html")
        //2.将二进制转String(data: data, encoding: "utf8")
        //3.打印String看有无"XX"扩起来 无则表示基本数据类型
        AFN.get(url, parameters: params, progress: nil, success: { (_, data) in
            if let dict = data as? [String : Any] {
                account.avatar_large = dict["avatar_large"] as? String
                account.name = dict["name"] as? String
                //归档到本地
                account.savaAccount()
                finished(nil)
            }
        }) { (_, error) in
            finished(error)
            debugPrint("error = \(error)")
        }
    }
}
