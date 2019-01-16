//
//  RequestConfiguration.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

protocol RequestConfiguration {
    var apiEndpoint: String { get }
    
    var accessToken: String? { get }
    var accessTokenFieldName: String { get }
    
    var authorizationHeader: String? { get }
    
    var customHeaders: Array<HTTPHeader>? { get }
    
    var errorDomain: String { get }
}

extension RequestConfiguration {
    
    var accessTokenFieldName: String {
        return "access_token"
    }
    
    var authorizationHeader: String? {
        return nil
    }
    
    var errorDomain: String {
        return "bleeding.fast.error"
    }
    
    var customHeaders: Array<HTTPHeader>? {
        return nil
    }
}

struct HTTPHeader {
    var key: String
    var value: String
    
    init(headerField: String, value: String) {
        self.key = headerField
        self.value = value
    }
}
