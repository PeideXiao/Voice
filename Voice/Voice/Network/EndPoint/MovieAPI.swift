//
//  MovieAPI.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public enum MovieAPI {
    case recommend(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}



extension MovieAPI: EndPointType {
    
    typealias ModelType = Question

    var path: String {
        switch self {
        case .recommend(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "questions"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies:
            let parameters: [String : Any]? = [
                "site":"stackoverflow",
                "tagged":"ios",
                "sort":"votes",
                "order":"desc",
                "pagesize":"2"
            ]
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: parameters)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
