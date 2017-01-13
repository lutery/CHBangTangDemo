//
//  CHButton.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/13.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

extension UIButton {
    
    func sizeOfLabelWith(MaxWidth width:CGFloat, SystemFontSize fontSize:CGFloat, Text str:String) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0));
        label.text = str;
        label.numberOfLines = 0;
        label.font = UIFont.systemFont(ofSize: fontSize);
        label.sizeToFit();
        
        let size = label.frame.size;
        
        return size;
    }
}
