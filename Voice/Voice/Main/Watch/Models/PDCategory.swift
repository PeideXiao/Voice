//
//  PDCategory.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import UIKit

struct PDCategory: Codable {

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

//extension PDCategory: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case imageUrl
//        case link
//        case query
//        case sequence
//        case title
//        case trimmedTitle
//        case isPro
//        case allowAd
//        case analyticsKey
//    }
//}

struct ArrWrapper<T: Codable>: Codable {
    let data: [T]
}

struct DictWrapper<T:Codable>: Codable {
    var data:T
}

/*
 extension Movie: Decodable {
 
 enum MovieCodingKeys: String, CodingKey {
     case id
     case posterPath = "poster_path"
     case backdrop = "backdrop_path"
     case title
     case releaseDate = "release_date"
     case rating = "vote_average"
     case overview
 }
 
 
 init(from decoder: Decoder) throws {
     let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
     
     id = try movieContainer.decode(Int.self, forKey: .id)
     posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
     backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
     title = try movieContainer.decode(String.self, forKey: .title)
     releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
     rating = try movieContainer.decode(Double.self, forKey: .rating)
     overview = try movieContainer.decode(String.self, forKey: .overview)
 }
}
*/
