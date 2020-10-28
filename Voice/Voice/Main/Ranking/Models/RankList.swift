//
//  TodayRankItem.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import Foundation

struct RankList: Codable {
    var today: [RankItem]
    var yesterday: [RankItem]
}


struct RankItem: Codable {
    var rank: Int
    var points: Int
    var size: Int
    var isSelf: Bool
    var users: [RankUser]
    var showEllipsis: Bool?
}


struct RankUser: Codable {
    var id: Int
    var name: String
    var avatar: String
}
