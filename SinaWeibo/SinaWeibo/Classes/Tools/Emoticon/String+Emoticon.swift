//
//  String+Emoticon.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import Foundation

//分类中种只能定义计算型属性 (只读属性)

extension String {
    var emojiString: String {
        
        //使用扫描器  扫描指定的字符串
        let scanner = NSScanner(string: self)
        //扫描字符串中的十六进制的字符串
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        //将十六进制的字符串 转换成 unicode 字符
        let char = Character(UnicodeScalar(value))
        //表情字符
        return "\(char)"
    }
}
