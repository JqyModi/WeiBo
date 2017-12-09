//
//  DiscoverTableViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct DConstants {
    static let IconViewImageName = "visitordiscover_image_message"
    static let TipLabelText = "登录后，最新最热微博尽在掌握，不再会与实事潮流擦肩而过"
}
class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setupUIInfo(imageName: DConstants.IconViewImageName, text: DConstants.TipLabelText)
    }

}
