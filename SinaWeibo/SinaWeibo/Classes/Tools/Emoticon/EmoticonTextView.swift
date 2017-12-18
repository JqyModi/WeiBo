//
//  EmoticonTextView.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class EmoticonTextView: UITextView {

    //将属性文本转换成字符串
    func fulltext() -> String {
        let attrText = attributedText
        //遍历属性文本的属性
        
        var strMM = String()
        attrText.enumerateAttributesInRange(NSRange(location: 0, length: attrText.length), options: []) { (dict, range, _) -> Void in
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment {
                //                print("是图片")
                let text = attachment.chs
                strMM += (text ?? "")
                //将图片替换成本
            } else {
                //                print("是文本")
                let str = (attrText.string as NSString).substringWithRange(range)
                strMM += str
            }
        }
        
        return strMM
    }
    
    func insertAttrText(emoticon: Emoticon) {
        //空表情
        if emoticon.isEmpty {
            print("空表情")
            return
        }
        
        //删除
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        
        //emoji表情
        if emoticon.code != nil {
            replaceRange(selectedTextRange!, withText: emoticon.emojiStr ?? "")
            return
        }
        
        
        //点击图片表情
        //1.将点击的图片添加到 附件中
        let attachment = EmoticonAttachment()
        let imageText = attachment.emoticonimageText(emoticon, font:font!)
        
        //在替换前  记录光标选中的位置
        let range = selectedRange
        //3.获取textView的属性文本
        let strM =  NSMutableAttributedString(attributedString: attributedText)
        //4.替换属性文本
        
        strM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
        
        //5.替换属性文本
        attributedText = strM
        
        //6.恢复光标的位置
        selectedRange = NSMakeRange(range.location + 1, 0)
    }

}
