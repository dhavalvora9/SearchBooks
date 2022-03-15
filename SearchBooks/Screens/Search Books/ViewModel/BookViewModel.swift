//
//  BookViewModel.swift
//  SearchBooks
//
//  Created by Dhaval on 14/03/22.
//

import Foundation

class BookViewModel: NSObject {
    private var bookService: BookServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var book = [Doc]()
    
    var bookCellViewModels = [BookCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(bookService: BookServiceProtocol = BookService()) {
        self.bookService = bookService
    }
    
    func searchBooks(for query: String , completion: @escaping (_ success: Bool, _ results: [Doc]?, _ error: String?) -> ()) {
        bookService.searchBooks(for: query) { success, results, error in
            if success, let books = results {
                self.fetchData(docs: books)
                completion(success, results, error)
            } else {
                completion(success, results, error)
            }
        }
    }
    
    func fetchData(docs: [Doc]) {
        self.book = docs 
        var cellViewModel = [BookCellViewModel]()
        for doc in docs {
            cellViewModel.append(createCellModel(doc: doc))
        }
        bookCellViewModels = cellViewModel
    }
    
    func createCellModel(doc: Doc) -> BookCellViewModel {
        let title: String = doc.title
        let firstPublishYear: Int? = doc.firstPublishYear
        let authorName: [String]? = doc.authorName
        let editionKey: [String]? = doc.editionKey
        let coverID: Int? = doc.coverID
        
        return BookCellViewModel(title: title, firstPublishYear: firstPublishYear, coverID: coverID, authorName: authorName, editionKey: editionKey)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BookCellViewModel {
        return bookCellViewModels[indexPath.row]
    }
}
