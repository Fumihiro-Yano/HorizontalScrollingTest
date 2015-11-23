//
//  UsagiConfig.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/11/23.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

class CollectionViewConfig: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
/*
Cellが選択された際に呼び出される
*/
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    print("Num: \(indexPath.row)")
    
}

/*
Cellの総数を返す
*/
func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
}

func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
    return 1
}

/*
Cellに値を設定する
*/
func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! CustomUICollectionViewCell
    //        cell.textLabel?.text = indexPath.row.description
    cell.priceLabel?.text = "¥1000"
    let cellmainImage = UIImage(named: "Vegetables.jpg")
    let goodImage = UIImage(named: "good.png")
    let commentImage = UIImage(named: "comment.png")
    cell.cellmainImageView.image = cellmainImage
    cell.goodImageView.image = goodImage
    cell.commentImageView.image = commentImage
    cell.backgroundColor = UIColor.whiteColor()
    return cell
  }
}
