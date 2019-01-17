//
//  GithubService.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct GithubService {

    func repos(owner: String,
              page: String = "1",
              perPage: String = "100",
              completion: @escaping (_ response: Response<[Repository]>) -> Void,
              session: BleedingFastURLSession) -> URLSessionDataTaskProtocol? {

        let request =
            RestRequestURLQueryDecorator(params: ["per_page": perPage, "page": page],
                                         request: RestRequestMethodDecorator(method: .GET,
                                                                             baseRequest: GitHubRequest(path: "users/\(owner)/repos")))
        let dateDecodingFormatter = JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.rfc3339DateFormatter)
        return Rest.load(request: request, session: session,
                           dateDecodingStrategy: dateDecodingFormatter,
                           expectedResultType: [Repository].self)
        { repos, error in
            if let error = error {
                completion(Response.failure(error))
            }

            if let repos = repos {
                completion(Response.success(repos))
            }
        }
    }
}
