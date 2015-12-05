//
//  UIImage.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/11/29.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

extension UIImage {
    func trim(trimRect trimRect :CGRect) -> UIImage {
        if CGRectContainsRect(CGRect(origin: CGPointZero, size: self.size), trimRect) {
            if let imageRef = CGImageCreateWithImageInRect(self.CGImage, trimRect) {
                return UIImage(CGImage: imageRef)
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(trimRect.size, true, self.scale)
        self.drawInRect(CGRect(x: -trimRect.minX, y: -trimRect.minY, width: self.size.width, height: self.size.height))
        let trimmedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = trimmedImage else { return self }
        
        return image
    }
}