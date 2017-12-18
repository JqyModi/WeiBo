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
    
    convenience init(title: String?, backImage: String, color: UIColor?, image: String = "", size: CGFloat = 14) {
        //调用父类构造方法实例化该对象
        self.init()
        //设置属性
        if (title != nil) {
            setTitle(title, for: .normal)
        }
        if backImage != "" {
            setBackgroundImage(UIImage(named: backImage), for: .normal)
            setBackgroundImage(UIImage(named: backImage + "_highlighted"), for: .selected)
        }
        setImage(UIImage(named: image), for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        
        if color != nil {
            setTitleColor(color, for: .normal)
        }
    }
}
