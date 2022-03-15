//
//  BookService.swift
//  SearchBooks
//
//  Created by Dhaval on 14/03/22.
//

import Foundation
import Alamofire

protocol BookServiceProtocol {
    func searchBooks(for query: String, completion: @escaping (_ success: Bool, _ results: [Doc]?, _ error: String?) -> ())
}

class BookService: BookServiceProtocol {
    func searchBooks(for query: String, completion: @escaping (Bool, [Doc]?, String?) -> ()) {
        let requestURL = Constant.searchAPI + query
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? requestURL
        
        if let reachabilityManager = NetworkReachabilityManager(),
           reachabilityManager.isReachable {
            AF.request(encodedURL, method: .get).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        // Decode JSON data
                        let decodeed = try JSONDecoder().decode(Book.self, from: data)
                        
                        // Filter array to keep only first 10 or less results
                        let transformed = decodeed.docs.enumerated().compactMap { $0.offset < 10 ? $0.element : nil }
                        completion(true, transformed, nil)
                    } catch {
                        completion(false, nil, "Unable to parse data.")
                    }
                case .failure(let error):
                    completion(false, nil, error.errorDescription)
                }
            }
        } else {
            completion(false, nil, "The Internet connection appears to be offline.")
        }
    }
}


