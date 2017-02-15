//
//  CHTableViewModule.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/2/9.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

class CHTableViewModule: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var modelArray:NSMutableArray? = nil;
    public var ModelArray:NSMutableArray {
        if self.modelArray == nil {
            self.modelArray = NSMutableArray();
        }
        
        return self.modelArray!;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.modelArray?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CHBTHomeTableViewCell));
        
        return cell!;
    }
    
    private func loadData(){
        let filePath = Bundle.main.path(forResource: "index", ofType: "json");
        
        do{
            let data = try Data.init(contentsOf: URL(fileURLWithPath: filePath!));
            let dic = try (JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary);
            
            let dataArray = (dic.object(forKey: "data") as! NSDictionary).object(forKey: "topic") as! NSArray;
            
            self.modelArray?.removeAllObjects();
            
            for i in 0..<dataArray.count {
                let model = CHHomeRecomandModel();
                let imagePath = String.init(format: "recommand_%02ld%@", i + 1, ".jpg");
                let image = UIImage(named: imagePath);
                
                model.placeholderImage = image;
                
                var itemDic = dataArray[i] as! NSDictionary;
                model.picUrl = itemDic.object(forKey: "pic") as! String;
                model.title = itemDic.object(forKey: "title") as! String;
                model.views = itemDic.object(forKey: "views") as! String;
                model.likes = itemDic.object(forKey: "likes") as! String;
            }
        }
        catch let error as NSError{
            print(error);
        }
        
    }
}
