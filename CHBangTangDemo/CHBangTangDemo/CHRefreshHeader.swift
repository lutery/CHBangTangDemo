//
//  CHRefreshHeader.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/16.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class CHRefreshHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    weak var tableView:UITableView? = nil;
    
    private var refreshImageView:UIImageView? = nil;
    
    private var mImageViews:[UIImageView]? = nil;
    var imageViews:[UIImageView]?{
        get{
            if mImageViews == nil {
                mImageViews = [UIImageView]();
                
                for i in 0..<11 {
                    let imageUrl = String.init(format: "header%2d%@", "@2x.jpg");
                    let image = UIImage(named: imageUrl);
                    let imageView = UIImageView(frame: self.bounds);
                    imageView.image = image;
                    imageView.isHidden = true;
                    self.mImageViews?.append(imageView);
                    self.addSubview(imageView);
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.addSubview(refreshImageView!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview);
        
        let options = NSKeyValueObservingOptions.new.rawValue | NSKeyValueObservingOptions.old.rawValue;
        
        self.tableView?.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions(rawValue: options), context: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !(keyPath == "contentOffset") {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context);
            return;
        }
        
        let tableView = object as! UITableView;
        var tableViewOffsetY = tableView.contentOffset.y;
        
        if tableViewOffsetY <= 0 && tableViewOffsetY > -35 {
            self.hideAllImageView();
        }
        else if tableViewOffsetY < -35{
            if tableViewOffsetY < -59 {
                self.showAllImageView();
            }
            else{
                let offset = fabsf(Float(tableViewOffsetY)) - 35;
                let imageCount = offset / 2.0;
                self.hideImageView(Except: Int(imageCount));
            }
        }
        else if tableViewOffsetY < 136 {
            
        }
    }
    
    func showAllImageView(){
        for i in 0..<(self.imageViews?.count)! {
            let imageView = self.imageViews?[i];
            imageView?.isHidden = false;
        }
    }
    
    func hideAllImageView(){
        for i in 0..<(self.imageViews?.count)! {
            let imageView = self.imageViews?[i];
            imageView?.isHidden = true;
        }
    }
    
    func hideImageView(Except index:Int){
        if index >= (self.imageViews?.count)! {
            return;
        }
        
        for i in 0..<(self.imageViews?.count)! {
            let imageView = self.imageViews?[i];
            if i == index {
                imageView?.isHidden = false;
            }
            else{
                imageView?.isHidden = true;
            }
        }
    }
}
