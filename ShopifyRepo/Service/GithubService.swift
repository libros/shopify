//
//  GithubService.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct GithubService {
    private let configuration: RequestConfiguration
    
    init(config: RequestConfiguration) {
        self.configuration = config
    }
}

extension GithubService {
    
    func repo(owner: String,
              page: String = "1",
              perPage: String = "100",
              completion: @escaping (_ response: Response<[Repository]>) -> Void,
              session: BleedingFastURLSession) -> URLSessionDataTaskProtocol? {
        let router = RepositoryRouter.readRepositories(configuration, owner, page, perPage)
        return router.load(session,
                           dateDecodingStrategy: .formatted(Time.rfc3339DateFormatter),
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

struct Repository: Codable {
    private(set) var id: Int = -1
    private(set) var owner = User()
    var name: String?
    var fullName: String?
    private(set) var isPrivate: Bool = false
    var repositoryDescription: String?
    private(set) var isFork: Bool = false
    var gitURL: String?
    var sshURL: String?
    var cloneURL: String?
    var htmlURL: String?
    private(set) var size: Int = -1
    var lastPush: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case repositoryDescription = "description"
        case isFork = "fork"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case htmlURL = "html_url"
        case size
        case lastPush = "pushed_at"
    }
}

class User: Codable {
    private(set) var id: Int = -1
    var login: String?
    var avatarURL: String?
    var gravatarID: String?
    var type: String?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var numberOfPublicRepos: Int?
    var numberOfPublicGists: Int?
    var numberOfPrivateRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case type
        case name
        case company
        case blog
        case location
        case email
        case numberOfPublicRepos = "public_repos"
        case numberOfPublicGists = "public_gists"
        case numberOfPrivateRepos = "total_private_repos"
    }
}

enum RepositoryRouter: Router {
    case readRepositories(RequestConfiguration, String, String, String)
    case readAuthenticatedRepositories(RequestConfiguration, String, String)
    case readRepository(RequestConfiguration, String, String)
    
    var configuration: RequestConfiguration {
        switch self {
        case .readRepositories(let config, _, _, _): return config
        case .readAuthenticatedRepositories(let config, _, _): return config
        case .readRepository(let config, _, _): return config
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var encoding: HTTPEncoding {
        return .url
    }
    
    var params: [String: Any] {
        switch self {
        case .readRepositories(_, _, let page, let perPage):
            return ["per_page": perPage, "page": page]
        case .readAuthenticatedRepositories(_, let page, let perPage):
            return ["per_page": perPage, "page": page]
        case .readRepository:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .readRepositories(_, let owner, _, _):
            return "users/\(owner)/repos"
        case .readAuthenticatedRepositories:
            return "user/repos"
        case .readRepository(_, let owner, let name):
            return "repos/\(owner)/\(name)"
        }
    }
}

struct Time {
    /**
     A date formatter for RFC 3339 style timestamps. Uses POSIX locale and GMT timezone so that date values are parsed as absolutes.
     - [https://tools.ietf.org/html/rfc3339](https://tools.ietf.org/html/rfc3339)
     - [https://developer.apple.com/library/mac/qa/qa1480/_index.html](https://developer.apple.com/library/mac/qa/qa1480/_index.html)
     - [https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html)
     */
    public static var rfc3339DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
