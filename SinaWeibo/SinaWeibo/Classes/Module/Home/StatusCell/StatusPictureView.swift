//
//  StatusPictureView.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let pictureCellMargin: CGFloat = 5

//改造成UICollectionView
class StatusPictureView: UICollectionView {

    var imageURLs: [NSURL]? {
        didSet {
            debugPrint("imageURLs = \(imageURLs)")
            
            //刷新Cell
            reloadData()
            
            //更新视图大小
            let viewSize = calcViewSize()
            self.snp.updateConstraints { (make) in
                make.width.equalTo(viewSize.width)
                make.height.equalTo(viewSize.height)
            }
        }
    }
    
    private func calcViewSize() -> CGSize {
        //获取视图最大宽度
        let maxWidth = screenW - 2 * StatusCellMargin
        //定义显示列数
        let colum: CGFloat = 3
        let itemWidth = (maxWidth - (colum - 1) * StatusCellMargin) / colum
        
        let layout = self.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        let imageCount: CGFloat = CGFloat(imageURLs?.count ?? 0)
        //无图
        if imageCount == 0 {
            return CGSize.zero
        }
        
        //单图
        if imageCount == 1 {
            let imageViewSize = CGSize(width: 180, height: 120)
            //当没有图片时返回CGSize.zero
            layout?.itemSize = imageViewSize
            return imageViewSize
        }
        //4图
        if imageCount == 4 {
            let w = itemWidth * 2 + StatusCellMargin
            return CGSize(width: w, height: w)
        }
        //多图
        //取余操作：truncatingRemainder
//        let row = CGFloat(Int((imageCount-1).truncatingRemainder(dividingBy: colum)) + 1)
        let row = CGFloat(Int((imageCount-1) / colum) + 1)
        debugPrint("row = \(row)")
        let h = row * itemWidth + (row - 1) * StatusCellMargin
        return CGSize(width: maxWidth, height: h)
        
    }
    
    init() {
        //设置布局样式
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = pictureCellMargin
        layout.minimumInteritemSpacing = pictureCellMargin
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        //注册Cell
        register(PictureViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //设置代理
        dataSource = self
        setupUI()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupUI()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.randomColor()
//        backgroundColor = homeBGColor
    }
    
    //
}

extension StatusPictureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageURLs?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PictureViewCell
        cell.url = imageURLs?[indexPath.item]
        return cell
    }
}

class PictureViewCell: UICollectionViewCell {
    //Model
    var url: NSURL? {
        didSet {
            //设置图片内容
            imageView.setImageWith(url as! URL, placeholderImage: nil)
        }
    }
    
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        
        //margin
        let margin: CGFloat = 2
        imageView.snp.makeConstraints { (make) in
//            make.edges.equalTo(contentView.snp.edges).offset(margin)
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    
    //
    private lazy var imageView: UIImageView = UIImageView()
}









