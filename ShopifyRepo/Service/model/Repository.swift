//
//  Repository.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

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
