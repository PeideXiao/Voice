//
//  User.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import Foundation

struct User: Decodable {
//    "avatarUrl": "https:\/\/cdn.voicetube.com\/tmp\/avatar\/329e5de8052af71.jpg?t=1529244861",
//    "contentLanguage": "zhTW",
//    "displayName": "April Lu",
//    "email": "luvivian0421@gmail.com",
//    "id": 993437,
//    "userName": "1083254375026196",
//    "isAdmin": false
    
    
    var avatarUrl: String;
    var contentLanguage: String;
    var displayName: String;
    var email: String;
    var id: Int;
    var userName: String;
    var isAdmin: Bool;
}
