//
//  Book.swift
//  SearchBooks
//
//  Created by Dhaval on 12/03/22.
//

import Foundation

// MARK: - Welcome
struct Book: Codable {
    let docs: [Doc]
}

// MARK: - Doc
struct Doc: Codable {
    let title: String
    let firstPublishYear, coverID: Int?
    let authorName, editionKey: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case firstPublishYear = "first_publish_year"
        case authorName = "author_name"
        case editionKey = "edition_key"
        case coverID = "cover_i"
    }
}

