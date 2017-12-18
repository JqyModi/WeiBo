//
//  EmoticonPackage.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    
    //表情数组 
    lazy var emoticonList = [Emoticon]()
    
    //表情分组的包名
    var id: String?
    //表情分组的中文名称
    var group_name_cn: String?
    
    
    /*
    遗留问题
    

    每隔20个按钮需要一个删除按钮
    页面表情不足21个需要补足
    */
    init(id: String,name: String,emoticons:[[String : String]]) {
        self.id = id
        self.group_name_cn = name
        super.init()
        //将 表情字典数组  转换为模型数组
        //遍历字典数组
        
        //定义标记  
        var index = 0
        for item in emoticons {
            //拿到单个表情字段  
            //字典转模型
            let e = Emoticon(id: id, dict: item)
            emoticonList.append(e)
            
            index++
            if index == 20 {
                //添加删除模型
                let deleteEmoticon = Emoticon(isRemove: true)
                emoticonList.append(deleteEmoticon)
                
                // 非常重要  恢复标记
                index = 0
            }
        }
        
        //不足21个 补足空表情 
        insertEmptyEmoticon()
    
    }
    
    
    private func insertEmptyEmoticon() {
        let count = emoticonList.count % 21
        if count == 0 {
            //刚好有21个表情 
            return
        }
        
        for _ in count..<20 {
            //添加空表情模型
            let empty = Emoticon(isEmpty: true)
            emoticonList.append(empty)
        }
        
        //最后一个 添加删除按钮
        let deleteEmoticon = Emoticon(isRemove: true)
        emoticonList.append(deleteEmoticon)
        
    }
    
    //重写description
    override var description: String {
        return "id = \(id),name = \(group_name_cn)"
    }
}
