//
//  RepoTableViewCell.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/17/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timeCreatedLabel: UILabel!
    @IBOutlet weak var startNumberLabel: UILabel!
    
    func config(with repo: RepoTableCellModel) {
        mainLabel.text = "\(repo.name)" + (repo.isFork ? "🍴" : "")
        timeCreatedLabel.text = DateFormatter.simpleDate.string(from: repo.createdDate)
        startNumberLabel.text = "\(repo.stars) 🌟"
    }
}

extension DateFormatter {
    static let simpleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
