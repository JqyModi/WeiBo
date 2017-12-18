//
//  EmoticonCell.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    //设置模型 绑定数据
    var emoticon: Emoticon? {
        didSet {
            
            //设置按钮的图片
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon?.imagePath ?? ""), forState: .Normal)
            
            //设置emoji字符串
            emoticonBtn.setTitle(emoticon?.emojiStr ?? "", forState: .Normal)
            
            //设置删除按钮的图片
            if let em = emoticon where em.isRemove {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
        }
    }
    
    //MARK: 3.重写父类的构造方法 调用设置UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emoticonBtn)
        
        //要使用bounds
//        emoticonBtn.frame = self.bounds
        emoticonBtn.frame = CGRectInset(bounds, 4, 4)
        emoticonBtn.titleLabel?.font = UIFont.systemFontOfSize(32)
        emoticonBtn.backgroundColor = UIColor.whiteColor()
        //设置不能交互
        emoticonBtn.userInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: 1. 懒加载所有子控件
    private lazy var emoticonBtn: UIButton = UIButton()
}
