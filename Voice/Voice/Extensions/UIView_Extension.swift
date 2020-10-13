//
//  UIView_Extension.swift
//  Voice
//
//  Created by Peide Xiao on 10/2/20.
//

import Foundation
import UIKit

extension UIView {
    func Snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0);
        drawHierarchy(in: bounds, afterScreenUpdates: true);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
}
