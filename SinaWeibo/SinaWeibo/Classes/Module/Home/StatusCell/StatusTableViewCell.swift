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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(originalView)
        
        //添加布局约束
        originalView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(50)
        }
    }
    
    //延时加载自定义的控件
    private lazy var originalView: StatusOriginalView = StatusOriginalView()

}
