//
//  CategoryTableViewController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    let menuController = MenuController()
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuController.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }

    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        configure(cell: cell, cellForRowAt: indexPath)
        
        return cell
    }
    
    func configure(cell: UITableViewCell, cellForRowAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
}













