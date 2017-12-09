//
//  VisitorLoginView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
private struct VConstants {
    static let CircleImageViewName = "visitordiscover_feed_image_smallicon"
    static let IconImageViewName = "visitordiscover_feed_image_house"
    static let TipLableText = "关注一些人，回来看看这里有什么惊喜。关注一些人，回来看看这里有什么惊喜。"
    static let TipLabelFontSize: CGFloat = 14
    static let LoginBtnText = "登录"
    static let RegisterBtnText = "注册"
    static let LoginBtnImageNameBG = "common_button_white_disable"
    static let RegisterBtnImageNameBG = "common_button_white_disable"
    static let MaskImageViewName = "visitordiscover_feed_mask_smallicon"
    
    //VFL方式添加约束条件
    static let BackViewHorizontalConstraintFormat = "H:|-0-[backView]-0-|"
    static let BackViewVerticalConstraintFormat = "V:|-0-[backView]-(-35)-[registerBtn]"
    static let BackViewConstraintKey = "backView"
    static let RegisterBtnConstraintKey = "registerBtn"
    
    //Animation
    static let CAAnimationKeyPath = "transform.rotation"
}

protocol VisitorLoginViewDelegate: NSObjectProtocol {
    func visitorWillLogin()
    func visitorWillRegister()
}

class VisitorLoginView: UIView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    //采用若引用防止内存泄漏：Swift默认强引用
    weak var visitorDelegate: VisitorLoginViewDelegate?
    
    @objc private func loginBtnDidClick() {
        visitorDelegate?.visitorWillLogin()
    }
    
    @objc private func registerBtnDidClick() {
        visitorDelegate?.visitorWillRegister()
    }
    
    //重写构造方法
    init() {
        // CGRect.zero ?
        super.init(frame: CGRect.zero)
        //加载子视图
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIInfo(imageName: String?, text: String) {
        
        iconView.isHidden = false
        tipLabel.text = text
        
        if let image = imageName {
            circleView.image = UIImage(named: image)
            bringSubview(toFront: circleView)
            iconView.isHidden = true
        }else {
            startAnimation()
        }
    }
    
    func startAnimation() {
        let caAnim = CABasicAnimation(keyPath: VConstants.CAAnimationKeyPath)
        caAnim.toValue = 2 * M_PI
        caAnim.duration = 20
        caAnim.repeatCount = HUGE
        //结束不移除动画
        caAnim.isRemovedOnCompletion = false
        //给circleView添加动画
        circleView.layer.add(caAnim, forKey: "caAnim")
    }
    
    private func setupUI() {
        addSubview(circleView)
        //添加背景遮罩视图：
        addSubview(backView)
        addSubview(iconView)
        addSubview(tipLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        //设置frame布局方式失效：采用代码自动布局
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //设置布局：采用VFL：跟界面上的拖拽效果一样：
        //约束公式："view1.attr1 = view2.attr2 * multiplier + constant"
        //设置circleView约束
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: circleView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        //设置iconView约束
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: circleView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: circleView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        //设置tipLabel约束
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: circleView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top, relatedBy: .equal, toItem: circleView, attribute: .bottom, multiplier: 1.0, constant: 16))
        //设置tipLabel宽度约束
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        //设置tipLabel高度约束
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        //设置loginBtn约束
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        //设置loginBtn宽度约束
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        //设置loginBtn高度约束
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        //设置registerBtn约束
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        //设置registerBtn宽度约束
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        //设置registerBtn高度约束
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        //添加遮罩约束：VFL
        //水平方向
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: VConstants.BackViewHorizontalConstraintFormat, options: [], metrics: nil, views: [VConstants.BackViewConstraintKey : backView]))
        //竖直方向
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: VConstants.BackViewVerticalConstraintFormat, options: [], metrics: nil, views: [VConstants.BackViewConstraintKey : backView, VConstants.RegisterBtnConstraintKey : registerBtn]))
        
        //设置背景颜色消除色差：设置灰度0.93
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        //设置按钮点击事件
        loginBtn.addTarget(self, action: #selector(VisitorLoginView.loginBtnDidClick), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(VisitorLoginView.registerBtnDidClick), for: .touchUpInside)
    }
    
    //延时加载所有子视图
    private lazy var circleView: UIImageView = UIImageView(image: UIImage(named: VConstants.CircleImageViewName))
    
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: VConstants.IconImageViewName))
    
    private lazy var tipLabel: UILabel = {
        let l = UILabel()
        l.text = VConstants.TipLableText
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: VConstants.TipLabelFontSize)
        l.textColor = UIColor.lightGray
        l.numberOfLines = 0
        //
        l.sizeToFit()
        return l
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(VConstants.LoginBtnText, for: .normal)
        btn.setBackgroundImage(UIImage(named: VConstants.LoginBtnImageNameBG), for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        return btn
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(VConstants.RegisterBtnText, for: .normal)
        btn.setBackgroundImage(UIImage(named: VConstants.RegisterBtnImageNameBG), for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        return btn
    }()
    
    private lazy var backView: UIImageView = UIImageView(image: UIImage(named: VConstants.MaskImageViewName))
}




