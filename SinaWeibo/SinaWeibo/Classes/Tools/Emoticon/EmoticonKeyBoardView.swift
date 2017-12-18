//
//  EmoticonKeyBoardView.swift
//  EmoticonKeyBoard
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

import UIKit

private let EmoticonCellId = "EmoticonCellId"
private let toolBarHeight: CGFloat = 36
class EmoticonKeyBoardView: UIView {
    
    //声明一个闭包属性 
    var selectEmtion: ((em: Emoticon) -> ())?
    
    //增加表情分组属性 
    private lazy var packages = EmoticonManager().packages
    
    
    //MARK: 4实现监听方法
    @objc private func itemClick(item: UIBarButtonItem) {
        print(item.tag)
        let indexPath = NSIndexPath(forItem: 0, inSection: item.tag)
        //滚动到具体的indepath位置
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
    
    
    //MARK: 3.重写父类的构造方法 调用设置UI

    
    //视图内部可以确定大小
    //使外部调用更加简单
    init(selectEmtion: (em: Emoticon) -> () ) {
        
        //将外部传递的闭包使用属性 记录 
        self.selectEmtion = selectEmtion
        let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 220)
        
        super.init(frame: rect)
        
        setupUI()
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 1. 懒加载所有子控件
    
    private lazy var  toolBar: UIToolbar = UIToolbar()
    
    private lazy var collectionView: UICollectionView = {
        
        //初始化layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //设置滚动方向
        layout.scrollDirection = .Horizontal
        //确定itemSize
        let w = UIScreen.mainScreen().bounds.width / 7
        layout.itemSize = CGSize(width: w, height: w)
        
        //设置sectionInset
        let margin = (self.bounds.height - 3 * w - toolBarHeight) / 4
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        //注册cell
        cv.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: EmoticonCellId)
        cv.dataSource = self
        //设置代理
        cv.delegate = self
        //设置分页滚动
        cv.pagingEnabled = true
        return cv
    }()

}

//专门给当前视图扩充数据源方法
extension EmoticonKeyBoardView: UICollectionViewDataSource, UICollectionViewDelegate {
    //有多少个section
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    ///每个section有多少个 cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticonList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonCellId, forIndexPath: indexPath) as! EmoticonCell
        cell.emoticon = packages[indexPath.section].emoticonList[indexPath.item]
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let em = packages[indexPath.section].emoticonList[indexPath.item]
        //执行闭包完成回调
        selectEmtion?(em: em)
    }
    
}




//MARK: 2.设置 UI
extension EmoticonKeyBoardView {

    private func setupUI() {
        //添加视图
        addSubview(toolBar)
        addSubview(collectionView)
        
        //设置约束
        toolBar.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self)
            //设置高度
            make.height.equalTo(toolBarHeight)
        }
        
        collectionView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(toolBar.snp_top)
        }
        //设置工具条
        setupToolBar()
    }
    

    //设置toolbar 
    private func setupToolBar() {
        
        //设置 toolbar 文本渲染颜色
        toolBar.tintColor = UIColor.lightGrayColor()
        
        //声明items数组
        var items = [UIBarButtonItem]()
        //定义一个变量  来标识item的tag
        var index = 0
        for package in packages {
            let item = UIBarButtonItem(title:package.group_name_cn , style: .Plain, target: self, action: "itemClick:")
            //添加元素
            items.append(item)
            items.last?.tag = index++
            //添加弹簧
            let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        
        //移除最后一个弹簧
        items.removeLast()
        
        toolBar.items = items
    }
}
