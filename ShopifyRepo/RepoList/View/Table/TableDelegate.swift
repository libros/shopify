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
    
    var repositories: [Repository]
    
    override init() {
        repositories = []
    }
}

extension RepoTableData: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
}

extension RepoTableData: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RepoTableViewCell.self)", for: indexPath) as! RepoTableViewCell
        cell.config(with: repositories[indexPath.row])
        return cell
    }
    
}
