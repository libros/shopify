//
//  LoadRepoAction.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import ReSwift

struct LoadRepositoryAction: Action {
    let owner: String
    let page: UInt = 1
    let page_size: UInt = 100
}

func fetchGithubRepositories(state: AppState, store: Store<AppState>) -> Action? {
    _ = GithubService().repos(owner: "Shopify", completion: { (repositories) in
        DispatchQueue.main.async {
            switch repositories {
            case .failure(let error):
                store.dispatch(RepositoryLoadedAction(repositories: nil, error: error, inProgress: false))
            case let .success(repos):
                print(repos.map { $0.fullName })
                store.dispatch(RepositoryLoadedAction(repositories: repos, error: nil, inProgress: false))
            }
        }
    }, session: URLSession.shared)
    
    return RepositoryLoadedAction(repositories: nil, error: nil, inProgress: true)
}
