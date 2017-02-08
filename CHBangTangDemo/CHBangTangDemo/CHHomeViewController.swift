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
                self.mCycleScrollView
            }
        }
    }
    
    //滑动相关事件
    private var mSegmentScrollView:UIScrollView? = nil;
    private var mCurrentSelectedItemImageView:UIImageView? = nil;
    private var mBottomScrollView:UIScrollView? = nil;
    
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

}
