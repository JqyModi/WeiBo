//
//  TempViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

//被push的控制器不能继承UINavigationViewController
class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(navigationController?.childViewControllers.count)"
        view.backgroundColor = UIColor.randomColor()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tmp = TempViewController()
        navigationController?.pushViewController(tmp, animated: true)
    }
    
    
}
