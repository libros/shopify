//
//  GithubRequest.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct GitHubRequest: RestRequest {
    
    private static let githubBaseURL = "https://api.github.com"
    
    private let path: String
    
    init(path: String) {
        self.path = path
    }
    
    func request() -> URLRequest? {
        guard let url = URL(string: GitHubRequest.githubBaseURL) else { return nil }
        guard let pathURL = URL(string: path, relativeTo: url) else { return nil }
        return URLRequest(url: pathURL)
    }
}
