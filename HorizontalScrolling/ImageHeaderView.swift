//
//  ImageHeaderView.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/11/29.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

class ImageHeaderView : UIView {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var backgroundImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blackColor()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImage.setRandomDownloadImage(80, height: 80)
        self.backgroundImage.setRandomDownloadImage(Int(self.frame.size.width), height: 160)
    }
}