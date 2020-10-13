//
//  Dictionary_Extension.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import Foundation

extension Dictionary {
    
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k);
        }
    }
}



//var dic:[String:Any] = ["name":"Peter"];
//var dic2:[String:Any] = ["age": 30];
//
//dic.forEach { (k,v) in
//    dic2[k] = v
//}
