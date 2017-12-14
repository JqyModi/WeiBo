//
//  StatusTableViewCell.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SnapKit

//定义在外部其它类也可以访问
let StatusCellMargin: CGFloat = 12
let StatusCellIconWidth: CGFloat = 35

class StatusTableViewCell: UITableViewCell {
    
    //记录底部约束
    var bottomConstraint: Constraint?
    
    //设置模型数据
    var status: Status? {
        didSet {
            //属性传递
            originalView.status = status
            //设置RetweetStatusView数据源
//            if let rs = status?.retweeted_status {
//                retweetStatusView.retweetStatus = status?.retweeted_status
//            }
            
            //更新约束前先去掉原来的约束
            self.bottomConstraint?.deactivate()
            
            //判断有无配图再动态显示底部视图：多个判断条件用逗号隔开
            if let rs = status?.retweeted_status {
                //是转发微博
                retweetStatusView.retweetStatus = rs
                //显示转发视图
                retweetStatusView.isHidden = false
                //更新约束
                bottomView.snp.makeConstraints({ (make) in
                    self.bottomConstraint = make.top.equalTo(retweetStatusView.snp.bottom).offset(StatusCellMargin).constraint
                })
            }else {
                //隐藏
                retweetStatusView.isHidden = true
                //更新约束
                bottomView.snp.makeConstraints({ (make) in
                    // ?
                    self.bottomConstraint = make.top.equalTo(originalView.snp.bottom).offset(StatusCellMargin).constraint
                })
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //设置选中状态
        selectionStyle = .none
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(originalView)
        //添加底部点赞视图
        contentView.addSubview(bottomView)
        //
//        contentView.addSubview(pictureView)
        
        contentView.addSubview(retweetStatusView)
        
        //添加布局约束
        originalView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            //不再指定高度：Cell自动布局2
//            make.height.equalTo(50)
        }
        
//        pictureView.snp.makeConstraints { (make) in
//            make.top.equalTo(originalView.snp.bottom).offset(StatusCellMargin)
//            make.left.equalTo(originalView.snp.left).offset(StatusCellMargin)
//            make.width.equalTo(100)
//            make.height.equalTo(100)
//        }
        
        retweetStatusView.snp.makeConstraints { (make) in
            make.top.equalTo(originalView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(originalView.snp.left)
            make.right.equalTo(originalView.snp.right)
        }
            
        bottomView.snp.makeConstraints { (make) in
//            make.top.equalTo(originalView.snp.bottom).offset(StatusCellMargin)
//            make.top.equalTo(originalView.snp.bottom)
            // -
//            make.top.equalTo(retweetStatusView.snp.bottom).offset(StatusCellMargin)
            //将约束转换成约束类型：记录底部约束
            self.bottomConstraint = make.top.equalTo(retweetStatusView.snp.bottom).constraint
            
//            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            //高度设置40：snapKit设置自动布局的关键是要将高度自适应的控件放在固定视图之间，如这里的BottomView的位置可以确定才能顺利计算出中间contentLabel的高度，否则都是不确定的高度Cell也不能自动计算行高
            make.height.equalTo(40)
        }
        
        //添加contentView布局约束：Cell自动布局3
        contentView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(originalView.snp.bottom)
            //新增bottomView布局
            make.bottom.equalTo(bottomView.snp.bottom)
            //这里相对于self而非contentView
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        
    }
    
    //延时加载自定义的控件
    private lazy var originalView: StatusOriginalView = StatusOriginalView()
    //添加底部点赞等布局
    private lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
    //添加Picture布局
//    private lazy var pictureView: StatusPictureView = StatusPictureView()
    
    private lazy var retweetStatusView: RetweetStatusView = RetweetStatusView()
}
