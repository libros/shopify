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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with repo: Repository) {
        if repo.isFork == true {
            mainLabel.text = "\(repo.name!)🍴"
        } else {
            mainLabel.text = repo.name
        }
        
        timeCreatedLabel.text = "\(repo.createdTime!)"
        startNumberLabel.text = "\(repo.stargazersCount!) 🌟"
    }
}
