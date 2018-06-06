//
//  MenuItemsController.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/6.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import Foundation

class MenuItemsController {
    static let shared = MenuItemsController()
    
    // MARK: - Persist
    static var archiveURL:URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("menuItems").appendingPathExtension("plist")
    }
    
    func saveToFile(with menuItems: [MenuItem]) {
        let encodeMenus = try? PropertyListEncoder().encode(menuItems)
        try? encodeMenus?.write(to: MenuItemsController.archiveURL, options: .noFileProtection)
    }
    
    func loadFromFile() -> [MenuItem]? {
        if let data = try? Data(contentsOf: MenuItemsController.archiveURL), let menuItems = try? PropertyListDecoder().decode(Array<MenuItem>.self, from: data) {
            return menuItems
        }
        return nil
    }
}
















