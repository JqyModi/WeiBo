//
//  UserAccount.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

/*
 自定义模型：归档与解归档
 1.遵循NSCoding协议
 2.实现两个方法：
 */
class UserAccount: NSObject, NSCoding {
    
    //用户令牌:用户授权的唯一票据，用于调用微博的开放接口
    //4.0需要兼容OC机制
    @objc var access_token: String?
    //access_token生命周期：单位秒：类型跟文档说明不一致可能是调整过
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    //新增用户过期日期
    @objc var expires_date: NSDate?
    
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
    
    //MARK: - 实现NSCoding协议：归档与解归档 类似 序列化与反序列化
    
    //对外提供(class)归档与解归档操作
    class func loadAccount() -> UserAccount? {
        //获取根路径+拼接文件路径
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as! NSString).appendingPathComponent("account.plist")
        if let account = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? UserAccount {
            //判断是否过期：比较两个日期orderedDescending下降的
            if account.expires_date?.compare(Date()) == .orderedDescending {
                return account
            }
        }
        return nil
    }
    
    func savaAccount() {
        //获取根路径+拼接文件路径
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as! NSString).appendingPathComponent("account.plist")
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
        //打印路径
        debugPrint("path = \(path)")
    }
    
    //归档：自定义对象转二进制
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(name, forKey: "name")
        //
        aCoder.encode(expires_date, forKey: "expires_date")
    }
    //解归档：二进制转自定义对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        //基本数据类型可以直接解归档
        expires_in = aDecoder.decodeDouble(forKey: "expires_in")
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        //
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //重写此方法：将没有定义为属性的key-value忽略掉，只初始化定义为的属性
    }
    
    override var description: String {
        //利用系统函数来间接获取description
        let keys = ["access_token","expires_in","uid","avatar_large","name","expires_date"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
