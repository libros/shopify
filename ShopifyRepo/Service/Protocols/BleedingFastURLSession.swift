//
//  BleedingFastURLSession.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

protocol BleedingFastURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: BleedingFastURLSession {
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask)
    }
}
