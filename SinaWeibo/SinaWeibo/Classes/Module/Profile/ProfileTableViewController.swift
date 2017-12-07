//
//  ProfileTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct Constants {
    static let IconViewImageName = "visitordiscover_image_profile"
    static let TipLabelText = "登录后，你的微博、相册、个人资料显示在这里，展示给别人"
}
class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupUIInfo(imageName: Constants.IconViewImageName, text: Constants.TipLabelText)
    }

}
