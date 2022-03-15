//
//  BookCellViewModel.swift
//  SearchBooks
//
//  Created by Dhaval on 13/03/22.
//

import Foundation

struct BookCellViewModel {
    var title: String
    var firstPublishYear, coverID: Int?
    var authorName, editionKey: [String]?
}
