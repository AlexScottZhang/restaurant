//
//  MenuController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class MenuController {
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://127.0.0.1:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            guard let data = data, let categories = try? JSONDecoder().decode(Categories.self, from: data) else {
                completion(nil)
                return
            }
            completion(categories.categories)
        }
        task.resume()
    }
    
    func fetchMenuItems(category: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        let menuURL = initialMenuURL.withQuery(["category": category])!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            guard let data = data , let menuItems = try? JSONDecoder().decode(MenuItems.self, from: data) else {
                completion(nil)
                return
            }
            completion(menuItems.items)
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //MARK: - POST METHOD
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let preparationTime = try? JSONDecoder().decode(PreparationTime.self, from: data) else {
                completion(nil)
                return
            }
            completion(preparationTime.prepTime)
        }
        task.resume()
    }
}












