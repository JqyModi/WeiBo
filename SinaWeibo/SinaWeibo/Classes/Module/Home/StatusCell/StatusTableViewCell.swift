//
//  StatusTableViewCell.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

//定义在外部其它类也可以访问
let StatusCellMargin: CGFloat = 12
let StatusCellIconWidth: CGFloat = 35

class StatusTableViewCell: UITableViewCell {
    
    //设置模型数据
    var status: Status? {
        didSet {
            //属性传递
            originalView.status = status
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(originalView)
        //添加底部点赞视图
        contentView.addSubview(bottomView)
        
        //添加布局约束
        originalView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            //不再指定高度：Cell自动布局2
//            make.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints { (make) in
//            make.top.equalTo(originalView.snp.bottom).offset(StatusCellMargin)
            make.top.equalTo(originalView.snp.bottom)
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
}
