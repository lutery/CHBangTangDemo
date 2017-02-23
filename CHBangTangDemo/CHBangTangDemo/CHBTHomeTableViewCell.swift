//
//  CHBTHomeTableViewCell.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/16.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class CHBTHomeTableViewCell: UITableViewCell {
    
    private var mHomeRecomandModel:CHHomeRecomandModel? = nil;
    var HomeRecomandModel:CHHomeRecomandModel?{
        get{
            return mHomeRecomandModel;
        }
        
        set{
            mHomeRecomandModel = newValue;
            
            if mHomeRecomandModel != nil {
                self.TopicImageView.sd_setImage(with: URL.init(string: (mHomeRecomandModel?.picUrl)!), placeholderImage: mHomeRecomandModel?.placeholderImage);
                self.TitleLabel.text = mHomeRecomandModel?.title;
                self.AuthorLabel.text = mHomeRecomandModel?.author;
                self.PvLabel.text = mHomeRecomandModel?.views;
                self.LikeLabel.text = mHomeRecomandModel?.likes;
            }
        }
    }
    private var mTopicImageView:UIImageView? = nil;
    var TopicImageView:UIImageView{
        get{
            if mTopicImageView == nil {
                mTopicImageView = UIImageView();
                mTopicImageView?.translatesAutoresizingMaskIntoConstraints = false;
                mTopicImageView?.image = UIImage(named: "recomand_01.jpg");
            }
            
            return mTopicImageView!;
        }
    }
    
    private var mTitleLabel:UILabel? = nil;
    var TitleLabel:UILabel{
        get{
            if mTitleLabel == nil {
                mTitleLabel = UILabel();
                mTitleLabel?.translatesAutoresizingMaskIntoConstraints = false;
                mTitleLabel?.textColor = UIColor.gray;
                mTitleLabel?.font = UIFont.systemFont(ofSize: 13);
                mTitleLabel?.text = "测试主题";
            }
            
            return mTitleLabel!;
        }
    }
    
    private var mAuthorLabel:UILabel? = nil;
    var AuthorLabel:UILabel{
        get{
            if mAuthorLabel == nil {
                mAuthorLabel = UILabel();
                mAuthorLabel?.translatesAutoresizingMaskIntoConstraints = false;
                mAuthorLabel?.textColor = UIColor.black.withAlphaComponent(0.5);
                mAuthorLabel?.font = UIFont.systemFont(ofSize: 11);
                mAuthorLabel?.text = "小糖君";
            }
            
            return mAuthorLabel!;
        }
    }
    
    private var mPvImageView:UIImageView? = nil;
    var PvImageView:UIImageView{
        get{
            if mPvImageView == nil {
                mPvImageView = UIImageView();
                mPvImageView?.translatesAutoresizingMaskIntoConstraints = false;
                mPvImageView?.image = UIImage(named: "home_watch");
            }
            
            return mPvImageView!;
        }
    }
    
    private var mPvLabel:UILabel? = nil;
    var PvLabel:UILabel{
        get{
            if mPvLabel == nil {
                mPvLabel = UILabel();
                mPvLabel?.translatesAutoresizingMaskIntoConstraints = false;
                mPvLabel?.textColor = UIColor.gray;
                mPvLabel?.font = UIFont.systemFont(ofSize: 11);
                mPvLabel?.text = "1000";
            }
            
            return mPvLabel!;
        }
    }
    
    private var mLikeImageView:UIImageView? = nil;
    var LikeImageView:UIImageView{
        get{
            if self.mLikeImageView == nil {
                self.mLikeImageView = UIImageView();
                self.mLikeImageView?.translatesAutoresizingMaskIntoConstraints = false;
                self.mLikeImageView?.image = UIImage(named: "home_like");
            }
            
            return self.mLikeImageView!;
        }
    }
    
    private var mLikeLabel:UILabel? = nil;
    var LikeLabel:UILabel{
        get{
            if mLikeLabel == nil {
                self.mLikeLabel = UILabel();
                self.mLikeLabel?.translatesAutoresizingMaskIntoConstraints = false;
                self.mLikeLabel?.textColor = UIColor.gray;
                self.mLikeLabel?.font = UIFont.systemFont(ofSize: 11);
                self.mLikeLabel?.text = "2000";
            }
            
            return self.mLikeLabel!;
        }
    }
    
    private var mBottomView:UIView? = nil;
    var BottomView:UIView {
        get{
            if self.mBottomView == nil {
                self.mBottomView = UIView();
                self.mBottomView?.translatesAutoresizingMaskIntoConstraints = false;
            }
            
            return self.mBottomView!;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.contentView.addSubview(self.TopicImageView);
        self.contentView.addSubview(self.TitleLabel);
        self.contentView.addSubview(self.BottomView);
        self.contentView.addSubview(self.AuthorLabel);
        self.contentView.addSubview(self.PvImageView);
        self.contentView.addSubview(self.PvLabel);
        self.contentView.addSubview(self.LikeImageView);
        self.contentView.addSubview(self.LikeLabel);
        
        self.selectionStyle = .none;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        self.TopicImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        self.TopicImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true;
        self.TopicImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true;
        self.TopicImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true;
        
        self.TitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true;
        self.TitleLabel.topAnchor.constraint(equalTo: self.TopicImageView.bottomAnchor, constant: 20).isActive = true;
        
        self.AuthorLabel.leadingAnchor.constraint(equalTo: self.BottomView.leadingAnchor).isActive = true;
        self.AuthorLabel.topAnchor.constraint(equalTo: self.TitleLabel.bottomAnchor, constant: 15).isActive = true;
        
        self.PvImageView.leadingAnchor.constraint(equalTo: self.AuthorLabel.trailingAnchor, constant: 10).isActive = true;
        self.PvImageView.topAnchor.constraint(equalTo: self.AuthorLabel.topAnchor).isActive = true;
        self.PvImageView.widthAnchor.constraint(equalToConstant: 11);
        self.PvImageView.heightAnchor.constraint(equalToConstant: 11);
    }
}
