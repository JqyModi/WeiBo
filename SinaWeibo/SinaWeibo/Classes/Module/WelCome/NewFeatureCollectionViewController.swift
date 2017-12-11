//
//  NewFeatureCollectionViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private let imageCount = 4

class NewFeatureCollectionViewController: UICollectionViewController {

    //重写初始化方法
    init() {
        //自定义布局样式
        let layout = UICollectionViewFlowLayout()
        //指定layout ItemSize的大小: cell在初始化时就使用这个size
        //全屏大小
        layout.itemSize = UIScreen.main.bounds.size
        //水平竖直间距
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //水平滚动
        layout.scrollDirection = .horizontal
        //调用系统初始化方法初始化
        super.init(collectionViewLayout: layout)
        
        //设置分页滚动
        //设置可以分页滑动交互
        collectionView?.isPagingEnabled = true
        //隐藏滚动条
        collectionView?.showsHorizontalScrollIndicator = false
        //一个布尔值控制滚动视图是否能越过边缘的内容和回来
        collectionView?.bounces = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(NewFeatureCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewFeatureCell
    
        // Configure the cell
        
        //item表示第几个：indexPath.row表示列
        cell.index = indexPath.item
    
        return cell
    }
    
    
    /// 当ScrollView滚动减速结束时调用
    ///
    /// - Parameter scrollView: CollectionView主内容视图
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / screenW)
        
        if page == imageCount - 1 {
            //获取Cell并开始动画效果
            if let cell = collectionView?.visibleCells.last as? NewFeatureCell {
                cell.startAnimation()
            }
        }
    }
}

class NewFeatureCell: UICollectionViewCell {
    
    var index: Int = 0 {
        didSet {
            iconImage.image = UIImage(named: "new_feature_\(index + 1)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        //显示
        startButton.isHidden = false
        //设置动画效果
        //变换坐标矩阵：放大并带弹簧效果
        startButton.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            self.startButton.transform = CGAffineTransform.identity
        }) { (_) in
            debugPrint("OK ~")
        }
    }
    
    func setupUI() {
        contentView.addSubview(iconImage)
        contentView.addSubview(startButton)
        
        //设置布局约束: 边界约束edges
        iconImage.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.snp.centerX)
            make.edges.equalTo(self.snp.edges)
        }
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-200)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    //延时加载子控件
    private lazy var iconImage: UIImageView = UIImageView()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), for: .highlighted)
        btn.setTitle("开始体验", for: .normal)
        btn.sizeToFit()
        //开始隐藏
        btn.isHidden = true
        return btn
    }()
}
