//
//  CHHomeRecomandModel.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/16.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class CHHomeRecomandModel: NSObject {
    
    var placeholderImage:UIImage?;
    var picUrl:String;
    var title:String;
    var author:String;
    var views:String;
    var likes:String;
    
    override init() {
        placeholderImage = nil;
        picUrl = "";
        title = "";
        author = "";
        views = "";
        likes = "";
        
        super.init();
    }
}
