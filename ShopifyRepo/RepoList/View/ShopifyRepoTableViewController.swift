//
//  ShopifyRepoTableViewController.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import UIKit
import ReSwift

class ShopifyRepoTableViewController: UIViewController {
    
    private let dataDelegate = RepoTableData()

    // MARK: -
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var backgroundMainLabel: UILabel!
    @IBOutlet var statefulBackgroundView: UIView!
    
    @IBAction func didTapRetry(_ sender: Any) {
        fetchRepos()
    }
    
    @objc private func didPullRefreshControl() {
        fetchRepos()
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Repositories"
        
        {(tableView: UITableView) in
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(self.didPullRefreshControl), for: .valueChanged)
        }(tableView);
        
        {(tableView: UITableView, delegate: UITableViewDelegate, dataSource: UITableViewDataSource ) in
            tableView.delegate = delegate
            tableView.dataSource = dataSource
        }(tableView, dataDelegate, dataDelegate);

        {(tableView: UITableView) in
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "\(RepoTableViewCell.self)", bundle: nil),
                                    forCellReuseIdentifier: "\(RepoTableViewCell.self)")
        }(tableView);
        
        store.subscribe(self) { (subscription: Subscription<AppState>) -> Subscription<RepositoryScreenState> in
            subscription.select { (appState) in
                appState.repositoryScreenState
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRepos()
    }
}

extension ShopifyRepoTableViewController: StoreSubscriber {
    
    private func fetchRepos() {
        store.dispatch(fetchGithubRepositories)
    }
    
    func newState(state: RepositoryScreenState) {
        switch state.repositoryStatus {
        case .success(let repos):
            configDisplay(tableView: tableView, indicatorView: indicatorView, backgroundView: statefulBackgroundView)
            dataDelegate.repositories = repos
            tableView.reloadData()
        case .failure:
            configError(tableView: tableView, indicatorView: indicatorView, backgroundView: statefulBackgroundView)
        case .inProgress:
            if dataDelegate.repositories.isEmpty {
                configLoading(tableView: tableView, indicatorView: indicatorView, backgroundView: statefulBackgroundView)
            } else {
                configRefresh(tableView: tableView, indicatorView: indicatorView, backgroundView: statefulBackgroundView)
            }
        default:
            break
        }
    }
}

// MARK: -

fileprivate func configDisplay(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
    indicatorView.stopAnimating()
    indicatorView.isHidden = true
    tableView.isHidden = false
    backgroundView.isHidden = true
    tableView.refreshControl?.endRefreshing()
}

fileprivate func configError(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
    backgroundView.isHidden = false
    tableView.isHidden = true
    indicatorView.isHidden = true
}

fileprivate func configLoading(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
    tableView.isHidden = true
    backgroundView.isHidden = true
    indicatorView.isHidden = false
    indicatorView.startAnimating()
}

fileprivate func configRefresh(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
    tableView.isHidden = false
    backgroundView.isHidden = true
    indicatorView.isHidden = true
}
