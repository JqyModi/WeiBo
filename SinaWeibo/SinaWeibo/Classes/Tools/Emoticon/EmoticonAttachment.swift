//
//  EmoticonAttachment.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class EmoticonAttachment: NSTextAttachment {
    //附件的文本
    var chs: String?
    
    //将图片添加到附件中 -> 转换成属性文本
    
    func emoticonimageText(emoticon: Emoticon,font: UIFont) -> NSAttributedString {
        //想附件中 添加图片
        image = UIImage(contentsOfFile: emoticon.imagePath ?? "")
        chs = emoticon.chs
        //设置附件的大小
        let height = font.lineHeight
        bounds = CGRect(x: 0, y: -4, width: height, height: height)
        //2.将 附件转换为属性文本
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        imageText.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, 1))
        //给图片文本添加属性
       return imageText
    }
}
