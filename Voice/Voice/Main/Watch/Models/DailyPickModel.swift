//
//  DailyPickModel.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import Foundation

struct DailyPickModel: Decodable {
    var greeting: String
    var items:[DailyPickItem]
    
    
}

struct DailyPickItem: Decodable {
    var id: Int
    var startAt: Int
    var endAt: Int
    var imageUrl: String
    var labelText: String
    var title: String
    var type: String
    var openInApp: Bool
}
