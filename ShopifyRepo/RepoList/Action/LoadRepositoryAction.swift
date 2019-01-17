//
//  LoadRepoAction.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

func fetchGithubRepositories(state: AppState, store: Store<AppState>) -> Action? {
    switch state.repositoryScreenState.repositoryStatus {
    case .inProgress:
        return nil
    default:
        _ = GithubService().repos(owner: "Shopify", completion: { (repositories) in
            DispatchQueue.main.async {
                switch repositories {
                case .failure(let error):
                    store.dispatch(RepositoryLoadedAction(repositories: nil, error: error, inProgress: false))
                case let .success(repos):
                    store.dispatch(RepositoryLoadedAction(repositories: repos, error: nil, inProgress: false))
                }
            }
        }, session: URLSession.shared)
    }
    return RepositoryLoadedAction(repositories: nil, error: nil, inProgress: true)
}
