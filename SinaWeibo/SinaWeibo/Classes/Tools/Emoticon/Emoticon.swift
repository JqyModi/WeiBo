//
//  Emoticon.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    //分组表情的文件夹名称
    var id: String?
    
    //表情中文字符串
    var chs: String?
    //表情图片名 
    var png: String?
    
    //图片路径计算型属性
    var imagePath: String? {
        if let idName = id, pngName = png {
            let path = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(idName)/" + pngName
            return path
        }
        
        return nil
        
    }
    
    //emoji表情的十六进制的字符串
    var code: String?
    
    
    //定义计算型属性  计算emoji 字符串 
    
    //每次调用的时候都会执行
    var emojiStr: String? {
        if let codeStr = code {
            return codeStr.emojiString
        }
        
        return nil
    }
    
    
    //增加标记删除按钮的属性
    var isRemove = false
    
    //增加标记空白按钮的属性
    var isEmpty = false
    //KVC构造方法  
    init(id: String,dict: [String : String]) {
        self.id = id
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    //增加标记是否是删除按钮的实例化方法 
    init(isRemove: Bool) {
        self.isRemove = isRemove
        super.init()
    }
    
    //增加标记是否是空白按钮的实例化方法
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init()
    }
    
    //过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    
    //重写description
    override var description: String {
        
        let keys = ["chs", "code", "png"]
        
        return dictionaryWithValuesForKeys(keys).description
    }
}
