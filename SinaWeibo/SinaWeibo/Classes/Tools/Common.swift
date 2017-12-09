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
    static let client_secret = "e05466cab537175d1ec28314154bd160"
    static let redirect_uri = "http://39.108.219.113/Music/index.html"
}
let themeColor = UIColor.orange

