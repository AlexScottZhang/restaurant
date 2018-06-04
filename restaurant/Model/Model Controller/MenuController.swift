//
//  MenuController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import Foundation

class MenuController {
    let baseURL = URL(string: "http://127.0.0.1:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        
    }
    
    func fetchMenuItems(category: String, completion: @escaping ([MenuItem]?) -> Void) {
        
    }
    
    func submitOrder(menuIds: [Int], completion: @escaping ([Int]?) -> Void) {
        
    }
}
