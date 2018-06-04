//
//  MenuTableViewController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var category: String!
    let menuController = MenuController()
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.capitalized
        menuController.fetchMenuItems(category: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let destination = segue.destination as! MenuItemDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let menuItem = menuItems[indexPath.row]
            destination.menuItem = menuItem
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        configure(cell: cell, cellForRowAt: indexPath)

        return cell
    }
    
    func configure(cell: UITableViewCell, cellForRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }

    

}








