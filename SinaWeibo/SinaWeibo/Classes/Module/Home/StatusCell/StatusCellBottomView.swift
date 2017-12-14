//
//  StatusCellBottomView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {
    
    @objc private func retweetedBtnDidClick() {
        let tmp = TempViewController()
        retweetedBtn.getNavController()?.pushViewController(tmp, animated: true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //设备背景色
        backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(retweetedBtn)
        addSubview(composeBtn)
        addSubview(likeBtn)
        
        //添加布局约束
        let w: CGFloat = 0.5
        let scale: CGFloat = 0.4
        
        retweetedBtn.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.height.equalTo(snp.height)
        }
        
        //添加分割线
        let sep1 = sepView()
        addSubview(sep1)
        sep1.snp.makeConstraints { (make) in
//            make.top.equalTo(snp.top)
            make.left.equalTo(retweetedBtn.snp.right)
            make.height.equalTo(retweetedBtn.snp.height).multipliedBy(scale)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(w)
        }
        
        composeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(retweetedBtn.snp.right)
            make.top.equalTo(snp.top)
            make.height.equalTo(snp.height)
            make.width.equalTo(retweetedBtn.snp.width)
        }
        
        //添加分割线
        let sep2 = sepView()
        addSubview(sep2)
        sep2.snp.makeConstraints { (make) in
            make.left.equalTo(composeBtn.snp.right)
            make.height.equalTo(composeBtn.snp.height).multipliedBy(scale)
            make.centerY.equalTo(snp.centerY)
            make.width.equalTo(w)
        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(composeBtn.snp.right)
            make.top.equalTo(snp.top)
            make.right.equalTo(snp.right)
            make.height.equalTo(snp.height)
            make.width.equalTo(retweetedBtn.snp.width)
        }
        
        //添加点击事件
        retweetedBtn.addTarget(self, action: "retweetedBtnDidClick", for: .touchUpInside)
        
    }
    
    //定义分割线
    private func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = .darkGray
        return v
    }
    
    //延时加载控件
    private lazy var retweetedBtn = UIButton(title: "转发", backImage: "", color: .darkGray, image: "timeline_icon_retweet", size: 10)
    private lazy var composeBtn = UIButton(title: "评论", backImage: "", color: .darkGray, image: "timeline_icon_comment", size: 10)
    private lazy var likeBtn = UIButton(title: "赞", backImage: "", color: .darkGray, image: "timeline_icon_unlike", size: 10)
}
