//
//  ComposeViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class ComposeViewController: UIViewController {

    @objc private func close() {
        debugPrint("close ~~ ")
        dismiss(animated: true, completion: nil)
    }
//    statuses/upload
//    发表带图片的微博。必须用POST方式提交pic参数，且Content-Type必须设置为multipart/form-data。图片大小<5M
    @objc private func send() {
        debugPrint("send ~~ ")
        
        //判断用户是否登录
        guard let token = UserAccountViewModel().token else {
            SVProgressHUD.show(withStatus: "客官~ 请先登录再发微博哦")
            return
        }
        
        let url = "2/statuses/update.json"
//        let url = "https://api.weibo.com/2/statuses/update.json"
        let params = ["access_token": token, "status" : textView.text!]
//        NetWorkTools.sharedTools.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        NetWorkTools.sharedTools.requestJsonDict(method: .POST, urlString: url, params: params) { (result, error) in
//            if error == nil {
//                SVProgressHUD.show(withStatus: "发布成功 ~ ")
//                self.dismiss(animated: true, completion: nil)
//                debugPrint("result = \(result)")
//            }else {
//                SVProgressHUD.showError(withStatus: "微博发布失败 ~ ")
//                debugPrint("发布失败 ~ ")
//            }
//
            if error != nil {
                SVProgressHUD.showError(withStatus: AppErrorTip)
                return
            }
            SVProgressHUD.showSuccess(withStatus: "发布Weibo成功")
            self.dismiss(animated: true, completion: nil)
            print(result)

        }
        
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
        center.addObserver(self, selector: #selector(self.keyboardWillChange(notify:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
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
        
        //根据frame计算出键盘高度：？
        debugPrint("y = \(frame.origin.y)")
        let keyboardHeight = -(screenH - frame.origin.y)
        //动态修改toolbar位置： 高度
        toolBar.snp.updateConstraints { (make) in
            make.bottom.equalTo(keyboardHeight)
        }
        //更新约束后强制刷新界面
        UIView.animate(withDuration: duration) {
            //以动画方式过渡刷新效果：不那么唐突
            self.view.layoutIfNeeded()
        }
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
        
        //
        tv.delegate = self
        
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
//监听文本状态改变
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        //隐藏占位文本
        placeHolderLabel.isHidden = textView.hasText
        //设置发布按钮交互：textView.hasText判断是否有文字
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}

extension ComposeViewController {
    
    private func setNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: "send")
        //没有文本时不可点击
        self.navigationItem.rightBarButtonItem?.isEnabled = false
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
