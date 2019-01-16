//
//  TokenRequestConfiguration.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

private let githubBaseURL = "https://api.github.com"

struct TokenRequestConfiguration: RequestConfiguration {
    
    let apiEndpoint: String
    let accessToken: String?
    
    init(accessToken: String, apiEndpoint: String = githubBaseURL) {
        self.accessToken = accessToken
        self.apiEndpoint = apiEndpoint
    }
}
