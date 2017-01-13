//
//  CHView.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/13.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

extension UIView {
    var x:CGFloat{
        get{
            return self.frame.origin.x;
        }
        set{
//            var frame = self.frame;
//            frame.origin.x = newValue;
//            self.frame = frame;
            self.frame.origin.x = newValue;
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.origin.y;
        }
        set{
            self.frame.origin.y = newValue;
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width;
        }
        
        set{
            self.frame.size.width = newValue;
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height;
        }
        
        set{
            self.frame.size.height = newValue;
        }
    }
    
    var size:CGSize{
        set{
            self.frame.size = newValue;
        }
        
        get{
            return self.frame.size;
        }
    }
    
    var centerX:CGFloat{
        get{
            return self.center.x;
        }
        
        set{
            self.center.x = newValue;
        }
    }
    
    var centerY:CGFloat{
        get{
            return self.center.y;
        }
        
        set{
            self.center.y = newValue;
        }
    }
    
    
}
