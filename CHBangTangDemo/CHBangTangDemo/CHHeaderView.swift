//
//  CHHeaderView.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/11.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit
import SDWebImage


/// 头部搜索header
class CHHeaderView: UIView {
    
//    weak var tableView:UITableView?;
    var tableViews:[UITableView]?;
    
    private var mSearchBar:UISearchBar?;
    var searchBar:UISearchBar?{
        get{
            if mSearchBar == nil {
                mSearchBar = UISearchBar(frame: CGRect(x: -(self.bounds.width - 60), y: 30, width: self.bounds.width - 80, height: 30));
                mSearchBar?.placeholder = "搜索值得买的好物";
                mSearchBar?.layer.cornerRadius = 15;
                mSearchBar?.layer.masksToBounds = true;
                
                mSearchBar?.setSearchFieldBackgroundImage(UIImage.imageWithColor(color: UIColor.clear, size: (mSearchBar?.size)!), for: .normal);
                mSearchBar?.backgroundImage = UIImage.imageWithColor(color: UIColor.gray.withAlphaComponent(0.4), size: (mSearchBar?.size)!);
                
                let searchField:UITextField = mSearchBar?.value(forKey: "searchField") as! UITextField;
                searchField.textColor = UIColor.white;
                searchField.setValue(UIColor.white, forKeyPath: "placeholderLabel.textColor");
            }
            
            
            return mSearchBar;
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

    public override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.addSubview(self.searchBar!);
        self.addSubview(self.searchButton!);
        self.addSubview(self.emailButton!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview);
        
        for tbView in self.tableViews! {
            let options = NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue);
            tbView.addObserver(self, forKeyPath: "contentOffset", options: options, context: nil);
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if !(keyPath == "contentOffset") {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context);
            return;
        }
        
        let tableView = object as! UITableView;
        let offsetY = tableView.contentOffset.y;
        
        let color = UIColor.white;
        let alpha = Float.minimum(Float(1), Float(offsetY / 136));
        
        self.backgroundColor = color.withAlphaComponent(CGFloat(alpha));
        
        if offsetY < 125 {
            UIView.animate(withDuration: 0.25, animations: {
                () in
                self.searchBar?.isHidden = false;
                self.emailButton?.setBackgroundImage(#imageLiteral(resourceName: "home_email_black.png"), for: .normal);
                self.searchBar?.frame = CGRect(x: -(self.width - 60), y: 30, width: self.width - 80, height: 30);
                self.emailButton?.alpha = CGFloat(Float(1) - alpha);
                self.searchBar?.alpha = CGFloat(Float(1) - alpha);
            })
        }
        else if offsetY >= 125 {
            UIView.animate(withDuration: 0.25, animations: {
                () in
                self.searchBar?.frame = CGRect(x: 20, y: 30, width: self.width - 80, height: 30);
                self.searchButton?.isHidden = true;
                self.emailButton?.alpha = 1;
                self.emailButton?.setBackgroundImage(#imageLiteral(resourceName: "home_email_red.png"), for: .normal);
            })
        }
    }
}
