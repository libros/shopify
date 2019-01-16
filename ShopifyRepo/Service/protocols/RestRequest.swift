//
//  RestRequest.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

protocol RestRequest {
    func request() -> URLRequest?
}

protocol RestRequestDecorator: RestRequest {
    var baseRequest: RestRequest { get }
}
