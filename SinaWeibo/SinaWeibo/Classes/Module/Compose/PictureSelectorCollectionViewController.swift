//
//  PictureSelectorCollectionViewController.swift
//  SinaWeibo
//
//  Created by mac on 2017/12/16.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private let pictureCellMargin: CGFloat = 10
private let column: CGFloat = 4

class PictureSelectorCollectionViewController: UICollectionViewController {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = pictureCellMargin
        layout.minimumLineSpacing = pictureCellMargin
        let itemWidth = (screenW - (column + 1) * pictureCellMargin) / column
        let itemHeight = itemWidth
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        //设置section间距
        layout.sectionInset = UIEdgeInsets(top: pictureCellMargin, left: pictureCellMargin, bottom: 0, right: pictureCellMargin)
        //重新初始化
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor.randomColor()
    
        return cell
    }

    // MARK: UICollectionViewDelegate


}

class pictureCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
    
    //延时加载
    private var addBtn: UIButton = UIButton(title: nil, backImage: "tabbar_compose_icon_add", color: nil)
}

