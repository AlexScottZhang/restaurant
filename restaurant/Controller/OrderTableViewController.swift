//
//  OrderTableViewController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    @IBOutlet weak var submitBarButton: UIBarButtonItem!
    
    var menuItems = [MenuItem]() {
        didSet {
            MenuItemsController.shared.saveToFile(with: menuItems)
        }
    }
    var orderMinutes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = MenuItemsController.shared.loadFromFile() ?? []
        navigationItem.leftBarButtonItem = editButtonItem
        updateSubmitButton()
        updateBadgeNumber()
    }
    

    //badge显示选择的menu数
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    //segue
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        //返回时清空订单
        if segue.identifier == "DismissConfirmation" {
            menuItems.removeAll()
            tableView.reloadData()
            orderMinutes = 0
            updateBadgeNumber()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let destination = segue.destination as! OrderConfirmationViewController
            destination.minutes = orderMinutes
        }
    }
    
    //submit user order
    @IBAction func submitButtonTapped() {
        let orderTotal = menuItems.reduce(0) { $0 + $1.price }
        let formatTotal = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "确认订单", message: "你要提交总价为\(formatTotal)的订单么?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "提交", style: .default, handler: { (action) in
            self.uploadOrder()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        
        MenuController.shared.submitOrder(menuIds: menuIds) { (minutes) in
            if let minutes = minutes {
                self.orderMinutes = minutes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
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
            updateSubmitButton()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Utilities
    func configure(cell: OrderTableViewCell, cellForRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.titleLabel.text = menuItem.name
        cell.priceLabel.text = String(format: "$%.2f", menuItem.price)
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            //配置图片前检查cell是否被reuse了
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath {
                    return
                }
                cell.menuImageView.image = image
            }
        }
    }
    
    func updateSubmitButton() {
        submitBarButton.isEnabled = menuItems.count > 0
    }

}

extension OrderTableViewController: AddToOrderDelegate {
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let indexPath = IndexPath(row: menuItems.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
        updateSubmitButton()
    }
}











