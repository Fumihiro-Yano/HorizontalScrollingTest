//
//  ViewController.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/10/07.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        let pageController:UIPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
////        
////        let navigationController:SwipeBetweenViewControllers = SwipeBetweenViewControllers(rootViewController: pageController)
////        
////        // Override point for customization after application launch.
////        let demo:UIViewController = UIViewController()
////        let demo2:UIViewController = UIViewController()
////        let demo3:UIViewController = UIViewController()
////        let demo4:UIViewController = UIViewController()
////        let demo5:UIViewController = UIViewController()
////        demo.view.backgroundColor = UIColor.redColor()
////        demo2.view.backgroundColor = UIColor.whiteColor()
////        demo3.view.backgroundColor = UIColor.grayColor()
////        demo4.view.backgroundColor = UIColor.orangeColor()
////        demo5.view.backgroundColor = UIColor.brownColor()
////        
////        navigationController.viewControllerArray = [demo,demo2,demo3,demo4,demo5]
//        
//        
//        
//        
//        
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//}
//

import UIKit


class ViewController: UIViewController , UIScrollViewDelegate {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        mainScrollView = UIScrollView()
        selectionBar = UIView()
        button = UIButton()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        mainScrollView = UIScrollView()
        selectionBar = UIView()
        button = UIButton()
        super.init(coder: aDecoder)
    }
    
    
    var mainScrollView: UIScrollView!
    var pageControl: UIPageControl!
    var buttonViews: UIView!
    var button :UIButton!
    
    
    //%%% customizeable button attributes
    let X_BUFFER:CGFloat = 0  //%%% the number of pixels on either side of the segment
    let Y_BUFFER:CGFloat = 14 //%%% number of pixels on top of the segment
    let HEIGHT:CGFloat = 50   //%%% height of the segment
    
    //%%% customizeable selector bar attributes (the black bar under the buttons)
    let ANIMATION_SPEED = 0.2 //%%% the number of seconds it takes to complete the animation
    let SELECTOR_Y_BUFFER:CGFloat = 40 //%%% the y-value of the bar that shows what page you are on (0 is the top)
    let SELECTOR_HEIGHT:CGFloat = 4 //%%% thickness of the selector bar
    
    let X_OFFSET:CGFloat = 8 //%%% for some reason there's a little bit of a glitchy offset.  I'm going to look for a better workaround in the future

    var currentPageIndex :Int = 0
    
    var selectionBar :UIView
    var panGestureRecognizer :UIPanGestureRecognizer?
    var buttonText :[String] = []
    var viewArray: NSArray = []
    
    
    
