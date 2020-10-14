//
//  Plan.swift
//  Voice
//
//  Created by Peide Xiao on 10/14/20.
//

import Foundation

struct Plan: Decodable {
    var productId: String
    var title: String
    var category: String
    var price: Double
    var salePrice: Double
    var discount: Double
    var endAt: Int
    var labelImg: String
}
