//
//  WelComeViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SnapKit

class WelComeViewController: UIViewController {

    //显示手码视图
    override func loadView() {
        view = backView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置视图布局
        setupUI()
        
//        startAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    func startAnimation() {
        //更新iconView的位置变化约束
        iconView.snp.updateConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-view.bounds.height + 180)
        }
        
        //usingSpringWithDamping：弹簧系数 0~1 : 越小动力越大
        //initialSpringVelocity：加速度 = 弹簧系数 * 10
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 9.8, options: [], animations: {
            //强制刷新已经改变约束的布局
            /*
             一般在自动布局中使用动画效果  不建议直接修改frame
             自动布局系统 会根据设置的约束 在layoutSubViews方法中自动修改frame
             frame 是由自动布局系统来控制的
             如果希望能够提前刷新修改的约束效果  需要调用 layoutIfNeeded() 让约束提前刷新 ,更新frame
             */
            self.view.layoutIfNeeded()
        }) { (complete) in
            //设置welcomeLabel透明度动画
            UIView.animate(withDuration: 0.6, animations: {
                self.welcomeLabel.alpha = 1
            }, completion: { (_) in
                debugPrint("OK Completion ~")
                //发送页面切换通知1
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppSwitchRootViewController), object: nil)
            })
        }
    }
    
    func setupUI() {
        //添加子视图
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        //设置布局约束：用框架布局：SnapKit
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-180)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            //iconView.snp.bottom
            make.top.equalTo(iconView.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        //设置透明度
        welcomeLabel.alpha = 0
        
        //设置iconView图片
        iconView.setImageWith(UserAccountViewModel().headURL as! URL, placeholderImage: UIImage(named: "avatar_default_big"))
        
        //设置图片圆角
//        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 45
        iconView.layer.masksToBounds = true
    }
    
    //懒加载控件
    var backView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    var iconView: UIImageView = UIImageView()
    
//    var welcomeLabel: UILabel = {
//        let l = UILabel()
//        l.textColor = UIColor.lightGray
//        l.textAlignment = .center
//        l.font = UIFont.systemFont(ofSize: 19)
//        l.text = (UserAccountViewModel().userName ?? "") + " 欢迎回来 ~"
//        l.alpha = 0
//        l.sizeToFit()
//        return l
//    }()
    var welcomeLabel: UILabel = UILabel(title: (UserAccountViewModel().userName ?? "") + " 欢迎回来 ~", fontSize: 19, color: .lightGray)
    
}
