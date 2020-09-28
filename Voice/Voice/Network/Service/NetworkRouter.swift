//
//  NetworkRouter.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit


//public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()
public enum NetworkEnvironment {
    case qa
    case production
    case staging
}

fileprivate var environmentBaseURL: String {
     switch NetworkManager.enviroment {
     case .production: return "https://vtapi.voicetube.com"
     case .qa: return ""
     case .staging:  return ""
     }
 }
 
fileprivate var baseURL: URL {
     guard let url = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configured.") }
     return url
 }

fileprivate var task: URLSessionTask?


protocol NetworkRouter: class {
    associatedtype ModelType
    associatedtype EndPoint: EndPointType
    func request(_ router: EndPoint, completion:@escaping(ModelType?, URLResponse?, Error?)->())
    func decode(_ data: Data)-> ModelType?
    func cancel()
}

extension NetworkRouter {
   
   public func loadRequest(_ router: EndPoint, completion: @escaping (ModelType?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: router);
             task = session.dataTask(with: request, completionHandler: { [weak self](data, response, error) in
                guard let data = data else { return }
                completion(self?.decode(data), response, error);
            })
            task!.resume();
        } catch {
            completion(nil, nil, error)
        }
    }
    
    
    public func taskCancel() {
        task?.cancel()
    }
    
    /// FILEPRIVATE functions
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(route.path),
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do  {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeader):
                self.addAdditionalHeader(additionalHeader: additionalHeader, request: &request);
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            
            return request
            
        } catch {
            throw error
        }
    }
    
    
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    
    
    fileprivate func addAdditionalHeader(additionalHeader: HTTPHeaders?, request: inout URLRequest) {
        
        guard let headers = additionalHeader else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key);
        }
    }
    
    
}
