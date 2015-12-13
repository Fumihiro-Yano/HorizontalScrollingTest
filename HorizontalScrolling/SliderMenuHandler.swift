//
//  SliderMenuHandler.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/12/13.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import Foundation
import UIKit

enum SliderMenuTableIndexType: Int{
    case Home = 0
    case Like = 1
    case Exhibit = 2
    case Purchase = 3
    case Setting = 4
    case Guide = 5
    case Inquiry = 6
}

class SliderMenuHandler {
    var type: SliderMenuTableIndexType
    
    init(type: SliderMenuTableIndexType) {
        self.type = type
    }
    
    func getViewController() -> UIViewController {
        switch self.type {
        case .Home:
            let homeViewController = ViewController()
            return homeViewController
        case .Like:
            let newsViewController = NewsViewController()
            return newsViewController
        case .Exhibit:
            let newsViewController = NewsViewController()
            return newsViewController
        case .Purchase:
            let newsViewController = NewsViewController()
            return newsViewController
        case .Setting:
            let newsViewController = NewsViewController()
            return newsViewController
        case .Guide:
            let newsViewController = NewsViewController()
            return newsViewController
        case .Inquiry:
            let newsViewController = NewsViewController()
            return newsViewController
        }
        
    }
 }