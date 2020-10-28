//
//  ChallengeDetailModel.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import Foundation

struct ChallengeDetailModel: Codable {
    var videoId: Int
    var content: String
    var duration: Double
    var intro: String
    var id: Int
    var imageUrl: String
    var publishedAt: Int
    var startAt: Double
    var title: String
    var totalListened: Int
    var youtubeId: String
    var host: Host
    var audioUrl: String
    var translatedContent: String
    var vocabularies: [Vocabulary]
    var myComments: [Comment]?
}

/*
 "id": 4226,
             "definitions": [{
                 "content": "",
                 "text": "flicker ",
                 "kk": "\u02c8fl\u026ak\u0259r",
                 "soundUrl": "https:\/\/res.iciba.com\/resource\/amp3\/1\/0\/33\/1a\/331a904763dfed2545c8fd470dfad22d.mp3"
             }],
             "text": "flicker "
 */
struct Vocabulary: Codable {
    var id: Int
    var definitions: [DefinitionModel]
    var text: String
}

struct DefinitionModel: Codable {
    var content: String
    var text: String
    var kk: String
    var soundUrl: String?
}

/*
            "audioUrl": null,
             "content": "Hi",
             "createdAt": 1602079390,
             "id": 1887908,
             "owner": {
                 "avatarUrl": "https:\/\/cdn.voicetube.com\/tmp\/avatar\/033fb019cc0bb96.jpg?t=1600894948",
                 "contentLanguage": "en",
                 "displayName": "\u8096\u57f9\u5fb7",
                 "email": "653793658460936@facebook.com",
                 "id": 4122002,
                 "userName": "653793658460936",
                 "isAdmin": false
             },
             "totalLikes": 0,
             "from": null,
             "totalReplies": 0,
             "liked": false
 */

struct Comment: Codable {
    var audioUrl: String?
    var content: String?
    var createdAt: Int
    var id: Int
    var owner: User
    var totalLikes: Int
    var totalReplies: Int
    var liked: Bool
    var from: String?
    var mode: FetchMode?
}
