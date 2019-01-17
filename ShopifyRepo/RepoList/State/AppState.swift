//
//  AppState.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var repositoryScreenState: RepositoryScreenState
    var openURL: URL?
}

struct RepositoryScreenState: StateType {
    var repositoryStatus: RepositoryFetchingStatus<[Repository]>
}

enum RepositoryFetchingStatus<T> {
    case notStarted
    case inProgress
    case success(T)
    case failure(Error)
}
