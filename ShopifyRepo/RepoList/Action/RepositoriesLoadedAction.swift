//
//  RepositoriesLoadedAction.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

struct RepositoryLoadedAction: Action {
    let repositories: [Repository]?
    let error: Error?
    let inProgress: Bool
}
