//
//  Status.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class Status: NSObject {
    //Swift4.0要使用系统自带字典转模型必须加上OC兼容关键字：@objc
    @objc var created_at: String?
    @objc var id: Int = 0
    @objc var text: String?
    @objc var source: String?
    
    //新增user属性
    @objc var user: User?
    
    init(dict: [String : Any]) {
        super.init()
        //
        setValuesForKeys(dict)
    }
    //重写该方法来实例化user
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            if let dic = value as? [String : Any] {
                user = User(dict: dic)
            }
            //结束
            return
        }
        super.setValue(value, forKey: key)
    }
    
    //过滤点没有用到字符
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
}
