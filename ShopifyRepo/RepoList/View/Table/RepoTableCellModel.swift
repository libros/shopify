//
//  RepoTableCellModel.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

struct RepoTableCellModel {
    let name: String
    let url: String
    let isFork: Bool
    let createdDate: Date
    let stars: Int
}
