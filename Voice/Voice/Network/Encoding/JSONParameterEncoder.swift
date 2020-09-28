//
//  JSONParameterEncoder.swift
//  NetWorkLayer
//
//  Created by Peide Xiao on 1/2/20.
//  Copyright © 2020 Peide Xiao. All rights reserved.
//

import UIKit

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if (urlRequest.value(forHTTPHeaderField: "Content-Type") == nil) {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
