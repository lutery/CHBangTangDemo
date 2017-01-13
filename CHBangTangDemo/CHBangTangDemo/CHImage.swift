//
//  CHImage.swift
//  CHBangTangDemo
//
//  Created by lutery on 2017/1/11.
//  Copyright © 2017年 lutery. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color:UIColor, size:CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height);
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    func transform(Width width:CGFloat, Height height:CGFloat) -> UIImage? {
        let imageRef = self.cgImage;
        let bitmap = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: (imageRef?.bitsPerComponent)!, bytesPerRow: 4 * Int(width), space: imageRef as! CGColorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue);
        
        bitmap?.draw(imageRef!, in: CGRect(x: 0, y: 0, width: width, height: height));
        
        let ref = bitmap?.makeImage();
        let resultImage = UIImage(cgImage: ref!);
        
        return resultImage;
    }
    
    func imageCompressForSize(source:UIImage, targetSize:CGSize) -> UIImage? {
        
        var targetSize = targetSize
        let imageSize = source.size;
        if imageSize.width > imageSize.height {
            targetSize = CGSize(width: targetSize.height, height: targetSize.width);
        }
        
        let width = Float(imageSize.width);
        let height = Float(imageSize.height);
        let targetWidth = Float(targetSize.width);
        let targetHeight = Float(targetSize.height);
        var scaleFactor:Float = 0.0;
        var scaledWidth = targetWidth;
        var scaledHeight = targetHeight;
        var thumbnailPoint = CGPoint(x: 0.0, y: 0.0);
        
        guard !(imageSize.equalTo(targetSize)) else {
            return nil;
        }
        
        let widthFactor = targetWidth / width;
        let heightFactor = targetHeight / height;
        
        if widthFactor > heightFactor {
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if widthFactor > heightFactor {
            thumbnailPoint.y = CGFloat(Double((targetHeight - scaledHeight)) * 0.5);
        }
        else if widthFactor < heightFactor {
            thumbnailPoint.x = CGFloat(Double(targetWidth - scaledWidth) * 0.5);
        }
        
        UIGraphicsBeginImageContext(targetSize);
        
        var thumbnailRect = CGRect.zero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = CGFloat(scaledWidth);
        thumbnailRect.size.height = CGFloat(scaledHeight);
        source.draw(in: thumbnailRect);
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if newImage == nil {
            print("scale image fail");
        }
        
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    func compressImageBelow(count:NSInteger) -> Data? {
        var data11:Data = UIImageJPEGRepresentation(self, 1)!;
        var i:Double = 15;
        
        while data11.count > count {
            i = i * 2.0 / 3.0;
            data11 = UIImageJPEGRepresentation(self, CGFloat(i / 10.0))!;
            
            if i < 1 {
                i = 0;
                data11 = UIImageJPEGRepresentation(self, CGFloat(i))!;
            }
        }
        
        return data11;
    }
    
    func squareImage() -> UIImage {
        var squrareImageRef:CGImage? = nil;
        
        if self.size.width < self.size.height {
            squrareImageRef = self.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height));
        }
        else{
            squrareImageRef = self.cgImage?.cropping(to: CGRect(x: (self.size.width - self.size.height) / 2.0,y: 0,width: self.size.height,height: self.size.height));
        }
        
        let squrareImage = UIImage(cgImage: squrareImageRef!);
        
        return squrareImage;
    }
}
