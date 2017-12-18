//
//  Common.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

//应用相关信息
struct Constants {
    static let SinaBaseUrl = "https://api.weibo.com/"
    //请求授权码URL
    static let codeBaseUrl = SinaBaseUrl + "oauth2/authorize"
    static let tokenBaseUrl = SinaBaseUrl + "oauth2/access_token"
    static let userInfoUrl = SinaBaseUrl + "2/users/show.json"
    
    static let ClientIDKey = "client_id"
    static let RedirectUrlKey = "redirect_uri"
    static let client_id = "4090434754"
    static let client_secret = "666e08d518a86aa7b6b65fe7e4d5d01b"
    static let redirect_uri = "http://39.108.219.113/Music/index.html"
    
    static let token = "2.004izJEGGwCp9Eaa20962a7d15SEBC"
}

//MARK: HOME背景色
let homeBGColor = UIColor(white: 0.95, alpha: 1)

let themeColor = UIColor.orange

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height

//通知相关信息
let AppSwitchRootViewController = "AppSwitchRootViewController"


//错误提示相关信息
//网络开小差了 ~
let AppErrorTip = "网络君正在睡觉💤 请稍后再来~~·"

