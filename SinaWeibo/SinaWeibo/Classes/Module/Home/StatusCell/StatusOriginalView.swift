//
//  StatusOriginalView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class StatusOriginalView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = homeBGColor
        
        //加载子控件
        addSubview(iconImage)
        addSubview(nameLabel)
        //
        addSubview(verifiedIconView)
        addSubview(memberIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        //设置布局约束
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.top)
            make.left.equalTo(iconImage.snp.right).offset(StatusCellMargin)
        }
        memberIconView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin)
        }
        verifiedIconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImage.snp.right)
            make.centerY.equalTo(iconImage.snp.bottom)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconImage.snp.bottom)
            make.left.equalTo(iconImage.snp.right).offset(StatusCellMargin)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(iconImage.snp.right)
        }
        
    }
    
    //定义延时加载控件
    private lazy var iconImage: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var nameLabel: UILabel = UILabel(title: "酷客_VB", fontSize: 17, color: .darkGray)
    //用户认证类型小图标
    private lazy var verifiedIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    //用户等级小图标
    private lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    //发布时间
    private lazy var timeLabel: UILabel = UILabel(title: "11:11", fontSize: 10, color: .orange)
    //微博来源
    private lazy var sourceLabel: UILabel = UILabel(title: "来自: 火星🔥", fontSize: 10, color: .lightGray)
    //微博正文
    private lazy var contentLabel: UILabel = UILabel(title: "酷客_攻城狮", fontSize: 14, color: .lightGray)
    
}