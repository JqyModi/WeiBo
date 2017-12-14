//
//  RetweetStatusView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
import SnapKit

class RetweetStatusView: UIView {
    
    //记录底部约束
    var bottomConstraint: Constraint?
    
    //数据Model
    var retweetStatus: Status? {
        didSet {
            //设置title
            titleLabel.text = retweetStatus?.text
            
            //更新约束前先去掉原来的约束
            self.bottomConstraint?.deactivate()
            
            //判断有无配图再动态显示底部视图：多个判断条件用逗号隔开
            if let picurls = retweetStatus?.imageURLs, picurls.count > 0 {
                //有配图
                pictureView.imageURLs = retweetStatus?.imageURLs
                //显示
                pictureView.isHidden = false
                //更新约束
                self.snp.makeConstraints({ (make) in
                    self.bottomConstraint = make.bottom.equalTo(pictureView.snp.bottom).offset(StatusCellMargin).constraint
                })
            }else {
                //无配图
                //显示
                pictureView.isHidden = true
                //更新约束
                self.snp.makeConstraints({ (make) in
                    self.bottomConstraint = make.bottom.equalTo(titleLabel.snp.bottom).offset(StatusCellMargin).constraint
                })
            }
            
            if let urls = retweetStatus?.imageURLs, urls.count > 0 {
                pictureView.imageURLs = urls
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //
        backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(pictureView)
        
        //约束
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.right.equalTo(self.snp.right).offset(StatusCellMargin)
//            make.height.equalTo()
        }
        
        pictureView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(StatusCellMargin)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        //自身约束
        self.snp.makeConstraints { (make) in
//            make.bottom.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            //将约束转换成约束类型：记录底部约束
            self.bottomConstraint = make.bottom.equalTo(pictureView.snp.bottom).offset(StatusCellMargin).constraint
        }
    }
    
    //延时加载
    private lazy var titleLabel: UILabel = UILabel(title: "转发微博 ~", fontSize: 14, color: .darkGray, margin: StatusCellMargin)
    private lazy var pictureView: StatusPictureView = StatusPictureView()
}
