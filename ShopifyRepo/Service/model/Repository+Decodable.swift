//
//  Repository.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct Repository {
    
    let id: Int = -1
    let owner: User?
    let name: String?
    let fullName: String?
    let isPrivate: Bool?
    let repositoryDescription: String?
    let isFork: Bool?
    let gitURL: String?
    let sshURL: String?
    let cloneURL: String?
    let htmlURL: String?
    let size: Int?
    let lastPush: Date?
}

extension Repository: Codable {

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
