//
//  VideoDetailModel.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import Foundation

struct VideoDetailModel: Decodable {
    
    var accent: String?;
    var captioned: Bool;
    var caption: CaptionModel?;
    var duration: Int;
    var durationText: String;
    var id: Int;
    var imageUrl: String;
    var level: Int;
    var CEFRLevel: String;
    var CEFRLevelTag: String;
    var proCategories: [ProCategoryModel]?;
    var publishedAt: Int;
    var title: String;
    var updatedAt: Int;
    var youtubeId: String;
    var youtubeUrl: String?;
    var points: [PointModel]?;
    var menu: [MenuModel];
    var uploader: User?;
    var captionLines:[CaptionLine]?;
}


struct CaptionModel: Decodable {
    var editable: Bool;
    var translated: Bool;
    var translatedByBot: Bool;
}


struct ProCategoryModel: Decodable {
    var id: String;
    var title: String;
}

struct PointModel: Decodable {
    var stage: String;
    var points: Int;
}


struct MenuModel: Decodable {
    var id: String;
    var enabled: Bool;
    var text: String;
}
