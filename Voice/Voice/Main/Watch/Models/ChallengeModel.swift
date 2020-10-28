//
//  ChallengeModel.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import Foundation
//"content": "Sometimes it's just footsteps or hearing a voice, a light that flickers, or sometimes it's an actual full, physical manifestation.",
//"duration": 11,
//"host": {
//    "avatarUrl": "https:\/\/cdn.voicetube.com\/tmp\/avatar\/7dc4fe7ea6fcd02.jpg?t=1596525796",
//    "displayName": "Celine Chien"
//},
//"intro": "Jingle + Intro: 0:00 - 0:21 \/ Brief Introduction about the Host and Topic  0:21 - 1:09 \/ Sentence of the Day 1:09 - 1:20 \/ Pronunciation Tips 1:20 - 1:48  \/ Word of the Day 1:48 - 2:57 \/ Vocabulary (2) 2:57 - 4:24 \/ Vocabulary (3) 4:24 - 4:40 \/ Outro 4:40 - 4:53\r\n",
//"id": 4729,
//"imageUrl": "https:\/\/cdn.voicetube.com\/assets\/thumbnails\/wHZtCJlXbBQ.jpg",
//"publishedAt": 1602000000,
//"startAt": 80,
//"title": "Step Inside a Real Haunted House",
//"totalListened": 31,
//"youtubeId": "wHZtCJlXbBQ"

struct ChallengeModel: Codable {
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
}


struct Host: Codable {
    var avatarUrl: String
    var displayName: String
}
