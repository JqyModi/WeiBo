//
//  EmoticonManager.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

//主要负责加载组织所有表情文件 工具类 
class EmoticonManager: NSObject {
    
    lazy var packages = [EmoticonPackage]()
    
    override init() {
        super.init()
        loadPackages()
    }
    
    
    //加载分组表情
    func loadPackages() {
        //获取分组路径
        let path = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist", inDirectory: "Emoticons.bundle")
        
        //将plist文件 转换成字典
        let dict = NSDictionary(contentsOfFile: path!)!
        if let array = dict["packages"] as? [[String : AnyObject]] {
            for item in array {
                let id = item["id"] as! String
                //加载分组表情
                loadGroupPackage(id)
            }
        }
    }
    
    private func loadGroupPackage(id: String) {
        //获取每个分组中的Info.plist
        print(id)
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist", inDirectory: "Emoticons.bundle/\(id)")
        let dict = NSDictionary(contentsOfFile: path!)!
        //字典转模型
        let name = dict["group_name_cn"] as! String
        let array = dict["emoticons"] as! [[String : String]]
        let p = EmoticonPackage(id: id, name: name, emoticons: array)
        //向数组中添加表情分组
        packages.append(p)
    }
}
