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
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var backgroundMainLabel: UILabel!
    @IBOutlet var statefulBackgroundView: UIView!
    
    @IBAction func didTapRetry(_ sender: Any) {
        fetchRepos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Repositories"
        
        let addRefreshControl = {
            self.tableView.refreshControl = UIRefreshControl()
            self.tableView.refreshControl?.addTarget(self, action: #selector(self.didPullRefreshControl), for: .valueChanged)
        }
        
        let setTableViewDelegate = {
            self.tableView.delegate = self.dataDelegate
            self.tableView.dataSource = self.dataDelegate
        }
        
        let setupTableViewCells = {
            self.tableView.estimatedRowHeight = 60
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.register(UINib(nibName: "\(RepoTableViewCell.self)", bundle: nil),
                                    forCellReuseIdentifier: "\(RepoTableViewCell.self)")
        }
        
        addRefreshControl()
        setTableViewDelegate()
        setupTableViewCells()
        
        store.subscribe(self) { (subscription: Subscription<AppState>) -> Subscription<RepositoryScreenState> in
            subscription.select { (appState) in
                appState.repositoryScreenState
            }
        }
        
        fetchRepos()
    }
    
    @objc private func didPullRefreshControl() {
        fetchRepos()
    }
    
    private func fetchRepos() {
        store.dispatch(fetchGithubRepositories)
    }
}

extension ShopifyRepoTableViewController: StoreSubscriber {
    
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
    
    func configDisplay(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        tableView.isHidden = false
        statefulBackgroundView.isHidden = true
        
        tableView.refreshControl?.endRefreshing()
    }
    
    func configError(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
        statefulBackgroundView.isHidden = false
        tableView.isHidden = true
        indicatorView.isHidden = true
    }
    
    func configLoading(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
        tableView.isHidden = true
        backgroundView.isHidden = true
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func configRefresh(tableView: UITableView, indicatorView: UIActivityIndicatorView, backgroundView: UIView) {
        tableView.isHidden = false
        backgroundView.isHidden = true
        indicatorView.isHidden = true
    }
}
