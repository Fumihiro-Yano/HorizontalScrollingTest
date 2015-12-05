//
//  CustomUITableViewCell.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/11/29.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

class CustomUITableViewCell : UITableViewCell{

    @IBOutlet weak var cellIconImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // UILabelとかを追加
        cellLabel.text = ""
        cellLabel.font = UIFont.systemFontOfSize(12)
    }
   }