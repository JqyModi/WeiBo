//
//  UserAccount.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

class UserAccount: NSObject {
    //用户令牌:用户授权的唯一票据，用于调用微博的开放接口
    //4.0需要兼容OC机制
    @objc var access_token: String?
    //access_token生命周期：单位秒
    @objc var expires_in: String?
    //用户uid
    @objc var uid: String?
    
    //用户头像
    @objc var avatar_large: String?
    //用户昵称
    @objc var name: String?
    
    init(dict: [String : Any]) {
        super.init()
        //KVC设置初始值
        setValuesForKeys(dict)
        
    }
    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        //重写此方法：将没有定义为属性的key-value忽略掉，只初始化定义为的属性
//    }
        override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    override var description: String {
        //利用系统函数来间接获取description
        let keys = ["access_token","expires_in","uid","avatar_large","name"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
