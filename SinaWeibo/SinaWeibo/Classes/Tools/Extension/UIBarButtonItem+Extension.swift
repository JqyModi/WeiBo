//
//  UIBarButtonItem+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //重写便利构造器
    convenience init(imageName: String,target: Any?, actionName: String?) {
        let btn = UIButton(type: .custom)
        //测试
//        btn.setTitle("tool", for: .normal)
        btn.setTitleColor(UIColor.randomColor(), for: .normal)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        //添加点击事件
        if let action = actionName, let targetObj = target {
            btn.addTarget(targetObj, action: Selector(action), for: .touchUpInside)
        }
        
        self.init(customView: btn)
    }
}
