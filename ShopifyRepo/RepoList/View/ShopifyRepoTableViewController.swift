//
//  ShopifyRepoTableViewController.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import UIKit
import ReSwift

class ShopifyRepoTableViewController: UITableViewController {
    
    private let dataDelegate = RepoTableData()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Repositories"
        
        tableView.delegate = dataDelegate
        tableView.dataSource = dataDelegate
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "\(RepoTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(RepoTableViewCell.self)")
        
        store.subscribe(self) { (subscription: Subscription<AppState>) -> Subscription<RepositoryScreenState> in
            subscription.select { (appState) in
                appState.repositoryScreenState
            }
        }
        store.dispatch(fetchGithubRepositories)
    }
}

extension ShopifyRepoTableViewController: StoreSubscriber {
    
    func newState(state: RepositoryScreenState) {
        switch state.repositoryStatus {
        case .success(let repos):
            print(repos)
            dataDelegate.repositories = repos
            tableView.reloadData()
        case .failure(let error):
            break
        default:
            break
        }
    }
}
