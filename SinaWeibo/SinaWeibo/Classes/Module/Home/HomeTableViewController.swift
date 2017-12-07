//
//  HomeTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct Constants {
    //主页图片已经在VisitorLoginView中设置好了
    static let IconImageViewName = "visitordiscover_feed_image_house"
    static let TipLableText = "关注一些人，回来看看这里有什么惊喜。关注一些人，回来看看这里有什么惊喜。"
    static let NavLeftBtnText = "登录"
    static let NavRightBtnText = "注册"
}
class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupUIInfo(imageName: nil, text: Constants.TipLableText)
    }

    
}

