//
//  VideoModel.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import Foundation

struct VideoModel:Decodable {
    var id: Int;
    var youtubeId: String;
    var imageUrl: String;
    var level: Int;
    var CEFRLevel: String;
    var CEFRLevelTag: String;
    var duration: Int;
    var durationText:String;
    var publishedAt: Int;
    var createdAt: Int;
    var title: String;
    var totalSaved: Int;
    var totalViewed: Int;
    var updatedAt: Int;
    var saved: Bool;
}
