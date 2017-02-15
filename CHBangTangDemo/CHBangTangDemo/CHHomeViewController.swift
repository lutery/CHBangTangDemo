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
    
    // 当前的
    private var mCurrentTableView:UITableView? = nil;
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
    private var mCycleScrollView:SDCycleScrollView? = nil;
    var CycleScrollView:SDCycleScrollView{
        get{
            if self.mCycleScrollView == nil {
                var imageArray = Array<String>();
                
                for index in 0..<9 {
                    let imageName = String.init(format: "cycle_%02d.jpg", index);
                    imageArray.append(imageName);
                }
                
                self.mCycleScrollView = SDCycleScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), imageNamesGroup: imageArray);
            }
            
            return self.mCycleScrollView!;
        }
    }
    
    //滑动相关事件
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
    private var mCurrentSelectedItemImageView:UIImageView? = nil;
    public var CurrentSelectedItemImageView:UIImageView{
        get{
            if self.mCurrentSelectedItemImageView == nil {
                self.mCurrentSelectedItemImageView = UIImageView();
                self.mCurrentSelectedItemImageView?.image = UIImage(named: "nar_bgbg");
            }
            
            return self.mCurrentSelectedItemImageView!;
        }
    }
    private var mBottomScrollView:UIScrollView? = nil;
    public var BottomScrollView:UIScrollView{
        get{
            if self.mBottomScrollView == nil {
                self.mBottomScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
                self.mBottomScrollView?.delegate = self;
                self.mBottomScrollView?.isPagingEnabled = true;
                
                let colors = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green, UIColor.purple, UIColor.orange, UIColor.white, UIColor.red, UIColor.blue, UIColor.gray, UIColor.green];
                
                for i in 0..<CATEGORY.count {
                    var jsdTableViewController = 
                }
            }
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
        
//        self.view.addSubview(self.mBottomScrollView);
//        self.mCHHeaderView?.tableViews = Array<UITableView>.init(arrayLiteral: self.mTableViews);
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
}
