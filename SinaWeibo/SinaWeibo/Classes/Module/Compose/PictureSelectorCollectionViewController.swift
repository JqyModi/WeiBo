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
//
private let macCount = 3

class PictureSelectorCollectionViewController: UICollectionViewController {

    //Model：记录图片数组
//    private lazy var imageList = [UIImage]()
    //替换为外部提供的Model
    lazy var imageList = [UIImage]()
    
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
        
        //设置背景
        collectionView?.backgroundView = UIView()
        collectionView?.backgroundView?.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(pictureCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageList.count + 1
        //设置最大配图个数：是否多一个添加图片标记
        let delta = (imageList.count == macCount) ? 0 : 1
        return imageList.count + delta
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! pictureCell
        // Configure the cell
        cell.backgroundColor = UIColor.randomColor()
        cell.delegate = self
        
        if imageList.count == indexPath.item {
            //没有添加任何图片时indexPath.item = 1
            cell.image = nil
        }else {
            cell.image = imageList[indexPath.item]
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension PictureSelectorCollectionViewController: PictureCellDelegate {
    func userWillAddPicture(cell: pictureCell) {
        debugPrint(#function)
        
        //判断是否已经添加图片
        if cell.image != nil {
            debugPrint("图片已添加")
            return
        }
        
        //跳转到系统图片选择控制器
        let imageVC = UIImagePickerController()
        //设置代理获取图片
        imageVC.delegate = self
        //设置视图可编辑：上传头像时需要编辑
        imageVC.allowsEditing = true
        //跳转
        present(imageVC, animated: true, completion: nil)
    }
    
    func userWillDeletePicture(cell: pictureCell) {
        debugPrint(#function)
        //需要获取哪一行(cell)点击了按钮：作为参数传递
        if let item = cell.image {
            //获取到index
            let index = collectionView?.indexPath(for: cell)?.item
            imageList.remove(at: index!)
            //刷新Cell
            UIView.animate(withDuration: 0.2, animations: {
                cell.alpha = 0
            }, completion: { (_) in
                cell.alpha = 1
                self.collectionView?.reloadData()
            })
        }
        
    }
}

// MARK: 获取图片选择器代理
extension PictureSelectorCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //获取图片回调
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        debugPrint("info = \(info)")
        let type = info["UIImagePickerControllerMediaType"] as! String
        if type == "public.image" {
            //获取选中图片
            let orgKey = "UIImagePickerControllerOriginalImage"
            let editKey = "UIImagePickerControllerEditedImage"
            let image = (info[editKey] != nil) ? info[editKey] : info[orgKey]
            if let pic = image as? UIImage {
                //压缩图片
                debugPrint("pic = \(pic)")
                let compressImage = pic.imageCompress(targetWidth: 100)
                imageList.append(compressImage!)
                dismiss(animated: true, completion: nil)
                //刷新表格数据
                collectionView?.reloadData()
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//添加代理
protocol PictureCellDelegate: NSObjectProtocol {
    //见名知意
    func userWillAddPicture(cell: pictureCell)
    func userWillDeletePicture(cell: pictureCell)
}

class pictureCell: UICollectionViewCell {
    
    weak var delegate: PictureCellDelegate?
    
    @objc private func addBtnDidClick() {
        delegate?.userWillAddPicture(cell: self)
    }
    
    @objc private func deleteBtnDidClick() {
        delegate?.userWillDeletePicture(cell: self)
    }
    
    var image: UIImage? {
        didSet {
            //隐藏删除按钮：image == nil
            deleteBtn.isHidden = (image == nil)
            if image != nil {
                addBtn.setBackgroundImage(image, for: .normal)
            }else {
                addBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), for: .normal)
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
        contentView.addSubview(addBtn)
        contentView.addSubview(deleteBtn)
        
        //添加约束
        addBtn.snp.makeConstraints { (make) in
            //pictureCellMargin ?
            make.edges.equalTo(contentView)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(contentView)
        }
        
        //添加点击事件
        addBtn.addTarget(self, action: "addBtnDidClick", for: .touchUpInside)
        deleteBtn.addTarget(self, action: "deleteBtnDidClick", for: .touchUpInside)
    }
    
    //延时加载：图片没有
    private var addBtn: UIButton = UIButton(title: nil, backImage: "compose_pic_add", color: nil)
    private var deleteBtn: UIButton = UIButton(title: nil, backImage: "compose_photo_close", color: nil)
}

