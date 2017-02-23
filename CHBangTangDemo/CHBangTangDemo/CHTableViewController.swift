//
//  CHTableViewController.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/2/9.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class CHTableViewController: UIViewController {
    
    private var mTableView:UITableView? = nil;
    private var mModule:CHTableViewModule? = nil;
    
    public var TableView:UITableView{
        get{
            if mTableView == nil {
                self.mTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
                mModule = CHTableViewModule(tableView: self.mTableView!);
                self.mTableView?.delegate = mModule;
                self.mTableView?.dataSource = mModule;
                self.mTableView?.register(CHBTHomeTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(CHBTHomeTableViewCell));
                
                let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 242));
                tableHeaderView.backgroundColor = UIColor.white;
                
                self.mTableView?.scrollIndicatorInsets = UIEdgeInsetsMake(182, 0, 0, 0);
                self.mTableView?.tableHeaderView = tableHeaderView;
            }
            
            return mTableView!;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.TableView);
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
