//
//  UIImage+Extension.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

extension UIImage {
    
    //扩展宽高
    var height: CGFloat {
        return self.size.height
    }
    var width: CGFloat {
        return self.size.width
    }
    
    /// 图片压缩
    ///
    /// - Parameter targetWidth: 压缩后图片宽度
    /// - Returns: 返回压缩后图片
    func imageCompress(targetWidth: CGFloat) -> UIImage? {
        //获取原图片宽高比
        let ratio = height/width
        //计算出压缩后的高
        let targetHeight = targetWidth * ratio
        //开始压缩
        UIGraphicsBeginImageContext(CGSize(width: targetWidth, height: targetHeight))
        //设置压缩时Rect
        self.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
        //获取压缩后图片
        let targetImage = UIGraphicsGetImageFromCurrentImageContext()
        //结束压缩
        UIGraphicsEndImageContext()
        return targetImage
    }
}
