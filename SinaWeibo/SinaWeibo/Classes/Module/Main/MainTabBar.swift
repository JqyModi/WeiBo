//
//  MainTabBar.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //通过sb/xib创建的View控件走此构造方法
    required init?(coder aDecoder: NSCoder) {
        //为了使程序不会崩溃
        super.init(coder: aDecoder)
        //崩溃
        //fatalError("init(coder:) has not been implemented")
        //保证两种方式都可以创建出该控件
        setupUI()
    }
    
    //设置MainTabBar位置居中：需要改变所有子视图位置在viewDidLayoutSubviews操作
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //打印布局的层次结构
        debugPrint(subviews)
        //计算每个子视图宽高
        let w = self.bounds.width / 5
        let h = self.bounds.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        
        //遍历所有子视图获取到UITabBarButton
        var index: CGFloat = 0
        for view in subviews {
            if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                debugPrint(view)
                //重新布局TabBar位置
                view.frame = rect.offsetBy(dx: index * w, dy: 0)
                //预留位置给MainTabBar：三目运算符考虑优先级：+=优先级较低
                index += index == 1 ? 2 : 1
                
//                if index == 1 {
//                    index = index + 1
//                }
//                index = index + 1
                
            }
        }
        
        //布局composeBtn
        composeBtn.frame = rect.offsetBy(dx: 2 * w, dy: -10)
        //前置控件
        bringSubview(toFront: composeBtn)
    }
    
    private struct Constants {
        static let MainTabbarComposeButtonNormalBG = "tabbar_compose_button"
        static let MainTabbarComposeButtonHighLightedBG = "tabbar_compose_button_highlighted"
        static let MainTabbarComposeButtonNormal = "tabbar_compose_icon_add"
        static let MainTabbarComposeButtonHighLighted = "tabbar_compose_icon_add_highlighted"
    }
    
    func setupUI() {
        addSubview(composeBtn)
    }
    
    //延时加载创建一个Button按钮
    lazy var composeBtn: UIButton = {
        let btn = UIButton()
        //设置btn样式
        btn.setBackgroundImage(UIImage(named: Constants.MainTabbarComposeButtonNormalBG), for: .normal)
        btn.setBackgroundImage(UIImage(named: Constants.MainTabbarComposeButtonHighLightedBG), for: .selected)
        btn.setImage(UIImage(named: Constants.MainTabbarComposeButtonNormal), for: .normal)
        btn.setImage(UIImage(named: Constants.MainTabbarComposeButtonHighLighted), for: .selected)
        
        //跳转大小: 跟背景图大小一致
        btn.sizeToFit()
        return btn
    }()
}
