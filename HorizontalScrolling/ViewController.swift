//
//  ViewController.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/10/07.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UIScrollViewDelegate {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        mainScrollView = UIScrollView()
        selectionBar = UIView()
        button = UIButton()
        buttonArray = []
        pageScrollViewArray = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        mainScrollView = UIScrollView()
        selectionBar = UIView()
        button = UIButton()
        buttonArray = []
        pageScrollViewArray = []
        super.init(coder: aDecoder)
    }
    
    
    var mainScrollView: UIScrollView!
    var scrollViewHeader: UIScrollView!
    var pageControl: UIPageControl!
    var buttonViews: UIView!
    var button :UIButton!
    var pastbutton :UIButton!
    var collectionViewConfig:CollectionViewConfig?
    
    let X_BUFFER:CGFloat = 0
    let Y_BUFFER:CGFloat = 14
    let HEIGHT:CGFloat = 50
    
    
    let SELECTOR_Y_BUFFER:CGFloat = 40
    let SELECTOR_HEIGHT:CGFloat = 4
    let X_OFFSET:CGFloat = 8

    var currentPageIndex :Int = 0
    var pastPageIndex :Int = 0;
    
    var selectionBar :UIView
    var panGestureRecognizer :UIPanGestureRecognizer?
    var buttonText :[String] = []
    var viewArray: NSArray = []
    var pageScrollViewArray : [AnyObject]
    var buttonArray: [AnyObject]
    var scrollBeginingPoint: CGPoint!
    
    // 画面に映る最も左端の画像のインデックス
    var leftImageIndex:NSInteger = 0
    // 画面外に待機している両端の画像のインデックス
    var leftViewIndex :NSInteger = 0
    var rightViewIndex:NSInteger = 0
    
    
    var scrollHeadleftImageIndex:NSInteger = 0
    var scrollHeadleftViewIndex :NSInteger = 0
    var scrollHeadrightViewIndex:NSInteger = 0
    var scrollHeadBeginingPoint: CGPoint!
    
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
                demo2.backgroundColor = UIColor.blueColor()
                demo3.backgroundColor = UIColor.grayColor()
                demo4.backgroundColor = UIColor.orangeColor()
                demo5.backgroundColor = UIColor.brownColor()

        viewArray = [demo,demo2,demo3,demo4,demo5]
        mainScrollView = UIScrollView()
        mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        mainScrollView.pagingEnabled = true
        mainScrollView.delegate = self;
        mainScrollView.showsHorizontalScrollIndicator = false;
        mainScrollView.showsVerticalScrollIndicator = false;
        mainScrollView.backgroundColor = UIColor.whiteColor()
        mainScrollView.tag = 1;
        
        var innerScrollFrame:CGRect = mainScrollView.bounds;
        var innerFramePositionX = mainScrollView.frame.size.width * 10000
        scrollViewHeader = UIScrollView(frame: CGRectMake(0,(self.navigationController?.navigationBar.frame.size.height)! + 20, self.view.bounds.width, 50))
        scrollViewHeader.showsHorizontalScrollIndicator = false
        scrollViewHeader.showsVerticalScrollIndicator = false
        scrollViewHeader.pagingEnabled = true
        scrollViewHeader.delegate = self
        scrollViewHeader.tag = 2
        self.collectionViewConfig = CollectionViewConfig()
        
        for (var i = 0; i < viewArray.count; i++) {
        
            let iv:UIView = viewArray[i] as! UIView
            iv.frame = CGRectMake(mainScrollView.frame.origin.x + 10,mainScrollView.frame.origin.y + 60,mainScrollView.frame.size.width - 20,mainScrollView.frame.size.height)
                //mainScrollView.frame;
            iv.tag = i + C_IMAGEVIEW_TAG;
            
            let myCollectionView : UICollectionView!
            // CollectionViewのレイアウトを生成.
            let layout = UICollectionViewFlowLayout()
            // Cell一つ一つの大きさ.
            layout.itemSize = CGSizeMake(145, 180)
            // Cellのマージン.
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 0)
            // セクション毎のヘッダーサイズ.
            // CollectionViewを生成.
            myCollectionView = UICollectionView(frame: CGRectMake(0,0, self.view.frame.size.width - 20, self.view.frame.size.height), collectionViewLayout: layout)
            // Cellに使われるクラスを登録.
            let nib = UINib(nibName: "CustomUICollectionViewCell", bundle: nil)
            myCollectionView.registerNib(nib, forCellWithReuseIdentifier: "MyCell")
            myCollectionView.delegate = self.collectionViewConfig
            myCollectionView.dataSource = self.collectionViewConfig
            
            iv.addSubview(myCollectionView);
            
            
            let pageScrollView = UIScrollView(frame: CGRectMake(innerFramePositionX,65, self.mainScrollView.bounds.width, self.mainScrollView.bounds.height))

            pageScrollView.contentSize = iv.bounds.size;
            pageScrollView.delegate = self
            pageScrollView.showsHorizontalScrollIndicator = false;
            pageScrollView.showsVerticalScrollIndicator = false;
            pageScrollView.addSubview(iv);
            pageScrollView.tag = 10 * i
            
            self.mainScrollView.addSubview(pageScrollView);
            pageScrollViewArray.append(pageScrollView)
            
            if (i < 4) {
                innerScrollFrame.origin.x = innerScrollFrame.origin.x + innerScrollFrame.size.width;
                 NSLog("This is innerFramePositionX ^^^^^^^^^^^^  innerFramePositionX : %d",Int(innerFramePositionX))
                innerFramePositionX = innerFramePositionX + self.mainScrollView.bounds.width
            }
        }
        
        let startPoint = CGPointMake(mainScrollView.frame.size.width * 10000  + mainScrollView.frame.size.width * 2, 0);
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width * CGFloat(viewArray.count * 10000), 0);
        self.view.addSubview(mainScrollView);
        mainScrollView.contentOffset = startPoint

        
        scrollViewHeader.contentSize = CGSizeMake(mainScrollView.frame.size.width * CGFloat(viewArray.count * 10000), 0)
        self.view.addSubview(scrollViewHeader)
        scrollViewHeader.contentOffset = startPoint
        
        
        pageControl = UIPageControl();
        pageControl.numberOfPages = viewArray.count
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false
        
        // 画面の最も左に表示されている画像のインデックス
        leftImageIndex = 0
        leftViewIndex  = 0
        rightViewIndex = viewArray.count - 1
        
        //scrollHeadの最も左に表示されているインデックス
        scrollHeadleftImageIndex = leftImageIndex
        scrollHeadleftViewIndex = leftViewIndex
        scrollHeadrightViewIndex = rightViewIndex
        }
    
    func setupSegmentButtons() {
        let numViews :Int = viewArray.count
        // ScrollViewHeaderの設定.
        if (buttonText.count == 0) {
            buttonText = ["first","second","third","fourth","etc","etc","etc","etc"] //%%%buttontitle
        }
        
        for (var i = 0 ; i < numViews; i++) {
            let frame :CGRect = CGRectMake(mainScrollView.frame.size.width * 10000 + self.view.frame.size.width * CGFloat(i), 0, self.view.frame.size.width, HEIGHT)
            button = UIButton(frame: frame)
            scrollViewHeader.addSubview(button)
            button.tag = i
            button.backgroundColor = UIColor(red: 0.03, green: 0.07, blue: 0.08, alpha: 1)
            button.addTarget(self, action: "tapSegmentButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle(buttonText[i], forState:UIControlState.Normal)
            buttonArray.append(button)
        }
        self.setupSelector()
        button = buttonArray[pageControl.currentPage] as! UIButton
    }
    
    func setupSelector() {
        selectionBar = UIView(frame: CGRectMake(X_BUFFER, SELECTOR_Y_BUFFER,(self.view.frame.size.width-2*X_BUFFER)/CGFloat(viewArray.count), SELECTOR_HEIGHT))
        selectionBar.backgroundColor = UIColor.greenColor() //%%% sbcolor
        selectionBar.alpha = 0.8; //%%% sbalpha
        scrollViewHeader.addSubview(selectionBar)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupSegmentButtons()
        NSLog("This is viewWillAppear ")
    }
    
    func tapSegmentButtonAction(button:UIButton) {
//      let pagePoint = CGPointMake(mainScrollView.frame.size.width * 10000 + mainScrollView.frame.size.width * CGFloat(button.tag), 0);
        let pagePoint = scrollViewHeader.contentOffset
      mainScrollView.setContentOffset(pagePoint, animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
       if(scrollView.tag == 1) {
        scrollBeginingPoint = scrollView.contentOffset
        NSLog("This is scrollBeginingPoint %@",NSStringFromCGPoint(scrollBeginingPoint))
        }
       if(scrollView.tag == 2){
        scrollHeadBeginingPoint = scrollView.contentOffset
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
          if(scrollView.tag == 1) {
          let xFromCenter:CGFloat = self.view.frame.size.width - mainScrollView.contentOffset.x //%%% positive for right swipe, negative for left
          let xCoor:CGFloat = X_BUFFER + selectionBar.frame.size.width * CGFloat(currentPageIndex + 1);
          selectionBar.frame = CGRectMake(xCoor-xFromCenter/CGFloat(viewArray.count), selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
            
//          self.buttonWhiteColor()
//          self.getPage()
//          self.buttonGreenColor()
            var point:CGPoint = scrollView.contentOffset;
            point.y = 0;
            scrollView.contentOffset = point;
         }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,willDecelerate decelerate: Bool){
        NSLog("スクロールで指が離れたところ")
                   }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
            NSLog("This is UIScrollView")
            if (scrollView.tag == 1) {
                NSLog("This is UIScrollView tag 1")
                let currentPoint = scrollView.contentOffset;
                let scrollHeaderPoint = CGPoint(x: currentPoint.x, y: 0)
                scrollViewHeader.setContentOffset(scrollHeaderPoint, animated: true)
                NSLog("This is currentPointPoint %@",NSStringFromCGPoint(currentPoint))
                let changeingPage = abs(scrollBeginingPoint.x - currentPoint.x)
                
                NSLog("================================This is scrollBeginingPoint.x ===============================%d",Int(scrollBeginingPoint.x))
                NSLog("================================This is currentPoint.x ===============================%d",Int(currentPoint.x))
                NSLog("================================This is currentPointPoint ===============================%d",Int(changeingPage))
                NSLog("================================This is currentPointPoint ===============================%d",Int(pageControl.currentPage))
                
                
                if ((Int(changeingPage) >= Int(self.view.frame.size.width))){
                var direction  :NSInteger = 0
                var viewIndex  :NSInteger = 0
                
                if(scrollBeginingPoint?.x < currentPoint.x){
                    NSLog("右->左スクロール")
                    direction  = 1
                    viewIndex  = leftViewIndex
                    self.scrollWithDirection(direction,viewIndex: viewIndex, scrollViewTag: scrollView.tag)
                }else{
                    NSLog("左->右スクロール")
                    direction  = -1
                    viewIndex  = rightViewIndex
                    self.scrollWithDirection(direction,viewIndex: viewIndex, scrollViewTag: scrollView.tag)
                }
              }
            }
            if (scrollView.tag == 2) {
              NSLog("This is UIScrollView tag 2")
                let scrollHeadCurrentPoint = scrollView.contentOffset;
                var scrollHeaddirection  :NSInteger = 0
                var scrollHeadviewIndex  :NSInteger = 0
                
                if(scrollHeadBeginingPoint?.x <  scrollHeadCurrentPoint.x){
                    NSLog("右->左スクロール")
                    scrollHeaddirection  = 1
                    scrollHeadviewIndex  = scrollHeadleftViewIndex
                    self.scrollWithDirection(scrollHeaddirection,viewIndex: scrollHeadviewIndex, scrollViewTag: scrollView.tag)
                }else{
                    NSLog("左->右スクロール")
                    scrollHeaddirection  = -1
                    scrollHeadviewIndex  = scrollHeadrightViewIndex
                    self.scrollWithDirection(scrollHeaddirection,viewIndex: scrollHeadviewIndex, scrollViewTag: scrollView.tag)
                }
            }
    }
    
    func scrollWithDirection(direction:NSInteger,viewIndex:NSInteger,scrollViewTag: NSInteger) {
      if (scrollViewTag == 1) {
        NSLog("This is direction ^^^^^^^^^^^^  direction : %d",direction)
        NSLog("This is viewIndex ^^^^^^^^^^^^  viewIndex : %d",viewIndex)
        //pageScrollViewの位置
        let iv = self.pageScrollViewArray[viewIndex] as! UIView
        iv.frame.origin.x += mainScrollView.frame.width * CGFloat(self.viewArray.count * direction)
        //buttonの位置
        let ib = self.buttonArray[viewIndex] as! UIButton
        ib.frame.origin.x += mainScrollView.frame.width * CGFloat(self.viewArray.count * direction)
        
        NSLog("This is iv.frame.origin.x ^^^^^^^^^^^^ iv.frame.origin.x : %d",Int(iv.frame.origin.x))
        
        leftImageIndex += direction
        
        leftViewIndex  = self.addImageIndex(leftViewIndex , incremental: direction)
        rightViewIndex = self.addImageIndex(rightViewIndex, incremental: direction)
      }
      else if (scrollViewTag == 2) {
        let ib = self.buttonArray[viewIndex] as! UIButton
        ib.frame.origin.x += mainScrollView.frame.width * CGFloat(self.viewArray.count * direction)
        NSLog("This is iv.frame.origin.x ^^^^^^^^^^^^ iv.frame.origin.x : %d",Int(ib.frame.origin.x))
        scrollHeadleftImageIndex += direction
        scrollHeadleftViewIndex = self.addImageIndex(scrollHeadleftViewIndex, incremental: direction)
        scrollHeadrightViewIndex = self.addImageIndex(scrollHeadrightViewIndex, incremental: direction)
        }
    }
    
    func addImageIndex(index:NSInteger, incremental:NSInteger) -> NSInteger {
        return (index + incremental + self.viewArray.count) % self.viewArray.count
    }
    
    

    func getPage() {
        pastPageIndex = pageControl.currentPage;
        let pageNum = mainScrollView.bounds.origin.x / mainScrollView.frame.width;
        pageControl.currentPage = Int(pageNum);
    }
    
    func buttonGreenColor() {
        NSLog("buttonGreenColorbuttonGreenColorbuttonGreenColorbuttonGreenColorbuttonGreenColorbuttonGreenColor%d",pageControl.currentPage)
        button = buttonArray[pageControl.currentPage] as! UIButton
        button.setTitleColor(UIColor.greenColor(), forState: .Normal)
    }
    
    func buttonWhiteColor() {
          pastbutton = buttonArray[pastPageIndex] as! UIButton
          pastbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}