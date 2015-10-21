//
//  CustomUICollectionViewCell.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/10/18.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

class CustomUICollectionViewCell : UICollectionViewCell{
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cellmainImageView: UIImageView!
    @IBOutlet weak var goodImageView: UIImageView!
    
    @IBOutlet weak var commentImageView: UIImageView!
    
    var textLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        // UILabelを生成.
//        textLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
//        textLabel?.text = "nil"
//        textLabel?.textAlignment = NSTextAlignment.Center
//        
//        // Cellに追加.
//        self.contentView.addSubview(textLabel!)
    }
    
}