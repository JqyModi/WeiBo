//
//  StatusOriginalView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit
//自动布局
import SnapKit

class StatusOriginalView: UIView {
    
    //记录底部约束
    var bottomConstraint: Constraint?
    
    var status: Status? {
        didSet {
            //给控件赋值显示
            //需要info添加HTTP请求支持
            iconImage.setImageWith(status?.user?.headImageURL as! URL, placeholderImage: UIImage(named: "avatar_default_big"))
            nameLabel.text = status?.user?.name
            verifiedIconView.image = status?.user?.verified_type_Image
            memberIconView.image = status?.user?.mbrankImage
//            timeLabel.text = status?.created_at
            timeLabel.text = "11:11"
//            sourceLabel.text = status?.source
            sourceLabel.text = "来自：秒拍网"
            contentLabel.text = status?.text
            
            //设置配图图片资源
//            pictureView.imageURLs = status?.imageURLs
            
            //更新约束前先去掉原来的约束
            self.bottomConstraint?.deactivate()
            
            //判断有无配图再动态显示底部视图：多个判断条件用逗号隔开
            if let picurls = status?.imageURLs, picurls.count > 0 {
                //有配图
                pictureView.imageURLs = status?.imageURLs
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
                    self.bottomConstraint = make.bottom.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin).constraint
                })
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = homeBGColor
        
        addSubview(sepView)
        
        //加载子控件
        addSubview(iconImage)
        addSubview(nameLabel)
        //
        addSubview(memberIconView)
        addSubview(verifiedIconView)
        
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        
        //添加配图布局
        addSubview(pictureView)
        
        sepView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(StatusCellMargin)
//            make.left.equalTo(snp.left)
            //连续设置多个方向约束
            make.left.right.top.equalTo(self)
            make.height.equalTo(StatusCellMargin)
        }
        
        //设置布局约束
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
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
            //??
            make.left.equalTo(iconImage)
//            make.width.equalTo(screenW - 2*StatusCellMargin)
        }
        
        
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            //
//            make.left.equalTo(contentLabel.snp.left).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            //加上文字不见了？
//            make.right.equalTo(contentLabel.snp.right)
            //设置预估值后面再更新
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        
        //Cell自动布局4
        self.snp.makeConstraints { (make) in
//            make.bottom.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            //将约束转换成约束类型：记录底部约束
            self.bottomConstraint = make.bottom.equalTo(pictureView.snp.bottom).offset(StatusCellMargin).constraint
        }
    }
    
    //定义延时加载控件
    private lazy var iconImage: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var nameLabel: UILabel = UILabel(title: "酷客_VB", fontSize: 14, color: .darkGray)
    //用户认证类型小图标
    private lazy var verifiedIconView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    //用户等级小图标
    private lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    //发布时间
    private lazy var timeLabel: UILabel = UILabel(title: "11:11", fontSize: 10, color: .orange)
    //微博来源
    private lazy var sourceLabel: UILabel = UILabel(title: "来自: 火星🔥", fontSize: 10, color: .lightGray)
    //微博正文
    private lazy var contentLabel: UILabel = UILabel(title: "  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,  酷客_攻城狮,", fontSize: 14, color: .lightGray, margin: StatusCellMargin)
    
    //添加Picture布局
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    
    //添加分割线
    private lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return v
    }()
    
}
