//
//  TableDelegate.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation
import UIKit

class RepoTableData: NSObject {
    
    private var sortedRepositories: [Repository] = []
    
    var repositories: [Repository] {
        set {
            sortedRepositories = newValue.sorted {
                let sameStar = ($0.stargazersCount ?? 0) == ($1.stargazersCount ?? 0)
                if sameStar {
                    return $0.name ?? "" < $1.name ?? ""
                }
                return ($0.stargazersCount ?? 0) > ($1.stargazersCount ?? 0)
            }
        }
        get {
            return sortedRepositories
        }
    }
    
    override init() {
        sortedRepositories = []
    }
}

extension RepoTableData: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = sortedRepositories[indexPath.row]
        guard let htmlURLString = selectedRepo.htmlURL,
            let htmlURL = URL(string: htmlURLString) else {
            return
        }
        store.dispatch(OpenURLAction(url: htmlURL))
    }
}

extension RepoTableData: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RepoTableViewCell.self)", for: indexPath) as! RepoTableViewCell
        cell.config(with: sortedRepositories[indexPath.row])
        return cell
    }
}
