//
//  URL+helpers.swift
//  restaurant
//
//  Created by HhhotDog on 2018/6/4.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import Foundation

extension URL {
    func withQuery(_ query: [String: String]) -> URL? {
        var component = URLComponents(url: self, resolvingAgainstBaseURL: true)
        component?.queryItems = query.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return component?.url
    }
}
