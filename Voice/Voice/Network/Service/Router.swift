//
//  Router.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

class Router<EndPoint: EndPointType> {
    
    private var endPoint: EndPoint
    
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }
}

extension Router: NetworkRouter {
    
    func decode(_ data: Data) -> [EndPoint.ModelType]? {
        let wrapper = try? JSONDecoder().decode(Wrapper<EndPoint.ModelType>.self, from: data)
        return wrapper?.data;
    }
    
    func request(_ router: EndPoint, completion: @escaping (Array<EndPoint.ModelType>?, URLResponse?, Error?) -> ()) {
        self.loadRequest(router, completion: completion)
    }
    
    func cancel() {
        self.taskCancel()
    }
    
}
