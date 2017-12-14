//
//  UIView+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

extension UIView {
    
    //通过响应者链条找到导航控制器：
    func getNavController() -> UINavigationController? {
        //获取当前视图对象的下一个响应者
        var resp = self.next
        //遍历响应者链条
        repeat {
            debugPrint("repeat")
            //找到导航控制器
            if resp is UINavigationController {
                return resp as? UINavigationController
            }
            resp = resp?.next
        }while(resp != nil)
        debugPrint("DidRepeat")
        return nil
    }

}
