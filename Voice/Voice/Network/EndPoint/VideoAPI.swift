//
//  VideoAPI.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import Foundation

public enum VideoAPI {
    case Categories(lang: String, userId: String)
    
}

extension VideoAPI: EndPointType {
    typealias ModelType = PDCategory
    
    var path: String {
        return "/v2.1/en/categories"
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .Categories(let lang, let userId):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: ["uiLanguage":lang, "userId":userId], additionalHeader: ["Authorization":AuthorizationKey]);
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Accept-Encoding": "gzip, deflate, br",
                "user-agengt":"VoiceTube/929 CFNetwork/1197 Darwin/20.0.0",
                "version":"14.0",
                "product":"VoiceTube",
                "accept-language":"en-US",
                "platform":"iOS",
                "version":"3.3.67",
                "cookie": "__cfduid=df5999c30c9c73ed8cc02aaa828744d881600975916"];
    }
    
}
