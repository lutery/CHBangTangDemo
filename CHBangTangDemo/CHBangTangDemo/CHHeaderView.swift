//
//  CHHeaderView.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/11.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import SDWebImage

class CHHeaderView: UIView {
    
    weak var tableView:UITableView?;
    var tableViews:[UITableView]?;
    
    private var mSearchBar:UISearchBar?;
    var searchBar:UISearchBar?{
        get{
            if mSearchBar == nil {
                mSearchBar = UISearchBar(frame: CGRect(x: -(self.bounds.width - 60), y: 30, width: self.bounds.width - 80, height: 30));
                mSearchBar?.placeholder = "搜索值得买的好物";
                mSearchBar?.layer.cornerRadius = 15;
                mSearchBar?.layer.masksToBounds = true;
                
                
//                mSearchBar?.setSearchFieldBackgroundImage(, for: )
            }
            
        }
    };
    
    private var mSearchButton:UIButton?;
    var searchButton:UIButton?{
        get{
            if mSearchButton == nil {
                mSearchButton = UIButton(frame: CGRect(x: 20, y: 30, width: 30, height: 30));
                mSearchButton?.setBackgroundImage(UIImage.init(named: "home_search_icon"), for: .normal);
            }
            
            return mSearchButton;
        }
    };
    
    private var mEmailButton:UIButton?;
    var emailButton:UIButton?{
        get{
            if mEmailButton == nil {
                mEmailButton = UIButton(frame: CGRect(x: self.bounds.width - 45, y: 30, width: 30, height: 30));
                mEmailButton?.setBackgroundImage(UIImage.init(named: "home_email_black"), for: 		.normal);
            }
            
            return self.mEmailButton;
        }
    };

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.addSubview(self.searchBar!);
        self.addSubview(self.searchButton!);
        self.addSubview(self.emailButton!);
    }
}
