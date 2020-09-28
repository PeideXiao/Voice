//
//  UIImage_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/23/20.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    
    func resize(size: CGSize)-> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        let imageRect:CGRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height);
        self.draw(in: imageRect);
        let tempImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tempImage;
    }
    
    func rotate(orientation: UIImage.Orientation) -> UIImage? {
   
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale);
        let imageRect:CGRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height);
        if let CGImageData:CGImage = self.cgImage {
            UIImage(cgImage: CGImageData, scale: 1.0, orientation: orientation).draw(in: imageRect);
        }
        let tempImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tempImage;
    }
}
