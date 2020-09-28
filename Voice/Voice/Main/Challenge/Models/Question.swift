//
//  Question.swift
//  PDNetworkManager
//
//  Created by Peide Xiao on 12/31/19.
//  Copyright © 2019 Peide Xiao. All rights reserved.
//

import UIKit


struct User {
    let name: String?
    let profileImageURL: URL?
    let reputation: Int?
}

extension User: Decodable {
    enum CodingKeys:String, CodingKey {
        case reputation
        case name = "display_name"
        case profileImageURL = "profile_image"
    }
}

struct Question {
    let score: Int
    let title: String
    let date: Date
    let tags: [String]
    let owner: User?
}


extension Question: Decodable {
    enum CodingKeys: String, CodingKey {
        case score
        case title
        case tags
        case owner
        case date = "creation_date"
    }
}



