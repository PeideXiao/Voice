//
//  PDCategory.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import UIKit

struct PDCategory {

    var id: Int
    var imageUrl: String
    var link: String
    var query: String
    var sequence: Int
    var title: String
    var trimmedTitle: String
    var isPro: Bool
    var allowAd: Bool
    var analyticsKey: String
    
}

extension PDCategory: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl
        case link
        case query
        case sequence
        case title
        case trimmedTitle
        case isPro
        case allowAd
        case analyticsKey
    }
}
