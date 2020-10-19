//
//  UIFont_Extension.swift
//  Voice
//
//  Created by Peide Xiao on 10/16/20.
//

import Foundation

import UIKit

enum FontWeightStyle: String {
    case Regular = "Regular"
    case Medium = "Medium"
    case Bold = "Bold"
}


extension UIFont {
    class func AvenirNext(weight style:FontWeightStyle, _ size: CGFloat)-> UIFont {
        return UIFont(name: "AvenirNext-\(style.rawValue)", size: size)!
    }
}
