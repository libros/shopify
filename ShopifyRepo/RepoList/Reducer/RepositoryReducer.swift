//
//  RepositoryReducer.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

func repositoryReducer(action: Action, state: RepositoryScreenState?) -> RepositoryScreenState? {
    switch action {
    case _ as LoadRepositoryAction:
        return nil
    case let action as RepositoryLoadedAction:
        if action.inProgress {
            return RepositoryScreenState(repositoryStatus: .inProgress)
        }
        
        if let error = action.error {
            return RepositoryScreenState(repositoryStatus: .failure(error))
        }
        
        if let repositories = action.repositories {
            return RepositoryScreenState.init(repositoryStatus: .success(repositories))
        }
        
        return nil
    default:
        return nil
    }
}
