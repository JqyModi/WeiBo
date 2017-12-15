//
//  ComposeViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SnapKit

class ComposeViewController: UIViewController {

    @objc private func close() {
        debugPrint("close ~~ ")
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func send() {
        debugPrint("send ~~ ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setupUI()
        
        //监听键盘事件
        registerNotification()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        setNavBar()
        //设置文本输入框
        setTextView()
        //设置工具条
        setToolBar()
    }
    
    private func registerNotification() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: "keyboardWillChange:", name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        //移除通知
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    @objc private func keyboardWillChange(notify: Notification) {
        //获取键盘弹出动画时间：通过键值对方式获取
        let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        //获取键盘frame : NSValue?
        let frame = (notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //根据frame计算出键盘高度
        let keyboardHeight = -screenH + frame.origin.y
        //动态修改toolbar位置： 高度
        toolBar.snp.updateConstraints { (make) in
            make.bottom.equalTo(keyboardHeight)
        }
        //更新约束后强制刷新界面
        
    }
    
    //延时加载标题视图
    private lazy var titleView: UIView = {
       let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        v.backgroundColor = UIColor.randomColor()
        
        //添加子布局
        let titleLabel = UILabel(title: "发微博", fontSize: 17, color: .darkGray)
        let nameLabel = UILabel(title: UserAccountViewModel().userName ?? "", fontSize: 14, color: .lightGray)
        
        //add
        v.addSubview(titleLabel)
        //>?
//        titleLabel.addSubview(nameLabel)
        v.addSubview(nameLabel)
        
        //设置约束
        titleLabel.snp.makeConstraints({ (make) in
            //titleView约束与正常约束相反
            make.bottom.equalTo(v.snp.bottom)
            make.centerX.equalTo(v.snp.centerX)
        })
        nameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(v.snp.top)
            make.centerX.equalTo(v.snp.centerX)
        })
        
        return v
    }()
    
    //微博文本输入框
    private lazy var textView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = UIColor.randomColor()
        //如果需要设置成提示文字：实现监听事件
//        tv.text = "分享新鲜事 ~~~ "
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textColor = .darkGray
        //设置键盘消失模式
        tv.keyboardDismissMode = .onDrag
        //开启弹簧效果
        tv.alwaysBounceVertical = true
        return tv
    }()
    
    //延时加载提示占位文本
    private lazy var placeHolderLabel: UILabel = UILabel(title: "分享新鲜事 ~~~ ", fontSize: 18, color: .lightGray)
    //工具条
    private lazy var toolBar: UIToolbar = UIToolbar()
    
}

extension ComposeViewController {
    private func setNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: "send")
        self.navigationItem.titleView = titleView
    }
    
    private func setTextView() {
        view.addSubview(textView)
        
        //添加占位文本控件
        textView.addSubview(placeHolderLabel)
        
        //
        textView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            //预留键盘位
            make.height.equalTo(view.bounds.height / 3)
        }
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(textView).offset(8)
        }
    }
    
    private func setToolBar() {
        view.addSubview(toolBar)
        
        //添加约束
        toolBar.snp.makeConstraints { (make) in
            //相对于View还是textView？
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(40)
        }
        var items = [UIBarButtonItem]()
        //图标数据
        let itemIcons = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background"],
                            ["imageName": "compose_add_background"]]
        for dict in itemIcons {
            let imageName = dict["imageName"]!
            let item = UIBarButtonItem(imageName: imageName)
            items.append(item)
            
            //设置间隔
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        
        //删除最后一个间隔
        items.removeLast()
        
        toolBar.items = items
        
    }
}
