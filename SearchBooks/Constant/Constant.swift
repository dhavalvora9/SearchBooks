//
//  Constant.swift
//  SearchBooks
//
//  Created by Dhaval on 13/03/22.
//

import Foundation

struct Constant {
    private struct APIs {
        static let baseURL = "https://openlibrary.org/"
        static let coversURL = "https://covers.openlibrary.org/"
    }
    
    static var searchAPI: String {
        return APIs.baseURL + "search.json?q="
    }
    
    static var imageAPI: String {
        return APIs.coversURL + "b/olid/"
    }
}
