//
//  leftViewController.swift
//  HorizontalScrolling
//
//  Created by 矢野史洋 on 2015/11/23.
//  Copyright © 2015年 矢野史洋. All rights reserved.
//

import UIKit

class leftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let myItems: NSArray = ["ホーム", "いいね！一覧", "出品した商品", "購入した商品", "設定", "ガイド", "お問い合わせ"]
    var myTableView: UITableView!
    //SlideMenuではみ出している部分をなくす。
    var imageHeaderView: ImageHeaderView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyanColor()
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat =  self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: 160, width: displayWidth, height: displayHeight))
        
        // Cell名の登録をおこなう.
        //        registerClassだとカスタムセルが見つからない。
        //        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        let nib = UINib(nibName: "CustomUITableViewCell", bundle: nil)
        myTableView.registerNib(nib, forCellReuseIdentifier: "CustomUITableViewCell")
        // DataSourceの設定をする.
        myTableView.dataSource = self
        // Delegateを設定する.
        myTableView.delegate = self
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")
    }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        return 80
    }
    
    
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        //let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        let cell: CustomUITableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomUITableViewCell", forIndexPath: indexPath) as! CustomUITableViewCell
        
        cell.cellLabel.text = "\(myItems[indexPath.row])"

        // Cellに値を設定する.
//        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }
    
}