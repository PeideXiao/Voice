//
//  NetworkManager.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


enum Result<String> {
    case success
    case failure(String)
}


struct NetworkManager {
    static let sharedInstance: NetworkManager = NetworkManager();
    static let enviroment: NetworkEnvironment = .production
    static let MovieAPIKey = "YOUR_API_KEY"
    private let movieRouter = Router(endPoint: MovieAPI.newMovies(page: 0))
    // TO DO
    
    private let categoryRouter = Router(endPoint: VideoAPI.Categories(lang: "en", userId: "4122002"))
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return  .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue);
        }
    }
    
    
    public func getQuestions(completion: @escaping(_ questions:[Question]?, _ error:String?)-> Void) {
        movieRouter.request(.newMovies(page: 0)) { (questions: [Question]?, response: URLResponse?, error: Error?) in
            if error != nil { completion(nil, "Please check your network connection") }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let questions = questions else {
                        return
                    }
                    completion(questions, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError);
                }
            }
        }
    }
    
    
    func getCategories(completion: @escaping (_ cagegories:[PDCategory]?, _ error:String?) -> Void) {
        
        categoryRouter.request(.Categories(lang: "en", userId: "4122002")) { (categories, response, error) in
            if error != nil { completion(nil, "Please check your network connection") }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let categories = categories else {
                        return
                    }
                    completion(categories, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError);
                }
            }
        }
    }   
}

