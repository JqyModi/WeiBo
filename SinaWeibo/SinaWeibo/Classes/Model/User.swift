//
//  User.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class User: NSObject {
    @objc var id: Int = 0
    @objc var name: String?
    @objc var profile_image_url: String?
    
    var headImageURL: NSURL? {
        return NSURL(string: profile_image_url ?? "")
    }
    //等级：0~6
    var mbrank: Int = 0
    var mbrankImage: UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    //认证类型：-1：没有认证, 0:普通认证 ,2,3,5：企业认证 ,220：达人
    var verified_type: Int = -1
    //认证类型对应图片
    var verified_type_Image: UIImage? {
        switch verified_type {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    
    //KVC设置初始值
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //过滤属性
    }
}
