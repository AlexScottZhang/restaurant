//
//  MenuItemDetailViewController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.orderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.orderButton.transform = CGAffineTransform.identity
        }
//        UIView.animate(withDuration: 0.3, animations: {
//            self.orderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
//        }) { (_) in
//            UIView.animate(withDuration: 0.3, animations: {
//                self.orderButton.transform = CGAffineTransform.identity
//            })
//        }
    }
    
    
    func updateUI() {
        nameLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        orderButton.layer.cornerRadius = 5.0
    }
    



}