//    var pageImagesArr = ["tutorial_page_1.png","tutorial_page_2.png","tutorial_page_3.png"];
    
    
    let C_IMAGEVIEW_TAG = 1000;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home";
                let demo:UIView = UIView()
                let demo2:UIView = UIView()
                let demo3:UIView = UIView()
                let demo4:UIView = UIView()
                let demo5:UIView = UIView()
                demo.backgroundColor = UIColor.redColor()
                demo2.backgroundColor = UIColor.whiteColor()
                demo3.backgroundColor = UIColor.grayColor()
                demo4.backgroundColor = UIColor.orangeColor()
                demo5.backgroundColor = UIColor.brownColor()

        viewArray = [demo,demo2,demo3,demo4,demo5]
        mainScrollView = UIScrollView(frame: self.view.bounds)
        mainScrollView.pagingEnabled = true;
        mainScrollView.delegate = self;
        mainScrollView.showsHorizontalScrollIndicator = false;
        mainScrollView.showsVerticalScrollIndicator = false;
        
        var innerScrollFrame:CGRect = mainScrollView.bounds;
        
        for (var i = 0; i < viewArray.count; i++) {
        
            let iv:UIView = viewArray[i] as! UIView
            iv.frame = mainScrollView.frame;
            iv.tag = i + C_IMAGEVIEW_TAG;
            
            let pageScrollView = UIScrollView(frame: innerScrollFrame)

            pageScrollView.contentSize = iv.bounds.size;
            pageScrollView.delegate = self
            pageScrollView.showsHorizontalScrollIndicator = false;
            pageScrollView.showsVerticalScrollIndicator = false;
            pageScrollView.addSubview(iv);
            
            mainScrollView.addSubview(pageScrollView);
            
            if (i < 4) {
                innerScrollFrame.origin.x = innerScrollFrame.origin.x + innerScrollFrame.size.width;
            }
        }
        
        mainScrollView.contentSize = CGSizeMake(innerScrollFrame.origin.x + innerScrollFrame.size.width, 0);
        self.view.addSubview(mainScrollView);
        
        pageControl = UIPageControl();
        pageControl.numberOfPages = viewArray.count
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNum = mainScrollView.bounds.origin.x / mainScrollView.frame.width;
        pageControl.currentPage = Int(pageNum);
    }
    
    func setupSegmentButtons() {
        let numViews :Int = viewArray.count
        buttonViews = UIView(frame: CGRectMake(0,(self.navigationController?.navigationBar.frame.size.height)! + 20, mainScrollView.frame.width, 50))
        buttonViews.backgroundColor = UIColor.blueColor()
        self.view.addSubview(buttonViews)
        
        if (buttonText.count == 0) {
            buttonText = ["Home","second","third","fourth","etc","etc","etc","etc"] //%%%buttontitle
        }
        
        for (var i = 0 ; i < numViews; i++) {
            let frame :CGRect = CGRectMake(X_BUFFER+CGFloat(i)*(self.view.frame.size.width-2*X_BUFFER)/CGFloat(numViews), 0, (self.view.frame.size.width-2*X_BUFFER)/CGFloat(numViews), HEIGHT)
            button = UIButton(frame: frame)
            buttonViews.addSubview(button)
            
            button.tag = i //%%% IMPORTANT: if you make your own custom buttons, you have to tag them appropriately
            button.backgroundColor = UIColor(red: 0.03, green: 0.07, blue: 0.08, alpha: 1) //%%% buttoncolors
            button.addTarget(self, action: "tapSegmentButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle(buttonText[i], forState:UIControlState.Normal) //%%%buttontitle
        }
        self.setupSelector()
    }
    
//    %%% sets up the selection bar under the buttons on the navigation bar
    func setupSelector() {
        selectionBar = UIView(frame: CGRectMake(X_BUFFER, SELECTOR_Y_BUFFER,(self.view.frame.size.width-2*X_BUFFER)/CGFloat(viewArray.count), SELECTOR_HEIGHT))
        selectionBar.backgroundColor = UIColor.greenColor() //%%% sbcolor
        selectionBar.alpha = 0.8; //%%% sbalpha
        buttonViews.addSubview(selectionBar)
    }

    
    override func viewWillAppear(animated: Bool) {
        self.setupSegmentButtons()
    }

    
    func tapSegmentButtonAction(button:UIButton) {
      //mainScrollView.contentOffset = CGPointMake(mainScrollView.frame.size.width * CGFloat(button.tag), 0)
      let pagePoint = CGPointMake(mainScrollView.frame.size.width * CGFloat(button.tag), 0);
      mainScrollView.setContentOffset(pagePoint, animated: true);
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        NSLog("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        let xFromCenter:CGFloat = self.view.frame.size.width - mainScrollView.contentOffset.x //%%% positive for right swipe, negative for left
        
        let xCoor:CGFloat = X_BUFFER + selectionBar.frame.size.width * CGFloat(currentPageIndex + 1);
        
        selectionBar.frame = CGRectMake(xCoor-xFromCenter/CGFloat(viewArray.count), selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
    }
    
    func scrollViewWillBeginDecelerating(scrollView : UIScrollView) {
        self.buttonChangeColor()
    }
    
    func buttonChangeColor() {
        button.tag = 0;
        NSLog("=======================================================================%d",button.tag)
        button.setTitleColor(UIColor.greenColor(), forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}