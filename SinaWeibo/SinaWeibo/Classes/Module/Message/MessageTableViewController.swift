//
//  MessageTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct MConstants {
    static let IconViewImageName = "visitordiscover_image_message"
    static let TipLabelText = "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"
}
class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupUIInfo(imageName: MConstants.IconViewImageName, text: MConstants.TipLabelText)
    }

}
