//
//  User.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct User {
    let id: Int?
    let login: String?
    let avatarURL: String?
    let gravatarID: String?
    let type: String?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let numberOfPublicRepos: Int?
    let numberOfPublicGists: Int?
    let numberOfPrivateRepos: Int?
}

extension User: Codable {
    
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
