//
//  UIButton+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

//扩展UIButton便利构造器
extension UIButton {
    
    convenience init(title: String, backImage: String, color: UIColor) {
        //调用父类构造方法实例化该对象
        self.init()
        //设置属性
        setTitle(title, for: .normal)
        setBackgroundImage(UIImage(named: backImage), for: .normal)
        setBackgroundImage(UIImage(named: backImage + "_highlighted"), for: .selected)
        if color != nil {
            setTitleColor(color, for: .normal)
        }
    }
}
