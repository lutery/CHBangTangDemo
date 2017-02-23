//
//  CHHomeViewController.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/11.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import SDCycleScrollView


/// 主界面Controller
class CHHomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    /// 项目字符串
    let CATEGORY = ["推荐", "原创", "热门", "美食", "生活", "设计感", "家居", "礼物", "阅读", "运动健身", "旅行户外"];
    // 导航栏高度
    let NAVBARHEIGHT = 64.0;
    // 最大字体
    let FONTMAX = 15.0;
    // 最小字体
    let FONTMIN = 14.0;
    // 字体填充
    let PADDING = 15.0;
    
    // 当前的展示的TableView
    private var mCurrentTableView:UITableView? = nil;
    
    /// 顶部搜索框
    private var mCHHeaderView:CHHeaderView? = nil;
    var HeaderView:CHHeaderView{
        get{
            if self.mCHHeaderView == nil {
                self.mCHHeaderView = CHHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64));
                self.mCHHeaderView?.backgroundColor = UIColor.clear;
            }
            
            return self.mCHHeaderView!;
        }
    }
    
    /// 循环播放控件
    private var mCycleScrollView:SDCycleScrollView? = nil;
    var CycleScrollView:SDCycleScrollView{
        get{
            if self.mCycleScrollView == nil {
                var imageArray = Array<String>();
                
                for index in 1..<9 {
                    let imageName = String.init(format: "cycle_%02d.jpg", index);
                    imageArray.append(imageName);
                }
                
                self.mCycleScrollView = SDCycleScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), imageNamesGroup: imageArray);
            }
            
            return self.mCycleScrollView!;
        }
    }
    
    //标题段段则滚动控件
    private var mSegmentScrollView:UIScrollView? = nil;
    public var SegmentScrollView:UIScrollView{
        get{
            if self.mSegmentScrollView == nil {
                self.mSegmentScrollView = UIScrollView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 40));
                self.mSegmentScrollView?.addSubview(self.CurrentSelectedItemImageView);
                self.mSegmentScrollView?.showsHorizontalScrollIndicator = false;
                self.mSegmentScrollView?.showsVerticalScrollIndicator = false;
                self.mSegmentScrollView?.backgroundColor = UIColor.white;
                
                var btnOffset:Int = 0;
                
                for i in 0..<CATEGORY.count {
                    let btn = UIButton.init(type: .custom);
                    btn.setTitle(CATEGORY[i], for: .normal);
                    btn.setTitleColor(UIColor.darkGray, for: .normal);
                    btn.setTitleColor(UIColor.red, for: .selected);
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(FONTMIN));
                    let size = UIButton.sizeOfLabelWith(MaxWidth: SCREEN_WIDTH, SystemFontSize: CGFloat(FONTMIN), Text: CATEGORY[i]);
                    
                    let originX = i != 0 ? (Int(PADDING) * 2 + btnOffset) : Int(PADDING);
                    
                    btn.frame = CGRect(x: originX, y: 14, width: Int(size.width), height: Int(size.height));
                    btnOffset = Int(btn.frame.maxX);
                    
                    btn.titleLabel?.textAlignment = NSTextAlignment.left;
                    btn.addTarget(self, action: #selector(self.changeSelectedItem(Current:)), for: .touchUpInside);
                    
                    self.mSegmentScrollView?.addSubview(btn);
                    
                    self.mTitleButtons?.append(btn);
                    
                    if i == 0 {
                        btn.isSelected = true;
                        self.mCurrentSelectedItemImageView?.frame = CGRect(x: Int(PADDING), y: Int((self.mSegmentScrollView?.frame.size.height)! - 2), width: Int(btn.frame.size.width), height: 2);
                    }
                }
            }
            
            return self.mSegmentScrollView!;
        }
    }
    
    /// 当前选择的端红色下标
    private var mCurrentSelectedItemImageView:UIImageView? = nil;
    public var CurrentSelectedItemImageView:UIImageView{
        get{
            if self.mCurrentSelectedItemImageView == nil {
                self.mCurrentSelectedItemImageView = UIImageView();
                self.mCurrentSelectedItemImageView?.image = UIImage(named: "nar_bgbg.png");
            }
            
            return self.mCurrentSelectedItemImageView!;
        }
    }
    
    /// 底部表格滚动控件
    private var mBottomScrollView:UIScrollView? = nil;
    public var BottomScrollView:UIScrollView{
        get{
            if self.mBottomScrollView == nil {
                self.mBottomScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
                self.mBottomScrollView?.delegate = self;
                self.mBottomScrollView?.isPagingEnabled = true;
                
                let colors = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green, UIColor.purple, UIColor.orange, UIColor.white, UIColor.red, UIColor.blue, UIColor.gray, UIColor.green];
                
                for i in 0..<CATEGORY.count {
                    var jsdTableViewController = CHTableViewController();
                    jsdTableViewController.view.frame = CGRect(x: Int(SCREEN_WIDTH * CGFloat(i)), y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT));
                    
                    jsdTableViewController.view.backgroundColor = colors[i];
                    self.BottomScrollView.addSubview(jsdTableViewController.view);
                    self.mControllers?.append(jsdTableViewController);
                    self.mTableViews?.append(jsdTableViewController.TableView);
                    
                    let refreshHeader = CHRefreshHeader(frame: CGRect(x: 0, y: 212, width: SCREEN_WIDTH, height: 30));
                    refreshHeader.backgroundColor = UIColor.white;
                    refreshHeader.tableView = jsdTableViewController.TableView;
                    jsdTableViewController.TableView.tableHeaderView?.addSubview(refreshHeader);
                    
                    let options:NSKeyValueObservingOptions = NSKeyValueObservingOptions.init(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue);
                    jsdTableViewController.TableView.addObserver(self, forKeyPath: "contentOffset", options: options, context: nil);
                }
                
                self.mCurrentTableView = self.mTableViews?[0];
                self.BottomScrollView.contentSize = CGSize(width: (self.mControllers?.count)! * Int(SCREEN_WIDTH), height: 0);
            }
            
            return self.mBottomScrollView!;
        }
    }
    
    //存放button
    private var mTitleButtons:[UIButton]? = nil;
    
    //存放控制器
    private var mControllers:[UIViewController]? = nil;
    
    //存放TableView
    private var mTableViews:[UITableView]? = nil;
    
    //纪录上一个偏移量
    private var mLastOffsetY:Float = Float(0);
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.mTitleButtons = Array<UIButton>();
        self.mControllers = Array<UIViewController>();
        self.mTableViews = Array<UITableView>();
        
        self.view.addSubview(self.BottomScrollView);
        self.HeaderView.tableViews = self.mTableViews;
        
        self.view.addSubview(self.CycleScrollView);
        self.view.addSubview(self.SegmentScrollView);
        self.view.addSubview(self.HeaderView);
        
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func changeSelectedItem(Current button:UIButton){
        
        for btn in self.mTitleButtons! {
            btn.isSelected = false;
        }
        
        button.isSelected = true;
        
        let index:Int = (self.mTitleButtons?.index(of: button))!;
        
        self.mCurrentTableView = self.mTableViews?[index];
        for tableView in self.mTableViews! {
            if self.mLastOffsetY >= 0 && self.mLastOffsetY <= 136 {
                tableView.contentOffset = CGPoint(x: 0, y: Int(self.mLastOffsetY));
            }
            else if self.mLastOffsetY < 0 {
                tableView.contentOffset = CGPoint(x: 0, y: 0);
            }
            else if self.mLastOffsetY > 136 {
                tableView.contentOffset = CGPoint(x: 0, y: 136);
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            ()->Void in
            if index == 0 {
                self.mCurrentSelectedItemImageView?.frame = CGRect(x: Int(self.PADDING), y: Int((self.mSegmentScrollView?.frame.size.height)! - 2), width: Int(button.frame.size.width), height: 2);
            }
            else{
                let preButton = self.mTitleButtons?[index - 1];
                let offsetX = (preButton?.frame.minX)! - CGFloat(self.PADDING * 2);
                
                self.mSegmentScrollView?.scrollRectToVisible(CGRect.init(x: Int(offsetX), y: 0, width: Int((self.mSegmentScrollView?.frame.size.width)!), height: Int((self.mSegmentScrollView?.frame.height)!)), animated: true);
                
                self.mCurrentSelectedItemImageView?.frame = CGRect(x: Int(button.frame.minX), y: Int((self.mSegmentScrollView?.frame.size.height)! - 2), width: Int(button.frame.size.width), height: 2);
            }
            
            self.mBottomScrollView?.contentOffset = CGPoint(x: Int(SCREEN_WIDTH) * index, y: 0);
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let tableView = object as? UITableView;
        
        if !(self.mCurrentTableView == tableView){
            return;
        }
        
        if !(keyPath == "contentOffset"){
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context);
            return;
        }
        
        let tableViewOffsetY = Int((tableView?.contentOffset.y)!);
        
        self.mLastOffsetY = Float(tableViewOffsetY);
        
        if tableViewOffsetY >= 0 && tableViewOffsetY <= 136 {
            self.SegmentScrollView.frame = CGRect(x: 0, y: 200 - tableViewOffsetY, width: Int(SCREEN_WIDTH), height: 40);
            self.CycleScrollView.frame = CGRect(x: 0, y: 0 - tableViewOffsetY, width: Int(SCREEN_WIDTH), height: 200);
        }
        else if tableViewOffsetY < 0 {
            self.SegmentScrollView.frame = CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 40);
            self.CycleScrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200);
        }
        else if tableViewOffsetY > 136 {
            self.SegmentScrollView.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40);
            self.CycleScrollView.frame = CGRect(x: 0, y: -136, width: SCREEN_WIDTH, height: 200);
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != self.BottomScrollView {
            return;
        }
        
        var index:Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        
        let currentButton = self.mTitleButtons?[index];
        for button in self.mTitleButtons! {
            button.isSelected = false;
        }
        
        currentButton?.isSelected = true;
        
        self.mCurrentTableView = self.mTableViews?[index];
        for tableView in self.mTableViews!{
            if self.mLastOffsetY >= 0 && self.mLastOffsetY <= 136 {
                tableView.contentOffset = CGPoint(x: 0, y: Int(self.mLastOffsetY));
            }
            else if self.mLastOffsetY < 0 {
                tableView.contentOffset = CGPoint(x: 0, y: 0);
            }
            else if self.mLastOffsetY > 136 {
                tableView.contentOffset = CGPoint(x: 0, y: 136);
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            if index == 0 {
                self.CurrentSelectedItemImageView.frame = CGRect(x: Int(self.PADDING), y: Int(self.SegmentScrollView.frame.size.height) - 2, width: Int((currentButton?.frame.size.width)!), height: 2);
            }
            else{
                let preButton = self.mTitleButtons?[index - 1];
                
                let offsetX = Int((preButton?.frame.minX)!) - Int(self.PADDING * 2);
                
                self.SegmentScrollView.scrollRectToVisible(CGRect.init(x: offsetX, y: 0, width: Int(self.SegmentScrollView.frame.size.width), height: Int(self.SegmentScrollView.frame.size.height)), animated: true);
                
                self.CurrentSelectedItemImageView.frame = CGRect(x: (currentButton?.frame.minX)!, y: self.SegmentScrollView.frame.size.height - 2, width: (currentButton?.frame.size.width)!, height: 2);
            }
        })
    }
}
