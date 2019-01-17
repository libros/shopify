//
//  AppReducer.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        repositoryScreenState: repositoryReducer(action: action, state: state?.repositoryScreenState) ?? RepositoryScreenState(repositoryStatus: .notStarted)
    )
}
