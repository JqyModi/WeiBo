//
//  UILabel+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

//重写遍历构造器
extension UILabel {
    //新增margin参数：默认可不传
    convenience init(title: String, fontSize: CGFloat, color: UIColor, margin: CGFloat = 0) {
        //初始化控件
        self.init()
        text = title
//        font = UIFont.boldSystemFont(ofSize: fontSize)
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        textAlignment = .center
        numberOfLines = 0
        
        //添加margin
        if margin != 0 {
            //设置添加margin后的宽度
            preferredMaxLayoutWidth = screenW - 2 * margin
            textAlignment = .left
        }
//        backgroundColor = UIColor.orange
        sizeToFit()
    }
}
