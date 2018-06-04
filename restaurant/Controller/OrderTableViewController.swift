//
//  OrderTableViewController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var menuItems = [MenuItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    //badge显示选择的menu数
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        configure(cell: cell, cellForRowAt: indexPath)
        
        return cell
    }
    
    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
    
    func configure(cell: UITableViewCell, cellForRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }

}

extension OrderTableViewController: AddToOrderDelegate {
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let indexPath = IndexPath(row: menuItems.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
}











