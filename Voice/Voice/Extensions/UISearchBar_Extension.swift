//
//  UISearchBar_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/23/20.
//

import Foundation
import UIKit


extension UISearchBar {
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view: UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
