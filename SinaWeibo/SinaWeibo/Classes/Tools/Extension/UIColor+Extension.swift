//
//  UIColor+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let r: CGFloat = CGFloat(arc4random() % 255) / 255
        let g: CGFloat = CGFloat(arc4random() % 255) / 255
        let b: CGFloat = CGFloat(arc4random() % 255) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
